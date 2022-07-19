public class MentorshipRequestTriggerHandler {
	/**
	 * Updates the reputation points of the user if user becomes mentor/mentee.
	*/
	public static void assignReputationPoints(List<Mentorship_Request__c> updatedMentorshipRequest, Map<Id, Mentorship_Request__c> oldMentorshipRequest){
		Map<Id, Integer> memberIdsToGiveReputationPointsMap = new Map<Id, Integer>();
		Integer reputationPointsOfMentors;
		Integer reputationPointsOfMentee;
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c, DeveloperName
																			   FROM Reputation_Points_Configuration__mdt WHERE DeveloperName IN ('Being_a_Mentee', 'Being_a_Mentor')];
		if (!reputationPointsMetadata.isEmpty()) {
			for(Reputation_Points_Configuration__mdt metadata : reputationPointsMetadata) {
				if(metadata.DeveloperName == 'Being_a_Mentee') {
					reputationPointsOfMentee = Integer.valueOf(metadata.Reputation_Points__c);
				}
				else if(metadata.DeveloperName == 'Being_a_Mentor'){
					reputationPointsOfMentors = Integer.valueOf(metadata.Reputation_Points__c);
				}
			}
		}
		for(Mentorship_Request__c request : updatedMentorshipRequest) {
			if(request.Status__c != oldMentorshipRequest.get(request.Id).Status__c && (request.Status__c == 'Approved') && (request.Role__c == 'Mentor') && request.User__c != null && reputationPointsOfMentors != null) {
				if(memberIdsToGiveReputationPointsMap.containsKey(request.User__c)) {
					Integer reputationPointsToGive = memberIdsToGiveReputationPointsMap.get(request.User__c) + reputationPointsOfMentors;
					memberIdsToGiveReputationPointsMap.put(request.User__c, reputationPointsToGive);
				}
				else {
					memberIdsToGiveReputationPointsMap.put(request.User__c, reputationPointsOfMentors);
				}
			}
			else if(request.Status__c != oldMentorshipRequest.get(request.id).Status__c && (request.Status__c == 'Approved') && (request.Role__c == 'Mentee') && request.User__c != null && reputationPointsOfMentee != null) {
				if(memberIdsToGiveReputationPointsMap.containsKey(request.User__c)) {
					Integer reputationPointsToGive = memberIdsToGiveReputationPointsMap.get(request.User__c) + reputationPointsOfMentee;
					memberIdsToGiveReputationPointsMap.put(request.User__c, reputationPointsToGive);
				}
				else {
					memberIdsToGiveReputationPointsMap.put(request.User__c, reputationPointsOfMentee);
				}
			}
		}
		if(!memberIdsToGiveReputationPointsMap.isEmpty()){
			CommunityUtils.giveReputationPointToMembers(memberIdsToGiveReputationPointsMap);
		}
	}
}