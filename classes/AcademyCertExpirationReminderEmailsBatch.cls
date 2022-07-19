global class AcademyCertExpirationReminderEmailsBatch implements Database.Batchable<sObject> {

	global Database.QueryLocator start(Database.BatchableContext bc) {
		// Date for certification expire in next 12 weeks i.e 84 days
		Date expireInNext84Days = Date.today().addDays(84);
		// Date for certification expire in next 6 weeks i.e 42 days
		Date expireInNext42Days = Date.today().addDays(42);
		// Date for certification expire in next 3 weeks i.e 21 days
		Date expireInNext21Days = Date.today().addDays(21);
		// Date for certification expire in next 10 days
		Date expireInNext10Days = Date.today().addDays(10);
		// Date for certification expire in next 3 days
		Date expireInNext3Days = Date.today().addDays(3);
		List<Date> reminderEmailDates = new List<Date>{expireInNext84Days, expireInNext42Days, expireInNext21Days, expireInNext10Days, expireInNext3Days};

		return Database.getQueryLocator([SELECT Id, Expiration_Date__c, Certification_Program__c, Certification_Program__r.Name, Certification_Student__c, Certification_Student__r.Contact__c, Certification_Student__r.Contact__r.FirstName FROM Academy_Certification__c WHERE Status__c = 'Valid' AND Expiration_Date__c IN :reminderEmailDates]);
	}

	global void execute(Database.BatchableContext bc, List<Academy_Certification__c> scope) {
		// Date for certification expire in next 12 weeks i.e 84 days
		Date expireInNext84Days = Date.today().addDays(84);
		// Date for certification expire in next 6 weeks i.e 42 days
		Date expireInNext42Days = Date.today().addDays(42);
		// Date for certification expire in next 3 weeks i.e 21 days
		Date expireInNext21Days = Date.today().addDays(21);
		// Date for certification expire in next 10 days
		Date expireInNext10Days = Date.today().addDays(10);
		// Date for certification expire in next 3 days
		Date expireInNext3Days = Date.today().addDays(3);

		Map<String,String> contactIdWithUserIdMap = new Map<String,String>();
		Map<String,String> userIdWithContactIdMap = new Map<String,String>();

		for(Academy_Certification__c cert : scope) {
			contactIdWithUserIdMap.put(cert.Certification_Student__r.Contact__c, null);
		}

		List<User> activeUsersWithContactId = [SELECT Id, ContactId From User WHERE IsActive = TRUE AND ContactId != NULL AND ContactId IN :contactIdWithUserIdMap.KeySet()];
		for(User usr : activeUsersWithContactId) {
			contactIdWithUserIdMap.put(usr.ContactId, usr.Id);
			userIdWithContactIdMap.put(usr.Id, usr.ContactId);
		}

		// Email template for emails which are send before 12, 6, 3 weeks of certification expiration
		String firstEmailTemplateId = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Certification_Expirtn_Remdr_12_6_3_Weeks'].Id;
		// Email template for emails which are send before 10, 3 days of certification expiration
		String secondEmailTemplateId = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Certification_Expirtn_Remdr_10_3_Days'].Id;
		// Academy email org wide email id
		List<OrgWideEmailAddress> academyEmailRecord = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress WHERE Address = 'academy@copado.com' LIMIT 1];

		List<Messaging.SingleEmailMessage> emailsList = new List<Messaging.SingleEmailMessage>();
		for(Academy_Certification__c cert : scope) {
			Messaging.SingleEmailMessage email = prepareEmail(cert, contactIdWithUserIdMap, academyEmailRecord, firstEmailTemplateId, secondEmailTemplateId, expireInNext84Days, expireInNext42Days, expireInNext21Days);
			emailsList.add(email);
		}
		List<Messaging.SendEmailResult> results = Messaging.sendEmail(emailsList, false);

		Integer resultIndex = 0;
		Integer removedResultCount = 0;
		for(Messaging.SendEmailResult result : results) {
			if(!result.isSuccess()) {
				// Removing the error email record from emailList, so we can create activity for successful emails only
				emailsList.remove(resultIndex - removedResultCount);
				removedResultCount++;
			}
			resultIndex++;
		}
		setManualActivity(emailsList, academyEmailRecord, contactIdWithUserIdMap, userIdWithContactIdMap);
	}

	global void finish(Database.BatchableContext bc){

	}

	public Messaging.SingleEmailMessage prepareEmail(Academy_Certification__c cert, Map<String,String> contactIdWithUserIdMap,
													List<OrgWideEmailAddress> academyEmailRecord, String firstEmailTemplateId,
													String secondEmailTemplateId, Date expireInNext84Days, Date expireInNext42Days, Date expireInNext21Days) {

		Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

		// Checking if Contact have a user
		if(contactIdWithUserIdMap.get(cert.Certification_Student__r.Contact__c) != null) {
			// Contact are associated with a community users, so using userId in targetObjectId to avoid daily email limits of 5000
			email.setTargetObjectId(contactIdWithUserIdMap.get(cert.Certification_Student__r.Contact__c));
		}
		// Internal users don't have ContactId in their user records, so setting contactId in targetObjectId
		else {
			email.setTargetObjectId(cert.Certification_Student__r.Contact__c);
		}
		email.setReplyTo('academy@copado.com');
		if(!academyEmailRecord.isEmpty()) {
			email.setOrgWideEmailAddressId(academyEmailRecord[0].Id);
		}
		email.setWhatId(cert.Id);
		// setSaveAsActivity should be False when email sent to user
		email.setSaveAsActivity(false);
		if(cert.Expiration_Date__c == expireInNext84Days || cert.Expiration_Date__c == expireInNext42Days || cert.Expiration_Date__c == expireInNext21Days) {
			email.setTemplateId(firstEmailTemplateId);
		}
		else {
			email.setTemplateId(secondEmailTemplateId);
		}
		return email;
	}

	public void setManualActivity(List<Messaging.SingleEmailMessage> emailsList, List<OrgWideEmailAddress> academyEmailRecord,
								  Map<String,String> contactIdWithUserIdMap, Map<String,String> userIdWithContactIdMap) {

		// Creating EmailMessage Activity, corresponding to Contact and Academy Certification records
		List<EmailMessage> emailMessageList = new List<EmailMessage>();
		for(Messaging.SingleEmailMessage emailRecord : emailsList) {
			EmailMessage emailMessage = new EmailMessage();
			emailMessage.status = '3'; // email was sent
			emailMessage.fromName = (!academyEmailRecord.isEmpty()) ? academyEmailRecord[0].DisplayName : 'Copado Academy'; // from name
			emailMessage.fromAddress = (!academyEmailRecord.isEmpty()) ? academyEmailRecord[0].Address : 'academy@copado.com'; // from email address
			emailMessage.subject = emailRecord.getSubject(); // email subject
			emailMessage.htmlBody = emailRecord.gethtmlBody();
			emailMessage.TextBody = emailRecord.getPlainTextBody();
			emailMessage.relatedToId = emailRecord.getWhatId();
			//Contact Id
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