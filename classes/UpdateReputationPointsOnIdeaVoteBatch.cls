/**
 * Batch job to update the reputation points on user when user vote on an idea, or receives votes on an idea.
 */
global class UpdateReputationPointsOnIdeaVoteBatch implements Database.Batchable<sObject> {

	global Database.QueryLocator start(Database.BatchableContext BC){
		DateTime currTime = System.now();
		DateTime startTime = currTime.addHours(-24);
		List<AsyncApexJob> lastRunJob = [SELECT CreatedDate, Id FROM AsyncApexJob
										 WHERE JobType = 'BatchApex' AND ApexClass.Name = 'UpdateReputationPointsOnIdeaVoteBatch'
										 AND Status = 'Completed' ORDER BY CreatedDate DESC LIMIT 1];
		if(!lastRunJob.isEmpty()) {
			startTime = lastRunJob[0].CreatedDate;
		}
		return Database.getQueryLocator([SELECT Id, Type, ParentId, CreatedById,
										 	TYPEOF Parent
										 		WHEN Idea Then CreatedById
										 	END
										 FROM Vote Where Parent.Type = 'Idea' AND (CreatedDate <= :currTime AND CreatedDate > :startTime)]);
	}

	global void execute(Database.BatchableContext BC, List<Vote> scope){
		Integer reputationPointsOnVote;
		Integer reputationPointsOnReceivingVote;
		Map<Id, Integer> memberIdsToGiveReputationPointsMap = new Map<Id, Integer>();
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c, DeveloperName FROM Reputation_Points_Configuration__mdt
																			   WHERE DeveloperName IN ('Vote_for_An_Idea', 'Receive_a_Vote_on_Your_Idea')];
		if (!reputationPointsMetadata.isEmpty()) {
			for(Reputation_Points_Configuration__mdt metadata : reputationPointsMetadata) {
				if(metadata.DeveloperName == 'Vote_for_An_Idea') {
					reputationPointsOnVote = Integer.valueOf(metadata.Reputation_Points__c);
				}
				else if(metadata.DeveloperName == 'Receive_a_Vote_on_Your_Idea') {
					reputationPointsOnReceivingVote = Integer.valueOf(metadata.Reputation_Points__c);
				}
			}
		}
		for(Vote userVote : scope) {
			Idea userIdea = userVote.Parent;
			// Filter the votes for which creator and it's parent idea creator are different.
			if(userIdea.CreatedById != userVote.CreatedById) {
				// Assign reputation points to members (users) who voted on ideas
				if(reputationPointsOnVote != null) {
					if(memberIdsToGiveReputationPointsMap.containsKey(userVote.CreatedById)) {
						Integer reputationPointsToGive = memberIdsToGiveReputationPointsMap.get(userVote.CreatedById) + reputationPointsOnVote;
						memberIdsToGiveReputationPointsMap.put(userVote.CreatedById, reputationPointsToGive);
					}
					else {
						memberIdsToGiveReputationPointsMap.put(userVote.CreatedById, reputationPointsOnVote);
					}
				}
				// Assign reputation points to members (users) who receives upvote on ideas.
				if(userVote.Type == 'Up' && reputationPointsOnReceivingVote != null) {
					if(memberIdsToGiveReputationPointsMap.containsKey(userIdea.CreatedById)) {
						Integer reputationPointsToGive = memberIdsToGiveReputationPointsMap.get(userIdea.CreatedById) + reputationPointsOnReceivingVote;
						memberIdsToGiveReputationPointsMap.put(userIdea.CreatedById, reputationPointsToGive);
					}
					else {
						memberIdsToGiveReputationPointsMap.put(userIdea.CreatedById, reputationPointsOnReceivingVote);
					}
				}
			}
		}
		if(!memberIdsToGiveReputationPointsMap.isEmpty()) {
			CommunityUtils.giveReputationPointToMembers(memberIdsToGiveReputationPointsMap);
		}
	}

	global void finish(Database.BatchableContext BC){
		if(!Test.isRunningTest()) {
			// Calling batch job to update the reputation points for user's who follow someone, or user is followed by someone.
			UpdateReputationPointsOnUserFollowBatch userFollowBatchJob = new UpdateReputationPointsOnUserFollowBatch();
			Database.executebatch(userFollowBatchJob);
		}
	}
}