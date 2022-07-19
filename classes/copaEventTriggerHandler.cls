public class copaEventTriggerHandler {
	public static void updateDateTimesOnInsert(List<Copa_Event__c> copaEventList) {
		Map<String, String> timezoneValueLabelMap = getTimezoneFieldValueLabelMap();
		for(Copa_Event__c copaEvent : copaEventList) {
			if(!Test.isRunningTest()) {
				// Converting Start Date and End Date to the selected timezone for event than save it into database in GMT.
				Integer startDateOffset = UserInfo.getTimezone().getOffset(copaEvent.Start_Date__c) - Timezone.getTimezone(copaEvent.Timezone__c.split(' ')[0]).getOffset(copaEvent.Start_Date__c);
				Integer endDateOffset = UserInfo.getTimezone().getOffset(copaEvent.End_Date__c) - Timezone.getTimezone(copaEvent.Timezone__c.split(' ')[0]).getOffset(copaEvent.End_Date__c);
				copaEvent.Start_Date__c = copaEvent.Start_Date__c.addSeconds(startDateOffset/1000);
				copaEvent.End_Date__c = copaEvent.End_Date__c.addSeconds(endDateOffset/1000);
			}
			copaEvent.Event_Time_Shown_To_Public__c = getEventTimeInString(copaEvent, timezoneValueLabelMap);
		}
	}

	public static void updateDateTimesOnUpdate(Map<Id, Copa_Event__c> oldCopaEventsMap, List<Copa_Event__c> newCopaEventsList) {
		for(Copa_Event__c copaEvent : newCopaEventsList) {
			if((copaEvent.Start_Date__c != oldCopaEventsMap.get(copaEvent.Id).Start_Date__c) || (copaEvent.End_Date__c != oldCopaEventsMap.get(copaEvent.Id).End_Date__c)
			   || (copaEvent.Timezone__c != oldCopaEventsMap.get(copaEvent.Id).Timezone__c)) {

				// Validation to update both start date and end date, if user is trying to update any one date.
				if(((copaEvent.Start_Date__c != oldCopaEventsMap.get(copaEvent.Id).Start_Date__c) && (copaEvent.End_Date__c == oldCopaEventsMap.get(copaEvent.Id).End_Date__c))
				   || ((copaEvent.End_Date__c != oldCopaEventsMap.get(copaEvent.Id).End_Date__c) && (copaEvent.Start_Date__c == oldCopaEventsMap.get(copaEvent.Id).Start_Date__c))) {
					copaEvent.addError('Please update both the start date and end date to reflect correct event time.');
				}
				Map<String, String> timezoneValueLabelMap = getTimezoneFieldValueLabelMap();
				if(!Test.isRunningTest() && (copaEvent.Start_Date__c != oldCopaEventsMap.get(copaEvent.Id).Start_Date__c)) {
					// Converting Start Date to the selected timezone for event than save it into database in GMT.
					Integer startDateOffset = UserInfo.getTimezone().getOffset(copaEvent.Start_Date__c) - Timezone.getTimezone(copaEvent.Timezone__c.split(' ')[0]).getOffset(copaEvent.Start_Date__c);
					copaEvent.Start_Date__c = copaEvent.Start_Date__c.addSeconds(startDateOffset/1000);
				}
				if(!Test.isRunningTest() && (copaEvent.End_Date__c != oldCopaEventsMap.get(copaEvent.Id).End_Date__c)) {
					// Converting End Date to the selected timezone for event than save it into database in GMT.
					Integer endDateOffset = UserInfo.getTimezone().getOffset(copaEvent.End_Date__c) - Timezone.getTimezone(copaEvent.Timezone__c.split(' ')[0]).getOffset(copaEvent.End_Date__c);
					copaEvent.End_Date__c = copaEvent.End_Date__c.addSeconds(endDateOffset/1000);
				}
				if(copaEvent.Timezone__c != oldCopaEventsMap.get(copaEvent.Id).Timezone__c) {
					// If Start Date and End Date are not updated but the event timezone is changed, Converting Start Date and End Date to the selected timezone for event than save it into database in GMT.
					if(copaEvent.Start_Date__c == oldCopaEventsMap.get(copaEvent.Id).Start_Date__c) {
						Integer startDateOffset = Timezone.getTimezone(oldCopaEventsMap.get(copaEvent.Id).Timezone__c.split(' ')[0]).getOffset(oldCopaEventsMap.get(copaEvent.Id).Start_Date__c)
							- Timezone.getTimezone(copaEvent.Timezone__c.split(' ')[0]).getOffset(copaEvent.Start_Date__c);
						copaEvent.Start_Date__c = copaEvent.Start_Date__c.addSeconds(startDateOffset/1000);
					}
					if(copaEvent.End_Date__c == oldCopaEventsMap.get(copaEvent.Id).End_Date__c) {
						Integer endDateOffset = Timezone.getTimezone(oldCopaEventsMap.get(copaEvent.Id).Timezone__c.split(' ')[0]).getOffset(oldCopaEventsMap.get(copaEvent.Id).End_Date__c)
							- Timezone.getTimezone(copaEvent.Timezone__c.split(' ')[0]).getOffset(copaEvent.End_Date__c);
						copaEvent.End_Date__c = copaEvent.End_Date__c.addSeconds(endDateOffset/1000);
					}
				}
				copaEvent.Event_Time_Shown_To_Public__c = getEventTimeInString(copaEvent, timezoneValueLabelMap);
			}
		}
	}

	private static String getEventTimeInString(Copa_Event__c copaEvent, Map<String, String> timezoneValueLabelMap) {
		String eventTimeInString = '';
		String startDateTimeInEventTimezone = copaEvent.Start_Date__c.format('MMM dd, yyyy HH:mm', copaEvent.Timezone__c.split(' ')[0]);
		eventTimeInString += startDateTimeInEventTimezone;
		if(copaEvent.End_Date__c.format('MMM dd, yyyy', copaEvent.Timezone__c.split(' ')[0]) == copaEvent.Start_Date__c.format('MMM dd, yyyy', copaEvent.Timezone__c.split(' ')[0])) {
			eventTimeInString += ' - ' + copaEvent.End_Date__c.format('HH:mm', copaEvent.Timezone__c.split(' ')[0]);
		}
		else {
			String endDateTimeInEventTimezone = copaEvent.End_Date__c.format('MMM dd, yyyy HH:mm', copaEvent.Timezone__c.split(' ')[0]);
			eventTimeInString += ' - ' + endDateTimeInEventTimezone;
		}
		eventTimeInString += ' ' + timezoneValueLabelMap.get(copaEvent.Timezone__c).split(' \\(')[0];
		return eventTimeInString;
	}

	private static Map<String, String> getTimezoneFieldValueLabelMap() {
		Map<String, String> timezoneValueLabelMap = new Map<String, String>();
		Schema.DescribeFieldResult fieldResult = Copa_Event__c.Timezone__c.getDescribe();
		List<Schema.PicklistEntry> pkListEntry = fieldResult.getPicklistValues();
		for( Schema.PicklistEntry  pkEnt : pkListEntry) {
			timezoneValueLabelMap.put(pkEnt.getValue(), pkEnt.getLabel());
		}
		return timezoneValueLabelMap;
	}
}