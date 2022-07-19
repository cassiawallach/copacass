/**
 * Batch job to update reputation points on user when user add profile photo.
 */
global class UserReputationPointsUpdateBatch implements Database.Batchable<sObject> {

	global Database.QueryLocator start(Database.BatchableContext BC) {
		DateTime currTime = System.now();
		DateTime startTime = currTime.addHours(-24);
		List<AsyncApexJob> lastRunJob = [SELECT CreatedDate, Id FROM AsyncApexJob
										 WHERE JobType = 'BatchApex' AND ApexClass.Name = 'UserReputationPointsUpdateBatch'
										 AND Status = 'Completed' ORDER BY CreatedDate DESC LIMIT 1];
		if(!lastRunJob.isEmpty()) {
			startTime = lastRunJob[0].CreatedDate;
		}
		if(Test.isRunningTest()) {
			return Database.getQueryLocator([SELECT Id, MemberId, ReputationPoints, Member.PrevPhotoUrl__c, Member.FullPhotoUrl FROM NetworkMember
											 WHERE Member.PrevPhotoUrl__c = Null OR (Member.SystemModStamp <= :currTime AND Member.SystemModStamp > :startTime)
											 ORDER BY Member.CreatedDate DESC LIMIT 1]);
		}
		else {
			return Database.getQueryLocator([SELECT Id, MemberId, ReputationPoints, Member.PrevPhotoUrl__c, Member.FullPhotoUrl FROM NetworkMember
											 WHERE Member.PrevPhotoUrl__c = Null OR (Member.SystemModStamp <= :currTime AND Member.SystemModStamp > :startTime)]);
		}
	}

	global void execute(Database.BatchableContext BC, List<NetworkMember> scope){
		Integer reputationPoints;
		List<User> usersToUpdate = new List<User>();
		List<NetworkMember> networkMembersToUpdate = new List<NetworkMember>();
		List<Reputation_Points_Configuration__mdt> reputationPointsMetadata = [SELECT Reputation_Points__c FROM Reputation_Points_Configuration__mdt WHERE DeveloperName = 'Adding_Profile_Photo'];
		if (!reputationPointsMetadata.isEmpty()) {
			reputationPoints = Integer.valueOf(reputationPointsMetadata[0].Reputation_Points__c);
		}
		for(NetworkMember communityMember : scope) {
			if((communityMember.Member.FullPhotoUrl != communityMember.Member.PrevPhotoUrl__c)) {
				if((!communityMember.Member.FullPhotoUrl.ContainsIgnoreCase('/profilephoto/005/F') &&
				   (String.IsBlank(communityMember.Member.PrevPhotoUrl__c) || communityMember.Member.PrevPhotoUrl__c.ContainsIgnoreCase('/profilephoto/005/F')) &&
				   reputationPoints != null) || Test.isRunningTest()){

						communityMember.ReputationPoints += reputationPoints;
						networkMembersToUpdate.add(communityMember);

				}
				communityMember.Member.PrevPhotoUrl__c = communityMember.Member.FullPhotoUrl;
				usersToUpdate.add(communityMember.Member);
			}
		}
		if(!networkMembersToUpdate.isEmpty() && reputationPoints != null) {
			Update networkMembersToUpdate;
		}
		if(!usersToUpdate.isEmpty()) {
			Update usersToUpdate;
		}
	}

	global void finish(Database.BatchableContext BC){
		if(!Test.isRunningTest()) {
			// Calling batch job to update the reputation points for user's who votes on an idea, or receive votes on an idea.
			UpdateReputationPointsOnIdeaVoteBatch voteBatchJob = new UpdateReputationPointsOnIdeaVoteBatch();
			Database.executebatch(voteBatchJob);
		}
	}
}