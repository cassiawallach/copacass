trigger CollaborationGroupMemberTrigger on CollaborationGroupMember (after insert, after delete) {
	if(Trigger.isAfter && Trigger.isInsert) {
		CollaborationGroupMemberTriggerHandler.assignReputationPoints(Trigger.new);
	}
	if(Trigger.isAfter && Trigger.isDelete) {
		CollaborationGroupMemberTriggerHandler.removeReputationPoints(Trigger.old);
	}
}