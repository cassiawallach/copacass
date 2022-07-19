/**
 * Utility class for community
 */
public class CommunityUtils {
	/**
	 * Method to get the current logged in user with ComtactId
	*/
	public static User getLoginUser(){
		Id currentUserId = UserInfo.getUserId();
		List<User> currentUser = [SELECT Id, ContactId FROM User WHERE Id = :currentUserId];
		if(!currentUser.isEmpty()) {
			return currentUser[0];
		}
		return null;
	}

	/**
	 * Method to sanitize the inputs
	*/
	public static String sanitizeInput(String input) {
		return String.escapeSingleQuotes(input);
	}

    /*
     * Method to give reputation points to member (user)
     * @param memberIdReputationPointsMap, Map of members Id (users) with their corresponding reputation points which needs to give.
    */
    public static void giveReputationPointToMembers(Map<Id, Integer> memberIdReputationPointsMap) {
        List<NetworkMember> members = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId IN :memberIdReputationPointsMap.keySet()];
        for(NetworkMember member : members){
            member.ReputationPoints +=  memberIdReputationPointsMap.get(member.MemberId);
        }
        update members;
    }

    /*
     * Method to give reputation points to member (user)
     * @param memberIdReputationPointsMap, Map of members Id (users) with their corresponding reputation points which needs to remove.
    */
    public static void removeReputationPointFromMembers(Map<Id, Integer> memberIdReputationPointsMap) {
        List<NetworkMember> members = [SELECT Id, MemberId, ReputationPoints FROM NetworkMember WHERE MemberId IN :memberIdReputationPointsMap.keySet()];
        for(NetworkMember member : members){
            Boolean isNegative = ((member.ReputationPoints - memberIdReputationPointsMap.get(member.MemberId)) < 0);
            if(!isNegative) {
                member.ReputationPoints -=  memberIdReputationPointsMap.get(member.MemberId);
            }
        }
        update members;
    }
}