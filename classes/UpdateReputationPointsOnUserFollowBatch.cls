/**
 * Batch job to update reputation points on user when user follows someone, or user is followed by someone.
 */
global class UpdateReputationPointsOnUserFollowBatch implements Database.Batchable<sObject> {

	global Database.QueryLocator start(Database.BatchableContext BC){
		DateTime currTime = System.now();
		DateTime startTime = currTime.addHours(-24);
		List<AsyncApexJob> lastRunJob = [SELECT CreatedDate, Id FROM AsyncApexJob
										 WHERE JobType = 'BatchApex' AND ApexClass.Name = 'UpdateReputationPointsOnUserFollowBatch'
										 AND Status = 'Completed' ORDER BY CreatedDate DESC LIMIT 1];
		if(!lastRunJob.isEmpty()) {
			startTime = lastRunJob[0].CreatedDate;
		}
		return Database.getQueryLocator([SELECT Id, ParentId, SubscriberId FROM EntitySubscription
										 Where Parent.Type = 'User' AND NetworkId != Null AND (CreatedDate <= :currTime AND CreatedDate > :startTime)]);
	}

	global void execute(Database.BatchableContext BC, List<EntitySubscription> scope){
		Integer reputationPointsOnGettingAFollower;
		Integer reputationPointsOnFollowingSomeone;
		Map<Id, Integer> memberIdsToGiveReputationPointsMap = new Map<Id, Integer>();
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c, DeveloperName FROM Reputation_Points_Configuration__mdt
																			   WHERE DeveloperName IN ('Getting_a_Follower', 'Following_Someone')];
		if (!reputationPointsMetadata.isEmpty()) {
			for(Reputation_Points_Configuration__mdt metadata : reputationPointsMetadata) {
				if(metadata.DeveloperName == 'Getting_a_Follower') {
					reputationPointsOnGettingAFollower = Integer.valueOf(metadata.Reputation_Points__c);
				}
				else if(metadata.DeveloperName == 'Following_Someone') {
					reputationPointsOnFollowingSomeone = Integer.valueOf(metadata.Reputation_Points__c);
				}
			}
		}
		for(EntitySubscription userFollowRecord : scope) {
			// Assign reputation points to members (users) who gets follower.
			if(reputationPointsOnGettingAFollower != null) {
				if(memberIdsToGiveReputationPointsMap.containsKey(userFollowRecord.ParentId)) {
					Integer reputationPointsToGive = memberIdsToGiveReputationPointsMap.get(userFollowRecord.ParentId) + reputationPointsOnGettingAFollower;
					memberIdsToGiveReputationPointsMap.put(userFollowRecord.ParentId, reputationPointsToGive);
				}
				else {
					memberIdsToGiveReputationPointsMap.put(userFollowRecord.ParentId, reputationPointsOnGettingAFollower);
				}
			}
			// Assign reputation points to members (users) who follows someone.
			if(reputationPointsOnFollowingSomeone != null) {
				if(memberIdsToGiveReputationPointsMap.containsKey(userFollowRecord.SubscriberId)) {
					Integer reputationPointsToGive = memberIdsToGiveReputationPointsMap.get(userFollowRecord.SubscriberId) + reputationPointsOnFollowingSomeone;
					memberIdsToGiveReputationPointsMap.put(userFollowRecord.SubscriberId, reputationPointsToGive);
				}
				else {
					memberIdsToGiveReputationPointsMap.put(userFollowRecord.SubscriberId, reputationPointsOnFollowingSomeone);
				}
			}
		}
		if(!memberIdsToGiveReputationPointsMap.isEmpty()) {
			CommunityUtils.giveReputationPointToMembers(memberIdsToGiveReputationPointsMap);
		}
	}

	global void finish(Database.BatchableContext BC){
	}
}