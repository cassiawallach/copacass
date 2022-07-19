public class IdeaTriggerHandler {
	/**
	 * Updates the reputation points of the user if user creates idea.
	*/
	public static void assignReputationPointsOnSubmittingIdea(List<Idea> submittedIdeas){
		Map<Id, Integer> memberIdsToGiveReputationPointsMap = new Map<Id, Integer>();
		Integer reputationPoints;
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c FROM Reputation_Points_Configuration__mdt WHERE DeveloperName = 'Submit_An_Idea'];
		if (!reputationPointsMetadata.isEmpty()) {
			reputationPoints = Integer.valueOf(reputationPointsMetadata[0].Reputation_Points__c);
		}
		if(reputationPoints != null) {
			for(Idea submittedIdea : submittedIdeas) {
				if(memberIdsToGiveReputationPointsMap.containsKey(submittedIdea.CreatedById)) {
					Integer reputationPointsToGive = memberIdsToGiveReputationPointsMap.get(submittedIdea.CreatedById) + reputationPoints;
					memberIdsToGiveReputationPointsMap.put(submittedIdea.CreatedById, reputationPointsToGive);
				}
				else {
					memberIdsToGiveReputationPointsMap.put(submittedIdea.CreatedById, reputationPoints);
				}
			}
			if(!memberIdsToGiveReputationPointsMap.isEmpty()) {
				CommunityUtils.giveReputationPointToMembers(memberIdsToGiveReputationPointsMap);
			}
		}
	}

	/*
	 * Updates the reputation points of the user if user idea is implemented i.e idea Status changed to Delivered
	*/
	public static void assignReputationPointsWhenIdeaImplemented(List<Idea> updatedIdeas, Map<Id, Idea> oldIdeas) {
		Map<Id, Integer> memberIdsToGiveReputationPointsMap = new Map<Id, Integer>();
		Integer reputationPoints;
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c FROM Reputation_Points_Configuration__mdt WHERE DeveloperName = 'Idea_is_Implemented'];
		if (!reputationPointsMetadata.isEmpty()) {
			reputationPoints = Integer.valueOf(reputationPointsMetadata[0].Reputation_Points__c);
		}
		if(reputationPoints != null) {
			for(Idea userIdea : updatedIdeas) {
				if(userIdea.Status != oldIdeas.get(userIdea.Id).Status && (userIdea.Status == 'Delivered')) {
					if(memberIdsToGiveReputationPointsMap.containsKey(userIdea.CreatedById)) {
						Integer reputationPointsToGive = memberIdsToGiveReputationPointsMap.get(userIdea.CreatedById) + reputationPoints;
						memberIdsToGiveReputationPointsMap.put(userIdea.CreatedById, reputationPointsToGive);
					}
					else {
						memberIdsToGiveReputationPointsMap.put(userIdea.CreatedById, reputationPoints);
					}
				}
			}
			if(!memberIdsToGiveReputationPointsMap.isEmpty()) {
				CommunityUtils.giveReputationPointToMembers(memberIdsToGiveReputationPointsMap);
			}
		}
	}
}