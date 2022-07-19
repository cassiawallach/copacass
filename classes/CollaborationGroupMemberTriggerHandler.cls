public class CollaborationGroupMemberTriggerHandler {
	/**
	 * Updates the reputation points of the user if join a group.
	*/
	public static void assignReputationPoints(List<CollaborationGroupMember> insertedCollaborationGroupMembers){
		Set<Id> groupIds = new Set<Id>();
		Set<Id> communityGroupIds = new Set<Id>();
		for(CollaborationGroupMember member: insertedCollaborationGroupMembers) {
			groupIds.add(member.CollaborationGroupId);
		}

		// Retrieving the community groups
		List<CollaborationGroup> communityGroups = [SELECT Id FROM CollaborationGroup WHERE NetworkId != NULL AND Id IN :groupIds];
		for(CollaborationGroup grp : communityGroups) {
			communityGroupIds.add(grp.Id);
		}
		if(!communityGroupIds.isEmpty()){
			Map<Id, Integer> memberIdsToGiveReputationPointsMap = new Map<Id, Integer>();
			Integer reputationPoints;
			List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c FROM Reputation_Points_Configuration__mdt WHERE DeveloperName = 'Joining_A_Group'];
			if (!reputationPointsMetadata.isEmpty()) {
				reputationPoints = Integer.valueOf(reputationPointsMetadata[0].Reputation_Points__c);
			}
			if(reputationPoints != null) {
				for(CollaborationGroupMember member: insertedCollaborationGroupMembers) {
					// Assign reputation points only to group members of community
					if(communityGroupIds.Contains(member.CollaborationGroupId)) {
						if(memberIdsToGiveReputationPointsMap.containsKey(member.MemberId)) {
							Integer reputationPointsToGive = memberIdsToGiveReputationPointsMap.get(member.MemberId) + reputationPoints;
							memberIdsToGiveReputationPointsMap.put(member.MemberId, reputationPointsToGive);
						}
						else {
							memberIdsToGiveReputationPointsMap.put(member.MemberId, reputationPoints);
						}
					}
				}
				if(!memberIdsToGiveReputationPointsMap.isEmpty()) {
					CommunityUtils.giveReputationPointToMembers(memberIdsToGiveReputationPointsMap);
				}
			}
		}
	}

	/**
	 * Updates the reputation points of the user if user is no longer part of a group.
	*/
	public static void removeReputationPoints(List<CollaborationGroupMember> deletedCollaborationGroupMembers){
		Set<Id> groupIds = new Set<Id>();
		Set<Id> communityGroupIds = new Set<Id>();
		for(CollaborationGroupMember member: deletedCollaborationGroupMembers) {
			groupIds.add(member.CollaborationGroupId);
		}

		// Retrieving the community groups
		List<CollaborationGroup> communityGroups = [SELECT Id FROM CollaborationGroup WHERE NetworkId != NULL AND Id IN :groupIds];
		for(CollaborationGroup grp : communityGroups) {
			communityGroupIds.add(grp.Id);
		}
		if(!communityGroupIds.isEmpty()){
			Map<Id, Integer> memberIdsToRemoveReputationPointsMap = new Map<Id, Integer>();
			Integer reputationPoints;
			List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c FROM Reputation_Points_Configuration__mdt WHERE DeveloperName = 'Joining_A_Group'];
			if (!reputationPointsMetadata.isEmpty()) {
				reputationPoints = Integer.valueOf(reputationPointsMetadata[0].Reputation_Points__c);
			}
			if(reputationPoints != null) {
				for(CollaborationGroupMember member: deletedCollaborationGroupMembers) {
					// Remove reputation points only to group members of community
					if(communityGroupIds.Contains(member.CollaborationGroupId)) {
						if(memberIdsToRemoveReputationPointsMap.containsKey(member.MemberId)) {
							Integer reputationPointsToRemove = memberIdsToRemoveReputationPointsMap.get(member.MemberId) + reputationPoints;
							memberIdsToRemoveReputationPointsMap.put(member.MemberId, reputationPointsToRemove);
						}
						else {
							memberIdsToRemoveReputationPointsMap.put(member.MemberId, reputationPoints);
						}
					}
				}
				if(!memberIdsToRemoveReputationPointsMap.isEmpty()) {
					CommunityUtils.removeReputationPointFromMembers(memberIdsToRemoveReputationPointsMap);
				}
			}
		}
	}
}