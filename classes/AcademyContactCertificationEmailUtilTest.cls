@IsTest
public class AcademyContactCertificationEmailUtilTest {
	@TestSetup
	static void setupData() {
		Academy_Certification_Program__c acp = new Academy_Certification_Program__c();
		acp.Name = 'ADMINISTRATOR';
		acp.Status__c = 'Valid';
		acp.Copado_Version__c = 'v15';
		insert acp;

		Academy_Certification_Program__c acp1 = TestDataFactory.createCertificationProgram();
		insert acp1;

		redwing__Achievement__c achievement = TestDataFactory.createAchievement('Certifications',acp.Id);
		insert achievement;

		List<redwing__Training_Plan__c> trainingPlan = new List<redwing__Training_Plan__c>();
		redwing__Training_Plan__c maintenance = new redwing__Training_Plan__c();
		maintenance.Name = 'Admin Maintenance';
		maintenance.Module_Community_URL__c = 'https://success.copado.com';
		maintenance.Is_Maintenance_Plan__c = true;
		maintenance.redwing__Start_Date__c = Date.today().addDays(-10);
		maintenance.redwing__End_Date__c = Date.today().addDays(1);
		maintenance.Maintenance_Expiration_Date__c = Date.today().addDays(1);
		maintenance.Schedule_Days_for_Reminder__c = '1';
		trainingPlan.add(maintenance);

		redwing__Training_Plan__c certTPlan = TestDataFactory.createTrainingPlan('ADMINISTRATOR T Plan');
		trainingPlan.add(certTPlan);
		insert trainingPlan;

		redwing__Training_Plan_Achievement__c trainingPlanAchievement = TestDataFactory.createTriningPlanAchievement(achievement.Id,trainingPlan[1].Id);
		INSERT trainingPlanAchievement;

		redwing__Learning__c learning = new redwing__Learning__c();
		learning.Name = 'Admin Maintenance';
		learning.Academy_Certification_Program__c = acp.Id;
		learning.redwing__Published__c = true;
		insert learning;

		redwing__Training_Plan_Section__c tps = new redwing__Training_Plan_Section__c();
		tps.Name = 'Admin Certification Maintenance';
		tps.redwing__Training_Plan__c = maintenance.Id;
		insert tps;

		redwing__Training_Plan_Section_Item__c tpsc = new redwing__Training_Plan_Section_Item__c();
		tpsc.redwing__Training_Plan_Section__c = tps.Id;
		tpsc.redwing__Learning__c = learning.Id;
		insert tpsc;

		List<Contact> academyContacts = new List<Contact>();

		Contact academyContact = new Contact();
		academyContact.FirstName = 'Academy';
		academyContact.LastName = 'Test';
		academyContact.Email = 'academyTest@copado.com';
		insert academyContact;

		redwing__Achievement_Assignment__c achievementAssignment = new redwing__Achievement_Assignment__c();
		achievementAssignment.redwing__Contact__c = academyContact.Id;
		achievementAssignment.redwing__Training_Plan_Achievement__c = trainingPlanAchievement.Id;
		achievementAssignment.redwing__Achievement__c = achievement.Id;
		achievementAssignment.redwing__Acquisition_Date__c = System.today();
		achievementAssignment.redwing__Status__c = 'Acquired';
		insert achievementAssignment;

		redwing__Training_Plan_Assignment__c trainingPlanAssignment = TestDataFactory.createTrainingPlanAssignment(userinfo.getUserId(),academyContact.Id, trainingPlan[0].Id);
		trainingPlanAssignment.redwing__Status__c = 'Completed';
		insert trainingPlanAssignment;
	}

	@IsTest
	static void testGetContactAcademyCertification(){
		redwing__Training_Plan__c currentPlan = [SELECT Id, redwing__Start_Date__c FROM redwing__Training_Plan__c WHERE Name = 'Admin Maintenance'];
		Academy_Certification_Program__c acp = [SELECT Id FROM Academy_Certification_Program__c WHERE Name = 'ADMINISTRATOR'];
		Contact academyContact = [SELECT Id,Email FROM Contact WHERE LastName = 'Test'];

		Academy_Certification_Student__c academyStudent = new Academy_Certification_Student__c();
		academyStudent.Contact__c = academyContact.Id;
		academyStudent.Student_Email__c = academyContact.Email;
		insert academyStudent;

		Academy_Certification__c ac = new Academy_Certification__c();
		ac.Certification_Program__c = acp.Id;
		ac.Certification_Student__c = academyStudent.Id;
		ac.Status__c = 'Valid';
		insert ac;

		Academy_Certification_Examination__c ace = new Academy_Certification_Examination__c();
		ace.Academy_Certification2__c = ac.Id;
		ace.Certification_Student__c = ac.Certification_Student__c;
		ace.Certification_Program__c = acp.Id;
		ace.Status__c = 'Approved';
		ace.Date__c = Date.today().addMonths(-1);
		insert ace;

		ac.Certification_Examination__c = ace.Id;
		update ac;

		// Test for Maintenance Result
		AcademyContactCertificationEmailUtilCtlr vfComponentObj2 = new AcademyContactCertificationEmailUtilCtlr();
		vfComponentObj2.emailTypeApex = 'MaintenanceResult';
		vfComponentObj2.contactIdApex = academyContact.Id;
		vfComponentObj2.currentPlanIdApex = currentPlan.Id;
		Academy_Certification__c acCertificateOfMaintenanceAnnouncement2 = vfComponentObj2.getContactAcademyCertification();

		System.assertNotEquals(null, acCertificateOfMaintenanceAnnouncement2, 'Academy Certification expected result should not be null');
		System.assertEquals(Date.newInstance(ace.Date__c.year() + 1, ace.Date__c.month(), ace.Date__c.day()), acCertificateOfMaintenanceAnnouncement2.Expiration_Date__c);
		System.assertEquals(academyStudent.Id, acCertificateOfMaintenanceAnnouncement2.Certification_Student__c);
		System.assertEquals(ac.Id, acCertificateOfMaintenanceAnnouncement2.Id);
	}

