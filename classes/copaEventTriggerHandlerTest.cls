@IsTest
public class copaEventTriggerHandlerTest {
	@IsTest
	public static void testUpdateDateTimesOnInsert() {
		Id communityEventRecordTypeId = [SELECT Id From RecordType WHERE DeveloperName = 'Community_Events' AND SObjectType = 'Copa_Event__c'].Id;
		Copa_Event__c copaEvent = new Copa_Event__c();
		copaEvent.Event_Name__c = 'Test Copa Event 1';
		copaEvent.RecordTypeId = communityEventRecordTypeId;
		copaEvent.Event_Details__c = 'Test copa event details';
		copaEvent.Venue__c = 'Virtual';
		copaEvent.Timezone__c = 'Asia/Kolkata GMT+05:30';
		copaEvent.Start_Date__c = Datetime.now();
		copaEvent.End_Date__c = Datetime.now().addHours(1);
		copaEvent.Meeting_Link__c = 'https://success.copado.com';
		insert copaEvent;
		Copa_Event__c updatedCopaEvent = [SELECT Start_Date__c, End_Date__c, Event_Time_Shown_To_Public__c FROM Copa_Event__c WHERE Id = :copaEvent.Id];
		System.assertEquals(FALSE, String.IsBlank(updatedCopaEvent.Event_Time_Shown_To_Public__c));
	}

	@IsTest
	public static void testUpdateDateTimesOnUpdate() {
		Id marketingEventRecordTypeId = [SELECT Id From RecordType WHERE DeveloperName = 'Marketing_Events' AND SObjectType = 'Copa_Event__c'].Id;
		Copa_Event__c copaEvent = new Copa_Event__c();
		copaEvent.Event_Name__c = 'Test Copa Event 1';
		copaEvent.RecordTypeId = marketingEventRecordTypeId;
		copaEvent.Event_Details__c = 'Test copa event details';
		copaEvent.Venue__c = 'Virtual';
		copaEvent.Timezone__c = 'Asia/Kolkata GMT+05:30';
		copaEvent.Start_Date__c = Datetime.now();
		copaEvent.End_Date__c = Datetime.now().addHours(5);
		copaEvent.Registration_Link__c = 'https://success.copado.com';
		insert copaEvent;
		// Updating the Copa Event Start Date and End Date
		copaEvent.Start_Date__c = Datetime.now().addHours(1);
		copaEvent.End_Date__c = Datetime.now().addHours(4);
		update copaEvent;

		// Assert the updated values
		Copa_Event__c updatedCopaEvent1 = [SELECT Start_Date__c, End_Date__c, Event_Time_Shown_To_Public__c FROM Copa_Event__c WHERE Id = :copaEvent.Id];
		System.assertEquals(FALSE, String.IsBlank(updatedCopaEvent1.Event_Time_Shown_To_Public__c));
        System.assertEquals(TRUE, updatedCopaEvent1.Event_Time_Shown_To_Public__c.Contains('India Standard Time'));

		// Updating the Copa Event Timezone
		copaEvent.Timezone__c = 'America/Los_Angeles GMT-07:00';
		update copaEvent;

		// Assert the updated values
		Copa_Event__c updatedCopaEvent2 = [SELECT Start_Date__c, End_Date__c, Event_Time_Shown_To_Public__c FROM Copa_Event__c WHERE Id = :copaEvent.Id];
		System.assertEquals(FALSE, String.IsBlank(updatedCopaEvent2.Event_Time_Shown_To_Public__c));
        System.assertEquals(TRUE, updatedCopaEvent2.Event_Time_Shown_To_Public__c.Contains('Pacific Daylight Time'));
	}
}