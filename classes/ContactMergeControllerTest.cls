@isTest(seeAllData = true)
public class ContactMergeControllerTest {
    @isTest
    public static void mergeContactData_test(){
        List<String> conIds = new List<String>();
        for(Academy_Certification_Student__c acr : [SELECT Id, Contact__c FROM Academy_Certification_Student__c WHERE Contact__c != null LIMIT 100]){
            conIds.add(acr.Contact__c);
        }
        List<User> usr = [SELECT Id, ContactId FROM User WHERE ContactId IN :conIds AND IsPortalEnabled = true AND IsActive = true order by Id desc LIMIT 2];
        
        Test.startTest();
        ContactMergeController.mergeContactData(usr[0].ContactId, usr[0].Id, usr[1].ContactId, usr[1].Id);
        Test.stopTest();
    }
}