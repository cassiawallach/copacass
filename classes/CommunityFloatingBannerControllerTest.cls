@isTest
public class CommunityFloatingBannerControllerTest {
	@isTest
    public static void fetchFloatingBanner_test(){
        Id recordTypeId = [SELECT Id From RecordType WHERE DeveloperName = 'Marquee' AND SObjectType = 'Community_Announcement__c'].Id;
        Community_Announcement__c ca = new Community_Announcement__c();
        ca.Start_Date__c = Date.today();
        ca.End_Date__c = Date.today();
        ca.Message__c = 'Hello Tesing';
        ca.RecordTypeId = recordTypeId;
        insert ca;
        
        Test.startTest();
        List<Community_Announcement__c> caList = CommunityFloatingBannerController.fetchFloatingBanner();
        Test.stopTest();
        
        System.assertEquals(1, caList.size());
    }
}