/**
 * Controller Test class for Copa Events on community
 */
@IsTest
public class copaEventsControllerTest {
	@testSetup
	static void setup() {
		Id communityEventRecordTypeId = [SELECT Id From RecordType WHERE DeveloperName = 'Community_Events' AND SObjectType = 'Copa_Event__c'].Id;
		Id marketingEventRecordTypeId = [SELECT Id From RecordType WHERE DeveloperName = 'Marketing_Events' AND SObjectType = 'Copa_Event__c'].Id;
		List<Copa_Event__c> copaEventsList = new List<Copa_Event__c>();
		for(integer i=1; i<=4; i++) {
			Copa_Event__c copaEvent = new Copa_Event__c();
			copaEvent.Event_Name__c = 'Test Copa Event ' + i;
			if(Math.Mod(i, 2) == 0) {
				copaEvent.RecordTypeId = communityEventRecordTypeId;
			}
			else {
				copaEvent.RecordTypeId = marketingEventRecordTypeId;
			}
			copaEvent.Event_Details__c = 'Test copa event details ' + i;
			copaEvent.Venue__c = 'Virtual';
			copaEvent.Timezone__c = 'Asia/Kolkata GMT+05:30';
			copaEvent.Start_Date__c = Datetime.now().addHours(i);
			copaEvent.End_Date__c = Datetime.now().addHours(4+i);
			copaEvent.Meeting_Link__c = 'https://success.copado.com';
			copaEventsList.add(copaEvent);
		}
		insert copaEventsList;
	}

	@IsTest
	public static void testGetCopaEvents() {
		// Response for getCopaEvents method when fetched for calendar, i.e pageSize, page, tags parameter are null.
		CommunityWrapper.ResponseWrap responseOfCopaEventsForCalendar = copaEventsController.getCopaEvents(null, null, null);
		List<CommunityWrapper.CopaEventDetails> responseOfCopaEventsForCalendarResult = (List<CommunityWrapper.CopaEventDetails>) responseOfCopaEventsForCalendar.result;
		System.assertEquals(4, responseOfCopaEventsForCalendarResult.size());

		// Response for getCopaEvents method when fetched for events list.
		CommunityWrapper.ResponseWrap responseOfCopaEventsForEventList = copaEventsController.getCopaEvents(5, 1, null);
		List<CommunityWrapper.CopaEventDetails> responseOfCopaEventsForEventListResult = (List<CommunityWrapper.CopaEventDetails>) responseOfCopaEventsForEventList.result;
		System.assertEquals(4, responseOfCopaEventsForEventListResult.size());

		// Response for getCopaEvents method when fetched for events list, with search filter.
		Map<String, String> tags = new Map<String, String>();
		tags.put('searchEvent', '1');
		CommunityWrapper.ResponseWrap responseOfCopaEventsForEventListWithFilter = copaEventsController.getCopaEvents(5, 1, tags);
		List<CommunityWrapper.CopaEventDetails> responseOfCopaEventsForEventListWithFilterResult = (List<CommunityWrapper.CopaEventDetails>) responseOfCopaEventsForEventListWithFilter.result;
		System.assertEquals(1, responseOfCopaEventsForEventListWithFilterResult.size());
	}

	@IsTest
	public static void testGetAllCopaEventsCount() {
		// Response for getAllCopaEventsCount method when fetched without filters.
		CommunityWrapper.ResponseWrap responseOfCopaEventsCount = copaEventsController.getAllCopaEventsCount(null);
		Integer copaEventsCount = Integer.valueOf(responseOfCopaEventsCount.result);
		System.assertEquals(4, copaEventsCount);

		// Response for getAllCopaEventsCount method when fetched used with filters.
		Map<String, String> tags = new Map<String, String>();
		tags.put('searchEvent', '1');
		CommunityWrapper.ResponseWrap responseOfCopaEventsCountWithFilter = copaEventsController.getAllCopaEventsCount(tags);
		Integer copaEventsCountWithFilter = Integer.valueOf(responseOfCopaEventsCountWithFilter.result);
		System.assertEquals(1, copaEventsCountWithFilter);
	}

	@IsTest
	public static void testCreateCommunityEventRegistration() {
		Id communityEventRecordTypeId = [SELECT Id From RecordType WHERE DeveloperName = 'Community_Events' AND SObjectType = 'Copa_Event__c'].Id;
		Copa_Event__c communityEvent = [SELECT Id From Copa_Event__c WHERE RecordTypeId = :communityEventRecordTypeId LIMIT 1];
		CommunityWrapper.ResponseWrap response = copaEventsController.createCommunityEventRegistration(communityEvent.Id);
		System.assertEquals(FALSE, response.isError);
		System.assertEquals(TRUE, response.result);

		// Response when user tries to register in same event which he/she already registered.
		CommunityWrapper.ResponseWrap responseOnRegisterInSameEvent = copaEventsController.createCommunityEventRegistration(communityEvent.Id);
		System.assertEquals(FALSE, responseOnRegisterInSameEvent.isError);
		System.assertEquals(FALSE, responseOnRegisterInSameEvent.result);
		System.assertEquals('You are already registered in this event.', responseOnRegisterInSameEvent.message);

		// Response when user tries to register in events other than community.
		Id marketingEventRecordTypeId = [SELECT Id From RecordType WHERE DeveloperName = 'Marketing_Events' AND SObjectType = 'Copa_Event__c'].Id;
		Copa_Event__c marketingEvent = [SELECT Id From Copa_Event__c WHERE RecordTypeId = :marketingEventRecordTypeId LIMIT 1];
		CommunityWrapper.ResponseWrap responseMarketingEventRegistration = copaEventsController.createCommunityEventRegistration(marketingEvent.Id);
		System.assertEquals(FALSE, responseMarketingEventRegistration.isError);
		System.assertEquals(FALSE, responseMarketingEventRegistration.result);
		System.assertEquals('You are not authorized to register in this event.', responseMarketingEventRegistration.message);
	}
}