/*
 * Controller class for Copa Updates on Community
 */
@isTest
public class copaUpdateControllerTest {
	@testSetup
	static void setup(){
		Id recordTypeId = [SELECT Id From RecordType WHERE DeveloperName = 'Copa_Update' AND SObjectType = 'Community_Announcement__c'].Id;
		List<Community_Announcement__c> caList = new List<Community_Announcement__c>();
		for(Integer i=1; i<=5; i++){
			Community_Announcement__c ca = new Community_Announcement__c();
			ca.Start_Date__c = Date.today().addDays(-i+1);
			ca.Message__c = 'Hello Tesing Copa Update ' + i;
			ca.Description_1__c = 'Description of Copa Update Title Test ' + i;
			ca.Published__c = TRUE;
			caList.add(ca);
		}
		// Copa Update of future date
		Community_Announcement__c ca = new Community_Announcement__c();
		ca.Start_Date__c = Date.today().addDays(1);
		ca.Message__c = 'Hello Tesing Copa Update future';
		ca.Description_1__c = 'Description of Copa Update Title Test future';
		ca.Published__c = TRUE;
		caList.add(ca);

		insert caList;
	}

	/*
	 * Test method to test the current Copa Update with Id
	 */
	@IsTest
	public static void testGetCurrentCopaUpdateWithId() {
		List<Community_Announcement__c> ca = [SELECT Id FROM Community_Announcement__c Order By Start_Date__c LIMIT 2];
		CommunityWrapper.ResponseWrap response = copaUpdateController.getCurrentCopaUpdate(ca[1].Id);
		CommunityWrapper.CopaUpdateDetails copaUpdate = (CommunityWrapper.CopaUpdateDetails) response.result;
		System.assertEquals(ca[1].Id, copaUpdate.Id);
	}

	/*
	 * Test method to test the Copa Update with future date Id
	 */
	@IsTest
	public static void testGetCurrentCopaUpdateOfFutureWithId() {
		Community_Announcement__c ca = [SELECT Id FROM Community_Announcement__c Order By Start_Date__c DESC LIMIT 1];
		CommunityWrapper.ResponseWrap response = copaUpdateController.getCurrentCopaUpdate(ca.Id);
		CommunityWrapper.CopaUpdateDetails copaUpdate = (CommunityWrapper.CopaUpdateDetails) response.result;
		System.assertEquals(null, copaUpdate);
	}

	/*
	 * Test method to test the Copa Update without Id
	 */
	@IsTest
	public static void testGetCurrentCopaUpdateWithoutId() {
		List<Community_Announcement__c> ca = [SELECT Id,Start_Date__c, Message__c FROM Community_Announcement__c Order By Start_Date__c DESC LIMIT 2];
		CommunityWrapper.ResponseWrap response = copaUpdateController.getCurrentCopaUpdate(null);
		CommunityWrapper.CopaUpdateDetails copaUpdate = (CommunityWrapper.CopaUpdateDetails) response.result;
		System.assertEquals(ca[1].Id, copaUpdate.Id);
	}

	/*
	 * Test method to get the most recent Copa Updates
	 */
	@IsTest
	public static void testGetRecentCopaUpdates() {
		List<Community_Announcement__c> ca = [SELECT Id FROM Community_Announcement__c Order By Start_Date__c DESC LIMIT 2];
		CommunityWrapper.ResponseWrap response = copaUpdateController.getRecentCopaUpdates(ca[1].Id, '10');
		List<CommunityWrapper.CopaUpdateDetails> copaUpdateList = (List<CommunityWrapper.CopaUpdateDetails>) response.result;
		System.assertEquals(4, copaUpdateList.size());
	}
}