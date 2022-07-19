/**
 * Test class for User Trigger Handler
 */
@isTest
public class UserTriggerHandlerTest {
	@testSetup
	static void setup(){
		Account acc = CommunityTestUtils.createAccount('UserTriggerHandlerTest Account');
		Contact con = CommunityTestUtils.createContact(acc.Id, 'UserTriggerHandlerTestEmail@testing.com');
		User user = CommunityTestUtils.createCommunityUser(con, System.Label.SuccessCommunityGuestUserProfileId );
		system.debug('communityUser UserType: ' + user.UserType);
	}
	/**
	 * Test method for updating reputation points on adding AboutMe in user record.
	 */
	@IsTest
	public static void testUpdateReputationPointsOnAddingAboutMe() {
		User communityUser = [SELECT Id, AboutMe From User Where Username='UserTriggerHandlerTestEmail@testing.com'];
		List<NetworkMember> member = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assert(!member.isEmpty(), 'Test user is not a community user, so Network Member record is not available.');
		Decimal userReputationPoints = member[0].ReputationPoints;
		System.runAs(communityUser){
			communityUser.AboutMe = 'My Bio added in test method.';
			update communityUser;
		}
		Integer reputationPointsOnAddingAboutMe;
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c FROM Reputation_Points_Configuration__mdt WHERE DeveloperName = 'User_About_Me'];
		if (!reputationPointsMetadata.isEmpty()) {
			reputationPointsOnAddingAboutMe = Integer.valueOf(reputationPointsMetadata[0].Reputation_Points__c);
		}
		System.assert(!reputationPointsMetadata.isEmpty(), 'Custom metadata for reputation points on Adding About Me on user record is not available.');
		NetworkMember memberAfterUserAddedAboutMe = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assertEquals(userReputationPoints + reputationPointsOnAddingAboutMe, memberAfterUserAddedAboutMe.ReputationPoints);
	}
	/**
	 * Test method for updating reputation points on removing AboutMe in user record.
	 */
	@IsTest
	public static void testUpdateReputationPointsOnRemovingAboutMe() {
		User communityUser = [SELECT Id, AboutMe From User Where Username='UserTriggerHandlerTestEmail@testing.com'];
		List<NetworkMember> member = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assert(!member.isEmpty(), 'Test user is not a community user, so Network Member record is not available.');
		Decimal userReputationPoints = member[0].ReputationPoints;
		System.runAs(communityUser){
			// Added AboutMe on User record.
			communityUser.AboutMe = 'My Bio added in test method.';
			update communityUser;
			// Removed AboutMe on User record.
			communityUser.AboutMe = null;
			update communityUser;
		}
		NetworkMember memberAfterUserRemovedAboutMe = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assertEquals(userReputationPoints, memberAfterUserRemovedAboutMe.ReputationPoints);
	}

	// Test insert User of Standard Type for automation code coverage.
	@IsTest
	public static void testNewStandardUser() {
		User user = TestDataFactory.CreateUser();
		insert user;
		update user;
		//String userId = user.Id;
		User user2 = [SELECT Id, Username, Email, FederationIdentifier, Profile.Name, UserType FROM User WHERE Id = :user.Id];
		System.debug('Username: ' + user2.Username);
		System.debug('Email: ' + user2.Email);
		System.debug('Federation ID: ' + user2.FederationIdentifier);
		System.debug('Profile: ' + user2.Profile.Name);
		System.debug('UserType: ' + user2.UserType);
		System.assert(user2.FederationIdentifier != null, 'Validate that Federation ID is populated');
	}
}