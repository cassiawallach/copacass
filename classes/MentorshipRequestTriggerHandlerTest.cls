/**
 * Test class for Mentorship Request Trigger Handler
 */
@isTest
public class MentorshipRequestTriggerHandlerTest {
	@testSetup
	static void setup(){
		Account acc = CommunityTestUtils.createAccount('MentorshipRequestTriggerHandlerTest Account');
		Contact con = CommunityTestUtils.createContact(acc.Id, 'MentorshipRequestTriggerHandlerTestEmail@testing.com');
		User user = CommunityTestUtils.createCommunityUser(con, System.Label.SuccessCommunityGuestUserProfileId );
	}
	/**
	 * Test method for updating reputation points when user becomes mentor.
	 */
	@IsTest
	public static void testUpdateReputationPointsOnMentor() {
		User communityUser = [SELECT Id, ContactId, Contact.Email From User Where Username='MentorshipRequestTriggerHandlerTestEmail@testing.com'];
		List<NetworkMember> member = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assert(!member.isEmpty(), 'Test user is not a community user, so Network Member record is not available.');
		Decimal userReputationPoints = member[0].ReputationPoints;
		Id mentorRecordTypeId = Schema.SObjectType.Mentorship_Request__c.getRecordTypeInfosByName().get('Mentor Request').getRecordTypeId();
		System.runAs(communityUser){
			Mentorship_Request__c userMentorshipRequest = new Mentorship_Request__c();
			userMentorshipRequest.RecordTypeId = mentorRecordTypeId;
			userMentorshipRequest.Contact__c = communityUser.ContactId;
			userMentorshipRequest.User__c = communityUser.Id;
			userMentorshipRequest.Email__c = communityUser.Contact.Email;
			userMentorshipRequest.Role__c = 'Mentor';
			userMentorshipRequest.Status__c = 'Pending Approval';
			insert userMentorshipRequest;
		}
		Mentorship_Request__c requestRecord = [SELECT Id, Status__c FROM Mentorship_Request__c];
		requestRecord.Status__c = 'Approved';
		update requestRecord;
		Integer reputationPointsOnMentor;
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c FROM Reputation_Points_Configuration__mdt WHERE DeveloperName = 'Being_a_Mentor'];
		if (!reputationPointsMetadata.isEmpty()) {
			reputationPointsOnMentor = Integer.valueOf(reputationPointsMetadata[0].Reputation_Points__c);
		}
		System.assert(!reputationPointsMetadata.isEmpty(), 'Custom metadata for reputation points on becoming a mentor is not available.');
		NetworkMember memberAfterUserBecomeMentor = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assertEquals(userReputationPoints + reputationPointsOnMentor, memberAfterUserBecomeMentor.ReputationPoints);
	}
	/**
	 * Test method for updating reputation points when user becomes mentee.
	 */
	@IsTest
	public static void testUpdateReputationPointsOnMentee() {
		User communityUser = [SELECT Id, ContactId, Contact.Email From User Where Username='MentorshipRequestTriggerHandlerTestEmail@testing.com'];
		List<NetworkMember> member = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assert(!member.isEmpty(), 'Test user is not a community user, so Network Member record is not available.');
		Decimal userReputationPoints = member[0].ReputationPoints;
		Id menteeRecordTypeId = Schema.SObjectType.Mentorship_Request__c.getRecordTypeInfosByName().get('Mentee Request').getRecordTypeId();
		System.runAs(communityUser){
			Mentorship_Request__c userMentorshipRequest = new Mentorship_Request__c();
			userMentorshipRequest.RecordTypeId = menteeRecordTypeId;
			userMentorshipRequest.Contact__c = communityUser.ContactId;
			userMentorshipRequest.User__c = communityUser.Id;
			userMentorshipRequest.Email__c = communityUser.Contact.Email;
			userMentorshipRequest.Role__c = 'Mentee';
			userMentorshipRequest.Status__c = 'Pending Approval';
			insert userMentorshipRequest;
		}
		Mentorship_Request__c requestRecord = [SELECT Id, Status__c FROM Mentorship_Request__c];
		requestRecord.Status__c = 'Approved';
		update requestRecord;
		Integer reputationPointsOnMentee;
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c FROM Reputation_Points_Configuration__mdt WHERE DeveloperName = 'Being_a_Mentee'];
		if (!reputationPointsMetadata.isEmpty()) {
			reputationPointsOnMentee = Integer.valueOf(reputationPointsMetadata[0].Reputation_Points__c);
		}
		System.assert(!reputationPointsMetadata.isEmpty(), 'Custom metadata for reputation points on becoming a mentee is not available.');
		NetworkMember memberAfterUserBecomeMentor = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId = :communityUser.Id];
		System.assertEquals(userReputationPoints + reputationPointsOnMentee, memberAfterUserBecomeMentor.ReputationPoints);
	}
}