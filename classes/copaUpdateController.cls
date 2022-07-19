/*
 * Controller class for Copa Updates on Community
 */
public without sharing class copaUpdateController {
	@AuraEnabled(cacheable=true)
	public static CommunityWrapper.ResponseWrap getCurrentCopaUpdate(String currentCopaUpdateId) {
		try {
			List<Community_Announcement__c> communityAnnouncement = new List<Community_Announcement__c>();
			if(!String.isBlank(currentCopaUpdateId)) {
				communityAnnouncement = [SELECT Id, Start_Date__c, Message__c, Description_1__c , Description_2__c , Description_3__c FROM Community_Announcement__c
																	 WHERE RecordType.DeveloperName = 'Copa_Update' AND Published__c = TRUE
																	 AND Start_Date__c <= TODAY AND Id = :CommunityUtils.sanitizeInput(currentCopaUpdateId)];
			}
			else{
				communityAnnouncement = [SELECT Id, Start_Date__c, Message__c, Description_1__c , Description_2__c , Description_3__c FROM Community_Announcement__c
																	 WHERE RecordType.DeveloperName = 'Copa_Update' AND Published__c = TRUE
																	 AND Start_Date__c <= TODAY ORDER BY Start_Date__c DESC, CreatedDate DESC, Id DESC LIMIT 1];
			}
			if(!communityAnnouncement.isEmpty()) {
				String startDate = DateTime.newInstance(communityAnnouncement[0].Start_Date__c.year(), communityAnnouncement[0].Start_Date__c.month(), communityAnnouncement[0].Start_Date__c.day()).format('MMM dd, yyyy');
				CommunityWrapper.CopaUpdateDetails copaUpdateDetails = new CommunityWrapper.CopaUpdateDetails(communityAnnouncement[0].Id, startDate, communityAnnouncement[0].Message__c,
																											  communityAnnouncement[0].Description_1__c, communityAnnouncement[0].Description_2__c, communityAnnouncement[0].Description_3__c,
																											 '/s/copa-update?id='+communityAnnouncement[0].Id);
				return new CommunityWrapper.ResponseWrap(FALSE, NULL, copaUpdateDetails);
			}
			return new CommunityWrapper.ResponseWrap(FALSE, NULL, NULL);
		} catch (Exception ex) {
		return new CommunityWrapper.ResponseWrap(TRUE, ex.getMessage());
		}
	}

	@AuraEnabled(cacheable=true)
	public static CommunityWrapper.ResponseWrap getRecentCopaUpdates(String currentCopaUpdateId, String numberOfRecords) {
		try {
			List<CommunityWrapper.CopaUpdateDetails> copaUpdateDetailsList;

			List<Community_Announcement__c> communityAnnouncement = [SELECT Id, Start_Date__c, Message__c FROM Community_Announcement__c
									 WHERE RecordType.DeveloperName = 'Copa_Update' AND Published__c = TRUE AND Start_Date__c <= TODAY
									 AND Id != :CommunityUtils.sanitizeInput(currentCopaUpdateId) ORDER BY Start_Date__c DESC LIMIT :Integer.valueOf(numberOfRecords)];

			if(!communityAnnouncement.isEmpty()) {
				copaUpdateDetailsList = new List<CommunityWrapper.CopaUpdateDetails>();
				for(Community_Announcement__c ca : communityAnnouncement) {
					String startDate = DateTime.newInstance(ca.Start_Date__c.year(), ca.Start_Date__c.month(), ca.Start_Date__c.day()).format('MMM dd, yyyy');
					copaUpdateDetailsList.add(new CommunityWrapper.CopaUpdateDetails(ca.Id, startDate, ca.Message__c, '/s/copa-update?id='+ca.Id));
				}
				return new CommunityWrapper.ResponseWrap(FALSE, NULL, copaUpdateDetailsList);
			}
			return new CommunityWrapper.ResponseWrap(FALSE, NULL, NULL);
		} catch (Exception ex) {
		return new CommunityWrapper.ResponseWrap(TRUE, ex.getMessage());
		}
	}
}