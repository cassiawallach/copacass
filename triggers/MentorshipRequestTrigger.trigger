trigger MentorshipRequestTrigger on Mentorship_Request__c (after update) {
	if(Trigger.isAfter && Trigger.isUpdate){
		MentorshipRequestTriggerHandler.assignReputationPoints(Trigger.new, Trigger.oldMap);
	}
}