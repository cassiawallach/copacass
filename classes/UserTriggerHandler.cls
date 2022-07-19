public class UserTriggerHandler {
	
	public static void userUpdates(List<User> updatedUsers){
		for(User u :updatedUsers){

			system.debug('Email before: ' + u.Email);
			system.debug('Fed Id before: ' + u.FederationIdentifier);
			system.debug('Trigger.isInsert: ' + Trigger.isInsert);
			system.debug('Trigger.isUpdate: ' + Trigger.isUpdate);

			if(u.UserType == 'Standard'
			   && ((Trigger.isInsert && (u.FederationIdentifier == null || u.FederationIdentifier == '' || u.FederationIdentifier != u.Email))
			   || (Trigger.isUpdate && (u.FederationIdentifier == null || u.FederationIdentifier == '')))
			   ){
				u.FederationIdentifier = u.Email;
			}
			system.debug('Email After: ' + u.Email);
			system.debug('Fed Id After: ' + u.FederationIdentifier);
		}
	}
	
	
    /**
* Updates the reputation points of the user if needed data is updated on user profile.
*/
    public static void updateReputationPoints(List<User> updatedUsers, Map<Id, User> oldUsers){
        Map<Id, Integer> memberIdsToGiveReputationPointsMap = new Map<Id, Integer>();
        Map<Id, Integer> memberIdsToRemoveReputationPointsMap = new Map<Id, Integer>();
        Integer reputationPoints;
        List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c FROM Reputation_Points_Configuration__mdt WHERE DeveloperName = 'User_About_Me'];
        if (!reputationPointsMetadata.isEmpty()) {
            reputationPoints = Integer.valueOf(reputationPointsMetadata[0].Reputation_Points__c);
        }
        if(reputationPoints != null) {
            for(User usr : updatedUsers) {
                if(String.IsNotBlank(usr.AboutMe) && String.IsBlank(oldUsers.get(usr.Id).AboutMe)) {
                    memberIdsToGiveReputationPointsMap.put(usr.Id, reputationPoints);
                }
                if(String.IsBlank(usr.AboutMe) && String.IsNotBlank(oldUsers.get(usr.Id).AboutMe)) {
                    memberIdsToRemoveReputationPointsMap.put(usr.Id, reputationPoints);
                }
            }
            if (!memberIdsToGiveReputationPointsMap.isEmpty()) {
                CommunityUtils.giveReputationPointToMembers(memberIdsToGiveReputationPointsMap);
            }
            if (!memberIdsToRemoveReputationPointsMap.isEmpty()) {
                CommunityUtils.removeReputationPointFromMembers(memberIdsToRemoveReputationPointsMap);
            }
        }
    }
    
    /**
    * Updates the User email on related Contact record.
    */
    /*public static void updateContactEmail(List<User> updatedUsers, Map<Id, User> oldUsers){
        List<Contact> contactsToUpdate = new List<Contact>();
        for(User usr : updatedUsers){
            if(usr.ContactId != null && usr.Email != oldUsers.get(usr.Id).Email){
                Contact con = new Contact(Id = usr.ContactId, Email = usr.Email);
            	contactsToUpdate.add(con);
            }
        }
        update contactsToUpdate;
    }*/
    
    public static void handlePartnerEmailVerification(List<User> updatedUsers, Map<Id, User> oldUsers){
        List<String> userIdsForRemovePS = new List<String>();
        for(User usr : updatedUsers){
            if(usr.ContactId != null && usr.I_am_existing_partner__c == true && usr.Corporate_Email__c != oldUsers.get(usr.Id).Corporate_Email__c){
                usr.Is_Partner_Email_Verified__c = false;
                usr.Partner_Unique_Id__c = CommunitySignupController.getUUID();
                userIdsForRemovePS.add(usr.Id);
            }            
        }
        
        if(!userIdsForRemovePS.isEmpty()){
            PartnerVerificationController.removePSFromUsers(userIdsForRemovePS);
        }
    }
}