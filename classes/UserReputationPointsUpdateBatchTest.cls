/**
 * Test class for batch class which is updating reputation points on user.
 */
@isTest
public class UserReputationPointsUpdateBatchTest {
	@testSetup
	static void setup(){
		Account acc = CommunityTestUtils.createAccount('UserReputationPointsUpdateBatchTest Account');
		Contact con = CommunityTestUtils.createContact(acc.Id, 'UserReputationPointsUpdateBatchTestEmail@testing.com');
		Contact con1 = CommunityTestUtils.createContact(acc.Id, 'UserReputationPointsUpdateBatchTestEmail1@testing.com');
		User user = CommunityTestUtils.createCommunityUser(con, System.Label.SuccessCommunityGuestUserProfileId );
		User user1 = CommunityTestUtils.createCommunityUser(con1, System.Label.SuccessCommunityGuestUserProfileId );
	}
	/**
	 * Test method for updating reputation points when user vote on an idea.
	 */
	@IsTest
	public static void testUpdateReputationPointsOnIdeaVote() {
		User communityUser = [SELECT Id, FullPhotoUrl From User Where Username='UserReputationPointsUpdateBatchTestEmail@testing.com'];
		User communityUser1 = [SELECT Id, FullPhotoUrl From User Where Username='UserReputationPointsUpdateBatchTestEmail1@testing.com'];
		List<Id> communityUsersId = new List<Id>();
		communityUsersId.add(communityUser.Id);
		communityUsersId.add(communityUser1.Id);
		Map<Id, NetworkMember> member = new Map<Id, NetworkMember>([SELECT Id, NetworkId, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId IN :communityUsersId]);
		System.assert((!member.isEmpty() && member.size() == 2), 'Test user is not a community user, so Network Member record is not available.');
		List<Community> community = [SELECT Name, Id FROM Community WHERE IsActive = true and Name = 'Success Community' LIMIT 1];
		System.assert(!community.isEmpty(), 'No community available to create a idea.');
		Idea userIdea;
		System.runAs(communityUser1){
			// Creating a new idea
			userIdea = new Idea();
			userIdea.Title = 'UserReputationPointsUpdateBatchTest Idea';
			userIdea.CommunityId = community[0].Id;
			insert userIdea;
		}
		System.runAs(communityUser){
			// Giving Up vote on idea created by communityUser1
			Vote ideaVote = new Vote();
			ideaVote.ParentId = userIdea.Id;
			ideaVote.Type = 'Up';
			insert ideaVote;
		}
		Test.startTest();
		UpdateReputationPointsOnIdeaVoteBatch ctrl1 = new UpdateReputationPointsOnIdeaVoteBatch();
		DataBase.executeBatch(ctrl1);
		System.assertNotEquals(null, ctrl1, 'UpdateReputationPointsOnIdeaVoteBatch controller instance is null.');
		Test.stopTest();

		Integer reputationPointsOnVote;
		Integer reputationPointsOnReceivingVote;
		Integer reputationPointsOnSubmittingIdea;
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT DeveloperName, Reputation_Points__c FROM Reputation_Points_Configuration__mdt
																			   WHERE DeveloperName IN ('Vote_for_An_Idea', 'Receive_a_Vote_on_Your_Idea', 'Submit_An_Idea')];
		if (!reputationPointsMetadata.isEmpty()) {
			for (Reputation_Points_Configuration__mdt metadata : reputationPointsMetadata ){
				if(metadata.DeveloperName == 'Vote_for_An_Idea') {
					reputationPointsOnVote = Integer.valueOf(metadata.Reputation_Points__c);
				}
				else if(metadata.DeveloperName == 'Receive_a_Vote_on_Your_Idea') {
					reputationPointsOnReceivingVote = Integer.valueOf(metadata.Reputation_Points__c);
				}
				else if(metadata.DeveloperName == 'Submit_An_Idea') {
					reputationPointsOnSubmittingIdea = Integer.valueOf(metadata.Reputation_Points__c);
				}
			}
		}
		System.assert((reputationPointsOnVote != null), 'Custom metadata for reputation points on Vote on user idea record is not available.');
		System.assert((reputationPointsOnReceivingVote != null), 'Custom metadata for reputation points on receiving Vote on user idea record is not available.');
		System.assert((reputationPointsOnSubmittingIdea != null), 'Custom metadata for reputation points on submitting idea is not available.');
		List<NetworkMember> membersAfterReputationPointsUpdated = [SELECT Id, NetworkId, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId IN :communityUsersId];
		for(NetworkMember updatedMember : membersAfterReputationPointsUpdated) {
			if(updatedMember.MemberId == communityUser.Id) {
				System.assertEquals(member.get(updatedMember.Id).ReputationPoints + reputationPointsOnVote, updatedMember.ReputationPoints);
			}
			else if(updatedMember.MemberId == communityUser1.Id) {
				System.assertEquals(member.get(updatedMember.Id).ReputationPoints + reputationPointsOnReceivingVote + reputationPointsOnSubmittingIdea, updatedMember.ReputationPoints);
			}
		}
	}

	/**
	 * Test method for updating reputation points when user follow someone.
	 */
	@IsTest
	public static void testUpdateReputationPointsOnFollow() {
		User communityUser = [SELECT Id, FullPhotoUrl From User Where Username='UserReputationPointsUpdateBatchTestEmail@testing.com'];
		User communityUser1 = [SELECT Id, FullPhotoUrl From User Where Username='UserReputationPointsUpdateBatchTestEmail1@testing.com'];
		List<Id> communityUsersId = new List<Id>();
		communityUsersId.add(communityUser.Id);
		communityUsersId.add(communityUser1.Id);
		Map<Id, NetworkMember> member = new Map<Id, NetworkMember>([SELECT Id, NetworkId, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId IN :communityUsersId]);
		System.assert((!member.isEmpty() && member.size() == 2), 'Test user is not a community user, so Network Member record is not available.');
		List<Community> community = [SELECT Name, Id FROM Community WHERE IsActive = true and Name = 'Success Community' LIMIT 1];
		System.assert(!community.isEmpty(), 'No community available to create a idea.');
		Idea userIdea;
		System.runAs(communityUser){
			// communityUser user record starts following communityUser1 user record
			EntitySubscription followRecord = new EntitySubscription(ParentId = communityUser1.Id, SubscriberId = communityUser.Id, NetworkId = member.values()[0].NetworkId);
			insert followRecord;
		}
		Test.startTest();
		UpdateReputationPointsOnUserFollowBatch ctrl2 = new UpdateReputationPointsOnUserFollowBatch();
		DataBase.executeBatch(ctrl2);
		System.assertNotEquals(null, ctrl2, 'UpdateReputationPointsOnUserFollowBatch controller instance is null.');
		Test.stopTest();

		Integer reputationPointsOnFollow;
		Integer reputationPointsOnGettingFollower;
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT DeveloperName, Reputation_Points__c FROM Reputation_Points_Configuration__mdt
																			   WHERE DeveloperName IN ('Getting_a_Follower', 'Following_Someone')];
		if (!reputationPointsMetadata.isEmpty()) {
			for (Reputation_Points_Configuration__mdt metadata : reputationPointsMetadata ){
				if(metadata.DeveloperName == 'Following_Someone') {
					reputationPointsOnFollow = Integer.valueOf(metadata.Reputation_Points__c);
				}
				else if(metadata.DeveloperName == 'Getting_a_Follower') {
					reputationPointsOnGettingFollower = Integer.valueOf(metadata.Reputation_Points__c);
				}
			}
		}
		System.assert((reputationPointsOnFollow != null), 'Custom metadata for reputation points on follow user record is not available.');
		System.assert((reputationPointsOnGettingFollower != null), 'Custom metadata for reputation points on getting follower on user record is not available.');
		List<NetworkMember> membersAfterReputationPointsUpdated = [SELECT Id, NetworkId, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId IN :communityUsersId];
		for(NetworkMember updatedMember : membersAfterReputationPointsUpdated) {
			if(updatedMember.MemberId == communityUser.Id) {
				System.assertEquals(member.get(updatedMember.Id).ReputationPoints + reputationPointsOnFollow , updatedMember.ReputationPoints);
			}
			else if(updatedMember.MemberId == communityUser1.Id) {
				System.assertEquals(member.get(updatedMember.Id).ReputationPoints + reputationPointsOnGettingFollower, updatedMember.ReputationPoints);
			}
		}
	}

	/**
	 * Test method for testing the scheduler and batch of UserReputationPointsUpdateBatch class
	 */
	@IsTest
	public static void testScheduler(){
		Test.startTest();
		UserReputationPointsUpdateScheduler ctrl = new UserReputationPointsUpdateScheduler();
		String cronExp = '0 30 0 ? * * *';
		System.schedule('User reputation points update batch scheduler test', cronExp, ctrl);
		System.assertNotEquals(null, ctrl, 'UserReputationPointsUpdateScheduler controller instance is null.');
		Test.stopTest();
	}
}