@isTest
public class AcademyCertExpirationReminderEmailsTest {
	@testSetup
	static void setup() {
		UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
		Profile profile1 = [Select Id from Profile where name = 'System Administrator'];
		User adminUser = new User(
			UserRoleId = portalRole.Id,
			ProfileId = profile1.Id,
			Username = System.now().millisecond() + 'academyCertReminder@test.com',
			Alias = 'batman',
			Email='new.academyCertReminder@test.com',
			EmailEncodingKey='UTF-8',
			Firstname='test',
			Lastname='test',
			LanguageLocaleKey='en_US',
			LocaleSidKey='en_US',
			TimeZoneSidKey='GMT'
		);
		Database.insert(adminUser);

		System.runAs(adminUser) {
			Account accountObj = TestDataFactory.createAccount('TestGuestUser','EUR');
			INSERT accountObj;

			Contact con1 = TestDataFactory.createContact(accountObj.Id, 'expirationCon1');
			Contact con2 = TestDataFactory.createContact(accountObj.Id, 'expirationCon2');
			Contact con3 = TestDataFactory.createContact(accountObj.Id, 'expirationCon3');
			Contact con4 = TestDataFactory.createContact(accountObj.Id, 'expirationCon4');

			List<Contact> conList = new List<Contact>{con1, con2, con3, con4};
				insert conList;

			Id communityProfileId = [SELECT Id FROM Profile WHERE Name = 'CUSTOM Community Guest Login'].Id;

			User user1 = new User(FirstName=con1.FirstName, LastName=con1.LastName, Email=con1.Email, ContactId=con1.Id,
								  Alias='myalias', EmailEncodingKey = 'UTF-8',
								  LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US',
								  ProfileId=communityProfileId, Country='United States', IsActive=true,
								  TimezoneSidKey='America/Los_Angeles', Username=con1.FirstName + '1' + System.now().format('yyyy-MM-dd') + '@reminder.com');
			User user2 = new User(FirstName=con2.FirstName, LastName=con2.LastName, Email=con2.Email, ContactId=con2.Id,
								  Alias='myalias', EmailEncodingKey = 'UTF-8',
								  LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US',
								  ProfileId=communityProfileId, Country='United States', IsActive=true,
								  TimezoneSidKey='America/Los_Angeles', Username=con2.FirstName + '2' + System.now().format('yyyy-MM-dd') + '@reminder.com');

			List<User> userList = new List<User>{user1, user2};
				insert userList;

			Academy_Certification_Program__c certificationProgram1 = TestDataFactory.createCertificationProgram();
			certificationProgram1.Name = 'Certification 1';
			Academy_Certification_Program__c certificationProgram2 = TestDataFactory.createCertificationProgram();
			certificationProgram2.Name = 'Certification 2';
			Academy_Certification_Program__c certificationProgram3 = TestDataFactory.createCertificationProgram();
			certificationProgram3.Name = 'Certification 3';
			Academy_Certification_Program__c certificationProgram4 = TestDataFactory.createCertificationProgram();
			certificationProgram4.Name = 'Certification 4';

			List<Academy_Certification_Program__c> certProgramList = new List<Academy_Certification_Program__c>{certificationProgram1, certificationProgram2, certificationProgram3, certificationProgram4};
				insert certProgramList;

			Academy_Certification_Student__c  certificationStudent1 = TestDataFactory.createCertificationStudent(con1);
			Academy_Certification_Student__c  certificationStudent2 = TestDataFactory.createCertificationStudent(con2);
			Academy_Certification_Student__c  certificationStudent3 = TestDataFactory.createCertificationStudent(con3);
			Academy_Certification_Student__c  certificationStudent4 = TestDataFactory.createCertificationStudent(con4);
			List<Academy_Certification_Student__c> acStudentList = new List<Academy_Certification_Student__c> {certificationStudent1, certificationStudent2, certificationStudent3, certificationStudent4};
				insert acStudentList;

			Academy_Certification__c  certificate1Student1 = TestDataFactory.createCertification(certificationStudent1.Id,certificationProgram1.Id);
			Academy_Certification__c  certificate2Student1 = TestDataFactory.createCertification(certificationStudent1.Id,certificationProgram2.Id);
			Academy_Certification__c  certificate3Student1 = TestDataFactory.createCertification(certificationStudent1.Id,certificationProgram3.Id);
			Academy_Certification__c  certificate4Student1 = TestDataFactory.createCertification(certificationStudent1.Id,certificationProgram4.Id);
			Academy_Certification__c  certificate1Student2 = TestDataFactory.createCertification(certificationStudent2.Id,certificationProgram1.Id);
			Academy_Certification__c  certificate1Student3 = TestDataFactory.createCertification(certificationStudent3.Id,certificationProgram1.Id);
			Academy_Certification__c  certificate2Student3 = TestDataFactory.createCertification(certificationStudent3.Id,certificationProgram2.Id);
			Academy_Certification__c  certificate1Student4 = TestDataFactory.createCertification(certificationStudent4.Id,certificationProgram1.Id);
			Academy_Certification__c  certificate2Student4 = TestDataFactory.createCertification(certificationStudent4.Id,certificationProgram2.Id);
			Academy_Certification__c  certificate3Student4 = TestDataFactory.createCertification(certificationStudent4.Id,certificationProgram3.Id);
			Academy_Certification__c  certificate4Student4 = TestDataFactory.createCertification(certificationStudent4.Id,certificationProgram4.Id);

			List<Academy_Certification__c> acList = new List<Academy_Certification__c>{certificate1Student1, certificate2Student1, certificate3Student1, certificate4Student1, certificate1Student2,
				certificate1Student3, certificate2Student3, certificate1Student4, certificate2Student4, certificate3Student4, certificate4Student4};

					for(Academy_Certification__c certificate : acList) {
						certificate.Status__c = 'Valid';
					}
			insert acList;

			// Date for certification exam date in 1 year and 12 weeks i.e 84 days before
			Date YearAnd84DaysBefore = Date.today().addYears(-1).addDays(84);
			system.debug('date is : '+YearAnd84DaysBefore);
			// Date for certification exam date in 1 year and 6 weeks i.e 42 days before
			Date YearAnd42DaysBefore = Date.today().addYears(-1).addDays(42);
			// Date for certification exam date in 1 year and 3 weeks i.e 21 days before
			Date YearAnd21DaysBefore = Date.today().addYears(-1).addDays(21);
			// Date for certification exam date in 1 year and 10 days before
			Date YearAnd10DaysBefore = Date.today().addYears(-1).addDays(10);
			// Date for certification exam date in 1 year and 3 days before
			Date YearAnd3DaysBefore = Date.today().addYears(-1).addDays(3);

			Integer counter = 1;
			List<Academy_Certification_Examination__c> aceList = new List<Academy_Certification_Examination__c>();
			for(Academy_Certification__c ac : acList) {
				Academy_Certification_Examination__c  certificateExam = TestDataFactory.createCertificationExam(ac.Certification_Program__c, ac.Id, ac.Certification_Student__c);
				if(counter == 1 || counter == 8) {
					certificateExam.Date__c = YearAnd84DaysBefore;
				}
				else if(counter == 2 || counter == 9) {
					certificateExam.Date__c = YearAnd42DaysBefore;
				}
				else if(counter == 3 || counter == 10) {
					certificateExam.Date__c = YearAnd21DaysBefore;
				}
				else if(counter == 4 || counter == 11) {
					certificateExam.Date__c = Date.today();
				}
				else if(counter == 6) {
					certificateExam.Date__c = YearAnd10DaysBefore;
				}
				else if(counter == 5 || counter == 7) {
					certificateExam.Date__c = YearAnd3DaysBefore;
				}
				aceList.add(certificateExam);
				counter++;
			}
			insert aceList;

			List<Academy_Certification__c> acListToUpdate = new List<Academy_Certification__c>();
			for(Academy_Certification_Examination__c exam : aceList) {
				Academy_Certification__c acUpdate = new Academy_Certification__c();
				acUpdate.Id = exam.Academy_Certification2__c;
				acUpdate.Certification_Examination__c = exam.Id;
				acListToUpdate.add(acUpdate);
			}
			update acListToUpdate;
			List<Academy_Certification__c> latest = [Select Id, Expiration_Date__c FROM Academy_Certification__c];
			for(Academy_Certification__c acwq : latest) {
				system.debug('exprtn date : '+acwq.Expiration_Date__c);
			}
		}
	}

	/**
	 * Test method for testing the batch of AcademyCertExpirationReminderEmailsBatch class
	 */
	@IsTest
	public static void testReminderEmails() {
		User adminUser = [SELECT Id From User Where Email = 'new.academyCertReminder@test.com'];
		System.assertNotEquals(null,adminUser.Id, 'System Administrator User can not created.');
		System.runAs(adminUser) {
			Test.startTest();
			AcademyCertExpirationReminderEmailsBatch ctrl1 = new AcademyCertExpirationReminderEmailsBatch();
			DataBase.executeBatch(ctrl1);
			System.assertNotEquals(null, ctrl1, 'AcademyCertExpirationReminderEmailsBatch controller instance is null.');
			Test.stopTest();
			System.assertEquals(9, [SELECT Id From emailMessage].size());
			System.assertEquals(18, [SELECT Id From EmailMessageRelation].size());
		}
	}
}