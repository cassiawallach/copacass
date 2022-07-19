trigger copaEventTrigger on Copa_Event__c (before insert, before update) {
	if(Trigger.isBefore && Trigger.isInsert){
		copaEventTriggerHandler.updateDateTimesOnInsert(Trigger.New);
	}
	if(Trigger.isBefore && Trigger.isUpdate) {
		copaEventTriggerHandler.updateDateTimesOnUpdate(Trigger.oldMap, Trigger.New);
	}
}