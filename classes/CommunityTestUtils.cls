/**
 * Utility class for Test Class methods of Community.
 */
@isTest
public class CommunityTestUtils {
	public static Account createAccount(String name){
		Account account = new Account(Name=name) ;
		insert account;
		return account;
	}
	public static Contact createContact(Id accountId, String email){
		Contact contact = new Contact(AccountId=accountId, FirstName='First Name test util', LastName='Last Name test util', Email=email);
		insert contact;
		return contact;
	}
	public static User createCommunityUser(Contact contact, Id communityProfileId){
		User user = new User(FirstName=contact.FirstName, LastName=contact.LastName, Email=contact.Email, ContactId=contact.Id,
								Alias='myalias', EmailEncodingKey = 'UTF-8',
								LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US',
								ProfileId=communityProfileId, Country='United States', IsActive=true,
								TimezoneSidKey='America/Los_Angeles', Username=contact.Email);

		insert user;
		return user;
	}
	public static CollaborationGroup createCollaborationGroup(Id networkId) {
		CollaborationGroup communityGroup = new CollaborationGroup();
		communityGroup.Name = 'Test Collaboration Group Group';
		communityGroup.CollaborationType = 'Public';
		communityGroup.NetworkId = networkId;
		insert communityGroup;
		return communityGroup;
	}
}