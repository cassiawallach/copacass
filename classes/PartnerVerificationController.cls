public without sharing class PartnerVerificationController {
    @AuraEnabled
    public static String verifyPartner(String userid){
        List<User> usr = [SELECT Id, Corporate_Email__c, Partner_Unique_Id__c, Is_Partner_Email_Verified__c, AccountId FROM User WHERE Partner_Unique_Id__c  = :userid AND Is_Partner_Email_Verified__c = false LIMIT 1];
        if(usr.size() > 0){
            List<String> emailParts = (usr[0].Corporate_Email__c).split('@');
            String domain = '%'+emailParts[1]+'%';
            List<Account> acc = [SELECT Id, Company_Domain_Name__c FROM Account
                                 WHERE (Type = 'Partner' OR Type = 'Channel Partner/ Reseller' OR Partner_Types__c != '')
                                 AND Company_Domain_Name__c LIKE :domain];
            if(acc.size() > 0){
                usr[0].Is_Partner_Email_Verified__c = true;
                update usr;
                
                assignPSToUsers(new List<string>{usr[0].Id});
                return 'Success';
            }else{
                throw new AuraHandledException('Your organization is not the Authorized Copado patner.');
            }
        }else{
            throw new AuraHandledException('Either You are not the Authorized Copado Community User OR you are already verified.');
        }
    }
    
    @future
    public static void assignPSToUsers(List<String> userIdsForAddPS){
        PermissionSet ps = [SELECT Id, Name FROM PermissionSet WHERE Name = 'Partner_User'];
        List<PermissionSetAssignment> psaList = new List<PermissionSetAssignment>();
        for(String uId : userIdsForAddPS){
            PermissionSetAssignment psa = new PermissionSetAssignment();
            psa.AssigneeId = uId;
            psa.PermissionSetId = ps.Id;
            psaList.add(psa);
        }
        database.insert(psaList, false);
    }
    
    @future
    public static void removePSFromUsers(List<String> userIdsForRemovePS){
        PermissionSet ps = [SELECT Id, Name FROM PermissionSet WHERE Name = 'Partner_User'];
        delete [SELECT Id FROM PermissionSetAssignment WHERE AssigneeId IN :userIdsForRemovePS AND PermissionSetId = :ps.Id];
    }
}