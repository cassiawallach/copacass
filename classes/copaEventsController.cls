/*
 * Controller class for Copa Events on Community
 */
public without sharing class copaEventsController {
	static List<String> eventIds;
	/**
	 * Method to fetch the Copa Events
	 */
	@AuraEnabled(cacheable=true)
	public static CommunityWrapper.ResponseWrap getCopaEvents (Integer pageSize, Integer page, Map<String, String> tags) {
		try {
			Integer offset;
			if(page != null && pageSize != null) {
				offset = (page - 1) * pageSize;
			}
			List<CommunityWrapper.CopaEventDetails> copaEventsList = new List<CommunityWrapper.CopaEventDetails>();
			DateTime currentDateTimeval = DateTime.now();
			String soql =
				'SELECT Id' +
				',Event_Name__c' +
				',Event_Details__c' +
				',RecordType.DeveloperName' +
				',Registration_Link__c' +
				',Start_Date__c' +
				',End_Date__c' +
				',Timezone__c' +
				',Venue__c' +
				',Location__c' +
				',Event_Time_Shown_To_Public__c' +
				' FROM Copa_Event__c' +
				' Where Start_Date__c >= :currentDateTimeval';
			String filterWhereClause = getFilterWhereClause(tags);
			if(filterWhereClause != null) {
				soql += ' AND ' + filterWhereClause;
			}
			soql += ' ORDER BY Start_Date__c';
			if(offset != null) {
				soql += ' LIMIT ' + pageSize + ' OFFSET ' + offset;
			}
			List<Copa_Event__c> copaEventRecords = Database.query(soql);
			if(!copaEventRecords.isEmpty()) {
				Set<Id> eventIds = new Set<Id>();
				for(Copa_Event__c event : copaEventRecords) {
					eventIds.add(event.Id);
				}
				Set<Id> userRegisteredEvents = new Set<Id>();
				// Fetch the user registered events only when the events list is fetched,
				// as this method is used to fetch events for datePicker and for events list component.
				if(page != null && pageSize != null) {
					userRegisteredEvents = fetchUserRegisteredEvents(eventIds);
				}
				for(Copa_Event__c event : copaEventRecords) {
					String startDate = event.Start_Date__c.format('yyyy-MM-dd', event.Timezone__c.split(' ')[0]);
					CommunityWrapper.CopaEventDetails copaEvent;
					if(page == null && pageSize == null && tags == null) {
						copaEvent = new CommunityWrapper.CopaEventDetails();
						copaEvent.Id = event.Id;
						copaEvent.StartDate = startDate;
					}
					else{
						String eventLocation = 'In-Person'.equalsIgnoreCase(event.Venue__c) ? event.Venue__c + ', ' + event.Location__c : event.Venue__c;
						copaEvent = new CommunityWrapper.CopaEventDetails(event.Id, event.Event_Name__c, event.RecordType.DeveloperName, event.Event_Details__c,
																										startDate, event.Event_Time_Shown_To_Public__c, eventLocation);
						if('Marketing_Events'.equalsIgnoreCase(copaEvent.EventType)) {
							copaEvent.RegistrationLink = event.Registration_Link__c;
						}
						if(userRegisteredEvents.Contains(event.Id)) {
							copaEvent.IsUserRegistered = true;
						}
					}
					copaEventsList.add(copaEvent);
				}
			}
			return new CommunityWrapper.ResponseWrap(FALSE, NULL, copaEventsList);
		} catch (Exception ex) {
			return new CommunityWrapper.ResponseWrap(TRUE, ex.getMessage());
		}
	}

	/**
	 * Method to fetch the Copa Events count based on filters
	 */
	@AuraEnabled(cacheable=true)
	public static CommunityWrapper.ResponseWrap getAllCopaEventsCount (Map<String, String> tags) {
		try {
			Integer copaEventsCount = 0;
			DateTime currentDateTimeval = DateTime.now();
			String soql =
				'SELECT Count(Id) CNT' +
				' FROM Copa_Event__c' +
				' Where Start_Date__c >= :currentDateTimeval';
			String filterWhereClause = getFilterWhereClause(tags);
			if(filterWhereClause != null) {
				soql += ' AND ' + filterWhereClause;
			}
			List<AggregateResult> copaEventsAggregateResult = Database.query(soql);
			if(!copaEventsAggregateResult.isEmpty()) {
				copaEventsCount = Integer.valueOf(copaEventsAggregateResult[0].get('CNT'));
			}
			return new CommunityWrapper.ResponseWrap(FALSE, NULL, copaEventsCount);
		} catch (Exception ex) {
			return new CommunityWrapper.ResponseWrap(TRUE, ex.getMessage());
		}
	}

	/**
	 * Method to create a Copa Event Registration
	 */
	@AuraEnabled
	public static CommunityWrapper.ResponseWrap createCommunityEventRegistration (String eventId) {
		try {
			if(!Auth.CommunitiesUtil.isGuestUser()) {
				if(!fetchUserRegisteredEvents(new Set<Id>{eventId}).isEmpty()) {
					return new CommunityWrapper.ResponseWrap(FALSE, 'You are already registered in this event.', FALSE);
				}
				if(checkEventType(CommunityUtils.sanitizeInput(eventId), 'Community_Events')) {
					Copa_Event_Registrations__c  eventRegistration = new Copa_Event_Registrations__c();
					eventRegistration.Copa_Event__c = eventId;
					eventRegistration.User__c = UserInfo.getUserId();
					insert eventRegistration;
					return new CommunityWrapper.ResponseWrap(FALSE, NULL, TRUE);
				}
				else {
					return new CommunityWrapper.ResponseWrap(FALSE, 'You are not authorized to register in this event.', FALSE);
				}
			}
			return new CommunityWrapper.ResponseWrap(FALSE, 'Log-In to register for this event.', FALSE);
		} catch (Exception ex) {
			return new CommunityWrapper.ResponseWrap(TRUE, ex.getMessage());
		}
	}

	/**
	 * Method to return the where clause for a dynamic query corresponding to a filters
	 */
	private static String getFilterWhereClause(Map<String, String> tags) {
		if(tags != null) {
			List<String> whereClauses = new List<String>();
			for(String tagsKey: tags.keySet()) {
				if(tagsKey.equalsIgnoreCase('searchEvent') && String.isNotBlank(tags.get(tagsKey))) {
					String newSearchText = '%' + CommunityUtils.sanitizeInput(tags.get(tagsKey)) + '%';
					whereClauses.add('(Event_Name__c LIKE \'' + newSearchText + '\')');
				}
				if(tagsKey.equalsIgnoreCase('eventsDateFilter') && String.isNotBlank(tags.get(tagsKey))) {
					eventIds = tags.get(tagsKey).split(',');
					whereClauses.add('(Id IN :eventIds)');
				}
			}
			if(!whereClauses.isEmpty()) {
				return String.join(whereClauses, ' AND ');
			}
		}
		return null;
	}

	/**
	 * Method to check the event type for a event.
	 */
	private static Boolean checkEventType(String eventId, String eventType) {
		List<Copa_Event__c> event = [SELECT RecordType.DeveloperName FROM Copa_Event__c WHERE Id = :eventId AND RecordType.DeveloperName = :eventType];
		if(!event.isEmpty()) {
			return true;
		}
		return false;
	}

	/**
	 * Method to fetch the events in which user is registered.
	 */
	private static Set<Id> fetchUserRegisteredEvents(Set<Id> eventIds) {
		Set<Id> registeredEvents = new Set<Id>();
		List<Copa_Event_Registrations__c>  eventRegistrations = [SELECT Id, Copa_Event__c FROM Copa_Event_Registrations__c
																 WHERE User__c != NULL AND User__c = :UserInfo.getUserId() AND Copa_Event__c IN :eventIds];
		for(Copa_Event_Registrations__c registration : eventRegistrations) {
			registeredEvents.add(registration.Copa_Event__c);
		}
		return registeredEvents;
	}
}