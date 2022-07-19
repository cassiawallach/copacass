public without sharing class AcademyContactCertificationEmailUtilCtlr {

	public String currentPlanIdApex { get; set; }
	public String currentAcademyCertProgramIdApex { get; set; }
	public String contactIdApex { get; set; }
	public String emailTypeApex { get; set; }

	public AcademyContactCertificationEmailUtilCtlr() {

	}

	public Academy_Certification__c getContactAcademyCertification() {
		if('MaintenanceResult'.equalsIgnoreCase(emailTypeApex) && !String.isBlank(contactIdApex) && !String.isBlank(currentPlanIdApex)) {
			List<redwing__Training_Plan_Section_Item__c> sectionItems = [SELECT Id, redwing__Learning__r.Academy_Certification_Program__c FROM redwing__Training_Plan_Section_Item__c WHERE redwing__Training_Plan_Section__r.redwing__Training_Plan__c = :currentPlanIdApex AND redwing__Learning__r.Academy_Certification_Program__c != NULL LIMIT 1];

			if(sectionItems.isEmpty()) {
				return null;
			}
			Id certificationProgramId = sectionItems[0].redwing__Learning__r.Academy_Certification_Program__c;
			List<Academy_Certification__c> certifications = [
				SELECT Id, Expiration_Date__c, Certification_Student__c FROM Academy_Certification__c WHERE Status__c = 'Valid'
				AND Certification_Program__c != NULL AND Certification_Program__c = :certificationProgramId
				AND Certification_Student__r.Contact__c != NULL AND Certification_Student__r.Contact__c = :contactIdApex
				ORDER BY Expiration_Date__c DESC LIMIT 1
			];
			if(!certifications.isEmpty()) {
				return certifications[0];
			}
		}
		return null;
	}

	public redwing__Training_Plan__c getLearningPlan() {
		if(('Reminder1'.equalsIgnoreCase(emailTypeApex) || 'Reminder2'.equalsIgnoreCase(emailTypeApex)) && !String.isBlank(currentAcademyCertProgramIdApex)) {
			List<redwing__Training_Plan_Section_Item__c> sectionItems = [SELECT Id, redwing__Training_Plan_Section__r.redwing__Training_Plan__r.Module_Community_URL__c, redwing__Training_Plan_Section__r.redwing__Training_Plan__r.Maintenance_Expiration_Date__c
																		 FROM redwing__Training_Plan_Section_Item__c
																		 WHERE redwing__Learning__r.Academy_Certification_Program__c != NULL
																		 AND redwing__Learning__r.Academy_Certification_Program__c = :currentAcademyCertProgramIdApex
																		 AND redwing__Training_Plan_Section__r.redwing__Training_Plan__r.Is_Maintenance_Plan__c = TRUE
																		 AND redwing__Training_Plan_Section__r.redwing__Training_Plan__r.redwing__Start_Date__c < :Date.today()
																		 AND redwing__Training_Plan_Section__r.redwing__Training_Plan__r.Maintenance_Expiration_Date__c >= :Date.today() LIMIT 1];
			if(sectionItems.isEmpty()) {
				return null;
			}
			else {
				return sectionItems[0].redwing__Training_Plan_Section__r.redwing__Training_Plan__r;
			}

		}
		return null;
	}
}