global class UserReputationPointsUpdateScheduler implements Schedulable {
	global void execute(SchedulableContext sc) {
		UserReputationPointsUpdateBatch batchCtrl = new UserReputationPointsUpdateBatch();
		Id BatchId = database.executebatch(batchCtrl);
	}
}