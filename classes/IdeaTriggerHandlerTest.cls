/**
 * Test class for Idea Trigger Handler
 */
@isTest
public class IdeaTriggerHandlerTest {
	@testSetup
	static void setup(){
		Account acc = CommunityTestUtils.createAccount('IdeaTriggerHandlerTest Account');
		Contact con = CommunityTestUtils.createContact(acc.Id, 'IdeaTriggerHandlerTestEmail@testing.com');
		User user = CommunityTestUtils.createCommunityUser(con, System.Label.SuccessCommunityGuestUserProfileId );
	}
	/**
	 * Test method for updating reputation points when user submit idea.
	 */
	@IsTest
	public static void testUpdateReputationPointsOnSubmittingIdea() {
		User communityUser = [SELECT Id, AboutMe From User Where Username='IdeaTriggerHandlerTestEmail@testing.com'];
		List<NetworkMember> member = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assert(!member.isEmpty(), 'Test user is not a community user, so Network Member record is not available.');
		List<Community> community = [SELECT Name, Id FROM Community WHERE IsActive = true and Name = 'Success Community' LIMIT 1];
		System.assert(!community.isEmpty(), 'No community available to create a idea.');
		Decimal userReputationPoints = member[0].ReputationPoints;
		System.runAs(communityUser){
			Idea userIdea = new Idea();
			userIdea.Title = 'IdeaTriggerHandlerTest Idea';
			userIdea.CommunityId = community[0].Id;
			insert userIdea;
		}
		Integer reputationPointsOnSubmittingIdea;
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c FROM Reputation_Points_Configuration__mdt WHERE DeveloperName = 'Submit_An_Idea'];
		if (!reputationPointsMetadata.isEmpty()) {
			reputationPointsOnSubmittingIdea = Integer.valueOf(reputationPointsMetadata[0].Reputation_Points__c);
		}
		System.assert(!reputationPointsMetadata.isEmpty(), 'Custom metadata for reputation points on submitting idea is not available.');
		NetworkMember memberAfterUserSubmitsIdea = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assertEquals(userReputationPoints + reputationPointsOnSubmittingIdea, memberAfterUserSubmitsIdea.ReputationPoints);
	}
	/**
	 * Test method for updating reputation points when user idea gets delivered i.e idea status changed to Delivered.
	 */
	@IsTest
	public static void testUpdateReputationPointsOnIdeaDelivered() {
		User communityUser = [SELECT Id, AboutMe From User Where Username='IdeaTriggerHandlerTestEmail@testing.com'];
		List<Community> community = [SELECT Name, Id FROM Community WHERE IsActive = true and Name = 'Success Community' LIMIT 1];
		System.assert(!community.isEmpty(), 'No community available to create a idea.');
		System.runAs(communityUser){
			Idea userIdea = new Idea();
			userIdea.Title = 'IdeaTriggerHandlerTest Idea';
			userIdea.CommunityId = community[0].Id;
			insert userIdea;
		}
		List<NetworkMember> member = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assert(!member.isEmpty(), 'Test user is not a community user, so Network Member record is not available.');
		Decimal userReputationPoints = member[0].ReputationPoints;
		// Update the idea status to Delivered.
		Idea userSubmittedIdea = [SELECT Id, Status FROM Idea WHERE CreatedById = :communityUser.Id];
		userSubmittedIdea.Status = 'Delivered';
		update userSubmittedIdea;
		Integer reputationPointsOnIdeaDelivered;
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c FROM Reputation_Points_Configuration__mdt WHERE DeveloperName = 'Idea_is_Implemented'];
		if (!reputationPointsMetadata.isEmpty()) {
			reputationPointsOnIdeaDelivered = Integer.valueOf(reputationPointsMetadata[0].Reputation_Points__c);
		}
		System.assert(!reputationPointsMetadata.isEmpty(), 'Custom metadata for reputation points on delivering idea is not available.');
		NetworkMember memberAfterUserIdeaDelivered = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assertEquals(userReputationPoints + reputationPointsOnIdeaDelivered, memberAfterUserIdeaDelivered.ReputationPoints);
	}
}