/**
 * Test class for Collaboration Group Member Trigger handler.
 */
@isTest
public class CollaborationGroupMemberTriggerTest {
	@testSetup
	static void setup(){
		Account acc = CommunityTestUtils.createAccount('CollaborationGroupMemberTriggerTest Account');
		Contact con = CommunityTestUtils.createContact(acc.Id, 'CollaborationGroupMemberTriggerTestEmail@testing.com');
		User user = CommunityTestUtils.createCommunityUser(con, System.Label.SuccessCommunityGuestUserProfileId);
	}
	/**
	 * Test method for updating reputation points when user joins group.
	 */
	@IsTest
	public static void testAssignReputationPointsWhenUserJoinsGroup() {
		User communityUser = [SELECT Id From User Where Username='CollaborationGroupMemberTriggerTestEmail@testing.com'];
		List<NetworkMember> member = [SELECT Id, NetworkId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assert(!member.isEmpty(), 'Test user is not a community user, so Network Member record is not available.');
		Decimal userReputationPoints = member[0].ReputationPoints;
		CollaborationGroup communityGroup = CommunityTestUtils.createCollaborationGroup(member[0].NetworkId);
		System.runAs(communityUser){
			CollaborationGroupMember groupMember = new CollaborationGroupMember();
			groupMember.MemberId = communityUser.Id;
			groupMember.CollaborationGroupId = communityGroup.Id;
			insert groupMember;
		}
		Integer reputationPointsOnJoiningAGroup;
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c FROM Reputation_Points_Configuration__mdt WHERE DeveloperName = 'Joining_A_Group'];
		if (!reputationPointsMetadata.isEmpty()) {
			reputationPointsOnJoiningAGroup = Integer.valueOf(reputationPointsMetadata[0].Reputation_Points__c);
		}
		System.assert(!reputationPointsMetadata.isEmpty(), 'Custom metadata for reputation points on joining a group is not available.');
		NetworkMember memberAfterUserJoinGroup = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assertEquals(userReputationPoints + reputationPointsOnJoiningAGroup, memberAfterUserJoinGroup.ReputationPoints);
	}
	/**
	 * Test method for updating reputation points when user left group.
	 */
	@IsTest
	public static void testRemoveReputationPointsWhenUserLeftGroup() {
		User communityUser = [SELECT Id From User Where Username='CollaborationGroupMemberTriggerTestEmail@testing.com'];
		List<NetworkMember> member = [SELECT Id, NetworkId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assert(!member.isEmpty(), 'Test user is not a community user, so Network Member record is not available.');
		Decimal userReputationPoints = member[0].ReputationPoints;
		CollaborationGroup communityGroup = CommunityTestUtils.createCollaborationGroup(member[0].NetworkId);
		System.runAs(communityUser){
			CollaborationGroupMember groupMember = new CollaborationGroupMember();
			groupMember.MemberId = communityUser.Id;
			groupMember.CollaborationGroupId = communityGroup.Id;
			insert groupMember;
			// Removing the user, group member record.
			delete groupMember;
		}
		NetworkMember memberAfterUserLeftGroup = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assertEquals(userReputationPoints, memberAfterUserLeftGroup.ReputationPoints);
	}
}