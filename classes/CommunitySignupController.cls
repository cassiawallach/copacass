global without sharing class CommunitySignupController  {
    
    @AuraEnabled
    public static InitDataWrapper fetchInitData(){
        InitDataWrapper wrap = new InitDataWrapper();
        
        SObjectField picklistUsingGlobal = SObjectType.Contact.fields.Job_Role__c.getSObjectField();
        List<PicklistEntry> entries = picklistUsingGlobal.getDescribe().getPicklistValues();
        List<String> jobRoleList = new List<String>();
        for(PicklistEntry pl : entries){
            if(pl.getLabel() != 'Other'){
                jobRoleList.add(pl.getLabel());
            }
        }
        
        List<Country__mdt> countries = [SELECT Id, MasterLabel, Country_Code__c FROM Country__mdt ORDER BY MasterLabel];
        List<String> countryList = new List<String>();
        for(Country__mdt con : countries){
            countryList.add(con.MasterLabel);
        }
        
        List<State__mdt> states = [SELECT Id, MasterLabel, Country__c, Country__r.MasterLabel, State_Code__c FROM State__mdt ORDER BY MasterLabel];
        Map<String, List<String>> stateMap = new Map<String, List<String>>();
        List<String> stateList;
        for(State__mdt st : states){
            stateList = stateMap.containsKey(st.Country__r.MasterLabel) ? stateMap.get(st.Country__r.MasterLabel) : new List<String>();
            stateList.add(st.MasterLabel);
            stateMap.put(st.Country__r.MasterLabel, stateList);
        }
        
        wrap.jobRoleList = jobRoleList;
        wrap.countryList = countryList;
        wrap.stateMap = stateMap;
        return wrap;
    }
    
    @AuraEnabled
    public static responseWrap createCommunityUser(String jsonUser){
        ResponseWrap response = new ResponseWrap();
        response.status=false;
        
        UserWrap userWrapObj = userParse(jsonUser);
        
        list<User> userList = [SELECT Id,email FROM USER WHERE UserName =: userWrapObj.email AND IsActive = TRUE];
        if(userList.size()==0){
            String accountId = SYSTEM.LABEL.SuccessCommunityGuestUserAccountId;
            if(Test.isRunningTest()){
                accountId = [Select Id from account limit 1].id;
            }
            list<Account_email_Domain__c> accountemailDomainlist = new list<Account_email_Domain__c>();
            if(String.isNotBlank(userWrapObj.corporateEmail) ){
                String userEmailDomain = userWrapObj.corporateEmail.split('@')[1];
                accountemailDomainlist = new list<Account_email_Domain__c>([SELECT Id,Account__c,Domain__c FROM Account_email_Domain__c WHERE domain__c =: userEmailDomain LIMIT 1]);
                if(accountemailDomainlist.size()>0){
                    if(accountemailDomainlist.get(0).Account__c!=NULL){
                        // accountId = accountemailDomainlist.get(0).Account__c;
                    }
                }
            }
            
            Account accountObj = [SELECT Id,OwnerId FROM Account WHERE Id =:accountId LIMIT 1];
            
            contact conObj = new contact();
            conObj.firstName = userWrapObj.firstName;
            conObj.lastName = userWrapObj.lastName;
            conObj.email = userWrapObj.email;
            conObj.AccountId = accountObj.Id;
            conObj.OwnerId = accountObj.OwnerId;
            conObj.Corporate_Email__c = userWrapObj.corporateEmail;
            conObj.Job_Role__c = userWrapObj.jobRole;
            conObj.Job_Role_Other__c = userWrapObj.jobRoleOther;
            conObj.Title = userWrapObj.title;
            conObj.MailingCountry = userWrapObj.country;
            conObj.MailingCity = userWrapObj.city;
            conObj.MailingState = userWrapObj.state;
            conObj.MailingPostalCode = userWrapObj.zipcode;
            conObj.I_am_existing_customer__c = false;
            conObj.I_am_existing_partner__c = false;
            if(userWrapObj.iAmExistingCustomer!=null && userWrapObj.iAmExistingCustomer){
                conObj.I_am_existing_customer__c = userWrapObj.iAmExistingCustomer;
            }
            if(userWrapObj.iAmExistingPartner!=null && userWrapObj.iAmExistingPartner){
                conObj.I_am_existing_partner__c = userWrapObj.iAmExistingPartner;
            }
            Insert conObj;
            
            string nick = conObj.email!=null?conObj.email.substring(0, conObj.email.indexOf('@')):'';
            nick += Datetime.now().getTime();
            
            User u = new User(
                Alias = userWrapObj.email.substring(0,3), 
                email=userWrapObj.email, 
                emailEncodingKey='UTF-8', 
                lastName=userWrapObj.lastName,
                firstName=userWrapObj.firstName, 
                LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', 
                ProfileId = SYSTEM.LABEL.SuccessCommunityGuestUserProfileId, 
                IsActive =true,
                CommunityNickname =nick,
                TimeZoneSidKey='GMT',
                UserName=userWrapObj.email
            );
            u.contactId = conObj.Id;
            u.CompanyName = userWrapObj.companyName;
            u.country = userWrapObj.country;
            u.city = userWrapObj.city;
            u.Job_Role__c = userWrapObj.jobRole;
            u.Job_Role_Other__c = userWrapObj.jobRoleOther;
            u.State = userWrapObj.state;
            u.PostalCode = userWrapObj.zipcode;
            u.Title = userWrapObj.title;
            u.Corporate_Email__c = userWrapObj.corporateEmail;
            u.How_To_Know_Community__c  = userWrapObj.howToKnowCopado;
            u.Referral_Code__c = userWrapObj.referalCode;
            u.I_am_existing_customer__c = false;
            u.I_am_existing_partner__c = false;
            u.Partner_Unique_Id__c = getUUID();
            u.Is_Partner_Email_Verified__c = false;
            
            if(userWrapObj.iAmExistingCustomer!=null && userWrapObj.iAmExistingCustomer){
                if(accountemailDomainlist.size()>0){
                    u.ProfileId = SYSTEM.LABEL.SuccessCustomerCommunityUserProfileId;
                }
                u.I_am_existing_customer__c = userWrapObj.iAmExistingCustomer;
            }
            if(userWrapObj.iAmExistingPartner!=null && userWrapObj.iAmExistingPartner){
                if(accountemailDomainlist.size()>0){
                    u.ProfileId = SYSTEM.LABEL.SuccessPartnerCommunityUserProfileId;
                }
                u.I_am_existing_partner__c = userWrapObj.iAmExistingPartner;
            }
            Insert u;

            if(u.I_am_existing_partner__c && !u.Is_Partner_Email_Verified__c && String.isNotBlank(u.Corporate_Email__c)) {
                List<String> toAddresses = new List<String>{u.Corporate_Email__c};
                sendCorporateEmailVerificationSingleMail(u, toAddresses);
            }
            
            response.message= 'UserId::'+u.id;
        }
        else{
            response.status= true;
            response.message= 'duplicate email';
        }
        return response;
    }

    /*
     * Method to send the corporate email verification email on user corporate email.
     */ 
    public static void sendCorporateEmailVerificationSingleMail(User user, List<String> toAddresses){
        List<OrgWideEmailAddress> orgWideEmail = [SELECT Id, Address FROM OrgWideEmailAddress WHERE Address = 'cs@copado.com'];
        List<EmailTemplate> emailTemplate = [SELECT Id, Subject, HtmlValue, Body FROM EmailTemplate WHERE DeveloperName = 'Partner_User_Corporate_Email_Verification'];
        
        // process the merge fields
        String subject = emailTemplate[0].Subject;
        
        String htmlBody = emailTemplate[0].HtmlValue;
        htmlBody = htmlBody.replace('{!Target_User.FirstName}', user.FirstName);
        htmlBody = htmlBody.replace('{!Target_User.Partner_Unique_Id__c}', user.Partner_Unique_Id__c);
        htmlBody = htmlBody.replace('{!$Label.Copado_Community_URL}', Label.Copado_Community_URL);
        
        String plainBody = emailTemplate[0].Body;
        plainBody = plainBody.replace('{!Target_User.FirstName}', user.FirstName);
        plainBody = plainBody.replace('{!Target_User.Partner_Unique_Id__c}', user.Partner_Unique_Id__c);
        plainBody = plainBody.replace('{!$Label.Copado_Community_URL}', Label.Copado_Community_URL);
        
        //build the email message
        Messaging.Singleemailmessage email = new Messaging.Singleemailmessage();
        email.setReplyTo(orgWideEmail[0].Address);
        email.setOrgWideEmailAddressId(orgWideEmail[0].Id);
        email.settoAddresses(toAddresses);
        email.setSaveAsActivity(false);
        email.setSubject(subject);
        email.setHtmlBody(htmlBody);
        email.setPlainTextBody(plainBody);
        
        List<Messaging.SendEmailResult> results = Messaging.sendEmail(new Messaging.SingleEmailmessage[] {email}, false);
    }
    
    public class ResponseWrap{
        @AuraEnabled Public boolean status;
        @AuraEnabled Public String message;
    }
    
    public class UserWrap{
        public String firstName;
        public String lastName;
        public String email;
        public String jobRole;
        public String jobRoleOther;
        public String country;
        public String state;
        public String city;
        public String zipcode;
        public String companyName;
        public String corporateEmail;
        public String howToKnowCopado;
        public String referalCode;
        public String title;
        public boolean iAmExistingCustomer;
        public boolean iAmExistingPartner;
    }
    
    public class InitDataWrapper{
        @AuraEnabled public List<String> jobRoleList;
        @AuraEnabled public List<String> countryList;
        @AuraEnabled public Map<String, List<String>> stateMap;
    }
    
    public static UserWrap userParse(String json) {
        return (UserWrap) System.JSON.deserialize(json, UserWrap.class);
    }
    
    public static String getUUID()
    {
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
        return guid;
    }
}