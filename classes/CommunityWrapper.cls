/**
 * Wrapper class for community.
 */
public class CommunityWrapper {
	public class ResponseWrap {
		@AuraEnabled public Boolean isError;
		@AuraEnabled public String message;
		@AuraEnabled public Object result;
		public ResponseWrap(Boolean isError, String message) {
			this.isError = isError;
			this.message = message;
		}
		public ResponseWrap(Boolean isError, String message, Object result) {
			this.isError = isError;
			this.message = message;
			this.result = result;
		}
	}

	public class PicklistEntry {
		@AuraEnabled public String label;
		@AuraEnabled public String value;
		public PicklistEntry(String label, String value) {
			this.label = label;
			this.value = value;
		}
	}

	public class CustomSobject {
		@AuraEnabled public String Id;
		@AuraEnabled public String Name;
		public CustomSobject(String Id, String Name) {
			this.Id = Id;
			this.Name = Name;
		}
	}

	// Related file or attachment wrapper class
	public class relatedFile {
		public String PathOnClient;
		public String Title;
		public Blob VersionData;
	}

	/**
	 * Wrapper class for Project Details along with it's permissions
	 */
	public class UserProjectDetails {
		@AuraEnabled public String Id;
		@AuraEnabled public String Name;
		@AuraEnabled public String AccountName;
		@AuraEnabled public Integer NumberOfActiveTeamMembers;
		@AuraEnabled public Boolean TeamMemberIsActive;
		@AuraEnabled public Boolean TeamMemberIsSuperUser;
		@AuraEnabled public Boolean TeamMemberManageTeam;
		@AuraEnabled public Boolean TeamMemberLogCases;
		@AuraEnabled public Boolean TeamMemberViewCasesReport;
		@AuraEnabled public Boolean TeamMemberViewCertificationsReport;
		@AuraEnabled public String projectCSM;
		@AuraEnabled public Integer noOfOpenCases;
		@AuraEnabled public Integer noOfCerts;

		public UserProjectDetails (String Id, String Name, String AccountName, Integer NumberOfActiveTeamMembers,
			Boolean TeamMemberIsActive, Boolean TeamMemberIsSuperUser, Boolean TeamMemberManageTeam, Boolean TeamMemberLogCases,
			Boolean TeamMemberViewCasesReport, Boolean TeamMemberViewCertificationsReport, String projectCSM, Integer noOfOpenCases, Integer noOfCerts) {
				this.Id = Id;
				this.Name = Name;
				this.AccountName = AccountName;
				this.NumberOfActiveTeamMembers = NumberOfActiveTeamMembers;
				this.TeamMemberIsActive = TeamMemberIsActive;
				this.TeamMemberIsSuperUser = TeamMemberIsSuperUser;
				this.TeamMemberManageTeam = TeamMemberManageTeam;
				this.TeamMemberLogCases = TeamMemberLogCases;
				this.TeamMemberViewCasesReport = TeamMemberViewCasesReport;
				this.TeamMemberViewCertificationsReport = TeamMemberViewCertificationsReport;
				this.projectCSM = projectCSM;
				this.noOfOpenCases = noOfOpenCases;
				this.noOfCerts = noOfCerts;
		}
	}

	/**
	 * Wrapper class for case details
	 */
	public class CaseDetails {
		@AuraEnabled public String Id;
		@AuraEnabled public String CaseNumber;
		@AuraEnabled public String CaseURL;
		@AuraEnabled public String Subject;
		@AuraEnabled public String ImpactedArea;
		@AuraEnabled public String Status;
		@AuraEnabled public DateTime CreatedDate;
		@AuraEnabled public DateTime ClosedDate;
		@AuraEnabled public DateTime LastCaseCommentTime;
		@AuraEnabled public String CreatedBy;

		public CaseDetails (String Id, String CaseNumber, String CaseURL, String Subject,
			String ImpactedArea, String Status, DateTime CreatedDate, DateTime ClosedDate, DateTime LastCaseCommentTime, String CreatedBy) {
				this.Id = Id;
				this.CaseNumber = CaseNumber;
				this.CaseURL = CaseURL;
				this.Subject = Subject;
				this.ImpactedArea = ImpactedArea;
				this.Status = Status;
				this.CreatedDate = CreatedDate;
				this.ClosedDate = ClosedDate;
				this.LastCaseCommentTime = LastCaseCommentTime;
				this.CreatedBy = CreatedBy;
		}
	}

	/**
	 * Wrapper class for case fieldSet
	 */
	public class CaseFieldSetWrap {
		@AuraEnabled public String textAreaFieldsMap;
		@AuraEnabled public String allOthersFieldsMap;

		public CaseFieldSetWrap (String textAreaFieldsMap, String allOthersFieldsMap) {
				this.textAreaFieldsMap = textAreaFieldsMap;
				this.allOthersFieldsMap = allOthersFieldsMap;
		}
	}

	/**
	 * Wrapper class for Copa Update details
	 */
	public class CopaUpdateDetails {
		@AuraEnabled public String Id;
		@AuraEnabled public String StartDate;
		@AuraEnabled public String Title;
		@AuraEnabled public String Description1;
		@AuraEnabled public String Description2;
		@AuraEnabled public String Description3;
		@AuraEnabled public String CopaUpdateUrl;

		public CopaUpdateDetails (String Id, String StartDate, String Title, String Description1, String Description2, String Description3, String CopaUpdateUrl) {
				this.Id = Id;
				this.StartDate = StartDate;
				this.Title = Title;
				this.Description1 = Description1;
				this.Description2 = Description2;
				this.Description3 = Description3;
				this.CopaUpdateUrl = CopaUpdateUrl;
		}
		public CopaUpdateDetails (String Id, String StartDate, String Title, String CopaUpdateUrl) {
				this.Id = Id;
				this.StartDate = StartDate;
				this.Title = Title;
				this.CopaUpdateUrl = CopaUpdateUrl;
		}
	}

	/**
	 * Wrapper class for Copa Event details
	 */
	public class CopaEventDetails {
		@AuraEnabled public String Id;
		@AuraEnabled public String Title;
		@AuraEnabled public String EventType;
		@AuraEnabled public String Details;
		@AuraEnabled public String RegistrationLink;
		@AuraEnabled public String StartDate;
		@AuraEnabled public String EventTimeShownToPublicString;
		@AuraEnabled public String Location;
		@AuraEnabled public Boolean IsUserRegistered = false;
		public CopaEventDetails () {

		}
		public CopaEventDetails (String Id, String Title, String EventType, String Details, String StartDate, String EventTimeShownToPublicString, String Location) {
				this.Id = Id;
				this.Title = Title;
				this.EventType = EventType;
				this.Details = Details;
				this.StartDate = StartDate;
				this.EventTimeShownToPublicString = EventTimeShownToPublicString;
				this.Location = Location;
		}
	}
}