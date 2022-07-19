global class AcademyCertExpirationReminderEmailsSchd implements Schedulable {
	global void execute(SchedulableContext sc) {
		// Using batch size of 20 to avoid governor limits, on sending emails and creation of email activity
		AcademyCertExpirationReminderEmailsBatch batchCtrl = new AcademyCertExpirationReminderEmailsBatch();
		Id BatchId = database.executebatch(batchCtrl, 20);
	}
}