@isTest
public class DownTimeControllerTest {
	@isTest
    public static void test_fetchDownTime(){
        Down_Time__c dt = new Down_Time__c();
        dt.Start_Date__c = DateTime.now();
        dt.End_Date__c = DateTime.now();
        dt.Region__c = 'APAC';
        insert dt;
        
        dt.Start_Date__c = DateTime.now()+1;
        dt.End_Date__c = DateTime.now()+1;
        update dt;
        
        Test.startTest();
        DownTimeController.ResponseWrapper wrap = DownTimeController.fetchDownTime();
        System.assertEquals(3, wrap.downTimeRegions.size());
        System.assertEquals(5, wrap.downTimeData.size());
        Test.stopTest();
    }
}