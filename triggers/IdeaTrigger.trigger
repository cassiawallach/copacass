trigger IdeaTrigger on Idea (after insert, after update) {
	if(Trigger.isAfter && Trigger.isInsert){
		IdeaTriggerHandler.assignReputationPointsOnSubmittingIdea(Trigger.new);
	}
	if(Trigger.isAfter && Trigger.isUpdate) {
		IdeaTriggerHandler.assignReputationPointsWhenIdeaImplemented(Trigger.new, Trigger.oldMap);
	}
}