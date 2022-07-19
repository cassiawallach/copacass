@isTest
public class PartnerVerificationControllerTest {
    @isTest
    public static void test_verifyPartner(){
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='jss@testorg.com', Corporate_Email__c = 'jss@testorg.com',
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, Partner_Unique_Id__c = 'test123',
                          TimeZoneSidKey='America/Los_Angeles', UserName='jss@testorg.com');
        
        System.runAs(u) {
            Account acc = new Account(Name = 'Test User', Company_Domain_Name__c = '@testorg.com', Type = 'Partner');
            Insert acc;
            
            Test.startTest();
            PartnerVerificationController.verifyPartner('test123');
            Test.stopTest();
            
            User usr = [SELECT Id, Is_Partner_Email_Verified__c FROM User WHERE Email='jss@testorg.com' LIMIT 1];
            System.assertEquals(true, usr.Is_Partner_Email_Verified__c);
        }
    }
}