	@IsTest
	static void testGetContactAcademyCertificationNegative(){
		redwing__Training_Plan__c currentPlan = [SELECT Id, redwing__Start_Date__c FROM redwing__Training_Plan__c WHERE Name = 'Admin Maintenance'];
		Contact academyContact = [SELECT Id,Email FROM Contact WHERE LastName = 'Test'];

		AcademyContactCertificationEmailUtilCtlr vfComponentObj = new AcademyContactCertificationEmailUtilCtlr();
		vfComponentObj.contactIdApex = academyContact.Id;
		vfComponentObj.currentPlanIdApex = currentPlan.Id;
		Academy_Certification__c acCertificateOfMaintenanceAnnouncement = vfComponentObj.getContactAcademyCertification();

		System.assertEquals(null, acCertificateOfMaintenanceAnnouncement);
	}


	@IsTest
	static void testGetLearningPlan(){
		redwing__Training_Plan__c currentPlan = [SELECT Id, Module_Community_URL__c,Maintenance_Expiration_Date__c FROM redwing__Training_Plan__c WHERE Name = 'Admin Maintenance'];
		Academy_Certification_Program__c acp = [SELECT Id FROM Academy_Certification_Program__c WHERE Name = 'ADMINISTRATOR'];

		// Test for Reminder 1 (12, 6, 3 weeks before the certificate expiration date)
		AcademyContactCertificationEmailUtilCtlr vfComponentObj = new AcademyContactCertificationEmailUtilCtlr();
		vfComponentObj.emailTypeApex = 'Reminder1';
		vfComponentObj.currentAcademyCertProgramIdApex = acp.Id;
		redwing__Training_Plan__c learningPlan = vfComponentObj.getLearningPlan();

		System.assertNotEquals(null, learningPlan, 'Learning Plan expected result should not be null');
		System.assertEquals(currentPlan.Module_Community_URL__c, learningPlan.Module_Community_URL__c);
		System.assertEquals(currentPlan.Maintenance_Expiration_Date__c, learningPlan.Maintenance_Expiration_Date__c);

		// Test for Reminder 2 (10,3 days before the certificate expiration date)
		AcademyContactCertificationEmailUtilCtlr vfComponentObj2 = new AcademyContactCertificationEmailUtilCtlr();
		vfComponentObj2.emailTypeApex = 'Reminder1';
		vfComponentObj2.currentAcademyCertProgramIdApex = acp.Id;
		redwing__Training_Plan__c learningPlan2 = vfComponentObj2.getLearningPlan();

		System.assertNotEquals(null, learningPlan2, 'Learning Plan expected result should not be null');
		System.assertEquals(currentPlan.Module_Community_URL__c, learningPlan2.Module_Community_URL__c);
		System.assertEquals(currentPlan.Maintenance_Expiration_Date__c, learningPlan2.Maintenance_Expiration_Date__c);
	}

	@IsTest
	static void testGetLearningPlanNegative(){
		Academy_Certification_Program__c acp = [SELECT Id FROM Academy_Certification_Program__c WHERE Name = 'ADMINISTRATOR'];

		AcademyContactCertificationEmailUtilCtlr vfComponentObj = new AcademyContactCertificationEmailUtilCtlr();
		vfComponentObj.currentAcademyCertProgramIdApex = acp.Id;
		redwing__Training_Plan__c learningPlan = vfComponentObj.getLearningPlan();

		System.assertEquals(null, learningPlan);
	}

	@IsTest
	static void testGetLearningPlanNegative2(){
		Academy_Certification_Program__c acp = [SELECT Id FROM Academy_Certification_Program__c WHERE Name = 'TestCertificateProgram'];

		AcademyContactCertificationEmailUtilCtlr vfComponentObj = new AcademyContactCertificationEmailUtilCtlr();
		vfComponentObj.emailTypeApex = 'Reminder1';
		vfComponentObj.currentAcademyCertProgramIdApex = acp.Id;
		redwing__Training_Plan__c learningPlan = vfComponentObj.getLearningPlan();

		System.assertEquals(null, learningPlan);
	}

}