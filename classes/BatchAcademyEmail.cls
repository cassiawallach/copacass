global with sharing class BatchAcademyEmail implements Database.Batchable<Id>, Database.Stateful {

    public List<Id> targetObjectIds;
    public String templateId;
    public String orgWideEmailId;
    public String emailWhatId;
    public String attachmentResultBody;
    public Integer totalError = 0;
    public Integer totalSuccess = 0;
    public String typeOfEmail;
    global Iterable<Id> start(Database.BatchableContext bc) {
        List<Attachment> resultAttachments = [SELECT Id FROM Attachment WHERE Name = 'Maintenance Open Mail Results' AND ParentId = :emailWhatId];
        if(resultAttachments.size() > 0 && typeOfEmail != 'Reminder'){
            targetObjectIds.clear();
        }
        attachmentResultBody = 'targetObjectIds: ' + targetObjectIds + '\n';
        attachmentResultBody += 'templateId: ' + templateId + '\n';
        attachmentResultBody += 'orgWideEmailId: ' + orgWideEmailId + '\n';
        attachmentResultBody += 'emailWhatId: ' + emailWhatId + '\n';
        return targetObjectIds;
    }

    global void execute(Database.BatchableContext bc, List<Id> targetObjIds) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for(Id toid : targetObjIds) {
            emails.add(prepareEmailMessage(toid));
        }
        //commented out in the initial deployment to do a test
        List<Messaging.SendEmailResult> results = Messaging.sendEmail(emails, false);
        for(Messaging.SendEmailResult rslt : results) {
            if(!rslt.isSuccess()) {
                totalError += 1;
                attachmentResultBody += 'Target object id: ' + rslt.errors[0].targetObjectId + ' ' + rslt.errors[0].message + '\n';
            } else {
                totalSuccess += 1;
            }
        }
        if(typeOfEmail == 'Announcement') {
            Integer resultIndex = 0;
            Integer removedResultCount = 0;
            for(Messaging.SendEmailResult result : results) {
                if(!result.isSuccess()) {
                    // Removing the error email record from emailList, so we can create activity for successful emails only
                    emails.remove(resultIndex - removedResultCount);
                    removedResultCount++;
                }
                resultIndex++;
            }
            setManualActivity(emails, targetObjIds);
        }
    }
    global void finish(Database.BatchableContext bc) {
        String attBody = '\nEmail sending for maintenance done: ' + emailWhatId;
        attBody += '\nTotal success: ' + totalSuccess;
        attBody += '\n ' + attachmentResultBody;
        String attName = typeOfEmail == 'Reminder' ? 'Reminder for ' + Date.today() : 'Maintenance Open Mail Results';
        Attachment resultAttachment = new Attachment(Name = attName, Body = Blob.valueOf(attBody), ParentId = emailWhatId);
        insert resultAttachment;
    }

    public Messaging.SingleEmailMessage prepareEmailMessage(String targetObjectId) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setTargetObjectId(targetObjectId);
        email.setReplyTo('academy@copado.com');
        if(String.isNotBlank(orgWideEmailId)) {
            email.setOrgWideEmailAddressId(orgWideEmailId);
        }
        if(String.isNotBlank(emailWhatId)) {
            email.setWhatId(emailWhatId);
        }
        if(typeOfEmail == 'Announcement') {
            email.setSaveAsActivity(false);
        }
        else {
            email.setSaveAsActivity(true);
        }
        email.setTemplateId(templateId);
        return email;
    }

    public void setManualActivity(List<Messaging.SingleEmailMessage> emailsList, List<Id> targetObjIds) {
        // Creating EmailMessage Activity, corresponding to Contact and Learning Plan records
        Map<String,String> contactIdWithUserIdMap = new Map<String,String>();
        Map<String,String> userIdWithContactIdMap = new Map<String,String>();
        // Finding userIds from targetObjIds
        List<User> activeUsersWithContactId = [SELECT Id, ContactId From User WHERE IsActive = TRUE AND Id IN :targetObjIds];
        for(User usr : activeUsersWithContactId) {
            contactIdWithUserIdMap.put(usr.ContactId, usr.Id);
            userIdWithContactIdMap.put(usr.Id, usr.ContactId);
        }
        // Finding contactIds from targetObjIds
        for(Id targetObjId : targetObjIds) {
            if(!userIdWithContactIdMap.containsKey(targetObjId)) {
                contactIdWithUserIdMap.put(targetObjId, null);
            }
        }
        List<EmailMessage> emailMessageList = new List<EmailMessage>();
        for(Messaging.SingleEmailMessage emailRecord : emailsList) {
            EmailMessage emailMessage = new EmailMessage();  
            emailMessage.status = '3'; // email was sent  
            emailMessage.fromName = 'Copado Academy'; // from name  
            emailMessage.fromAddress = 'academy@copado.com'; // from email address  
            emailMessage.subject = emailRecord.getSubject(); // email subject  
            emailMessage.htmlBody = emailRecord.gethtmlBody();
            emailMessage.TextBody = emailRecord.getPlainTextBody();
            emailMessage.relatedToId = emailRecord.getWhatId(); 
            //Setting activity corresponding to Contact
            List<String> toIds = new List<String>();
            if (contactIdWithUserIdMap.ContainsKey(emailRecord.getTargetObjectId())) {
                toIds.add(emailRecord.getTargetObjectId());
            }
            else if(userIdWithContactIdMap.ContainsKey(emailRecord.getTargetObjectId())) {
                toIds.add(userIdWithContactIdMap.get(emailRecord.getTargetObjectId()));
            }
            if(!toIds.isEmpty()) {
                emailMessage.toIds = toIds;  
                emailMessageList.add(emailMessage);
            }
        }
        if(!emailMessageList.isEmpty()) {
            insert emailMessageList;
        }
        
        // Add Email Message Relation for id of the sender  
        List<EmailMessageRelation> emailMessageRelationList = new List<EmailMessageRelation>();
        for(EmailMessage emailMessage : emailMessageList) {  
            EmailMessageRelation emr = new EmailMessageRelation();  
            emr.emailMessageId = emailMessage.Id;  
            emr.relationId = emailMessage.toIds[0]; // Contact Id  
            emr.relationType = 'ToAddress'; 
            emailMessageRelationList.add(emr);
        }
        if(!emailMessageRelationList.isEmpty()) {
            insert emailMessageRelationList;
        }
    }
}