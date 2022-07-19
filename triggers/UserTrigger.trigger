trigger UserTrigger on User (before insert,before update,after update) {
	if(Trigger.isBefore){
		UserTriggerHandler.userUpdates(Trigger.new);
	}
    
	if(Trigger.isAfter && Trigger.isUpdate){
		UserTriggerHandler.updateReputationPoints(Trigger.new, Trigger.oldMap);
	}
}