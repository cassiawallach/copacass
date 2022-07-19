public with sharing  class PackageVersionPublishHandler {

    // VARIABLES
    
	@InvocableVariable(label='Package Version Id' description='Id of the Package Version record.')
    public Id packageVersionId;
    
    private static copado__Artifact_Version__c packageVersion;
    private static copado__Release__c releaseRecord;
    
    
    // PUBLIC
    
    @InvocableMethod(label='Update Release Version and Status' description='' category='Copado Multi-Cloud APO Custom Development')
    public static void execute(List<Id> packageVersionIds) {
        if(packageVersionIds.isEmpty()) {
            return;
        }
        
        getPackageVersionDetails(packageVersionIds[0]);
        findRelease();
        
        if(releaseRecord != null){
            updateRelease();    
        }
    }
    
    
    // PRIVATE
    
    private static void getPackageVersionDetails(Id packageVersionId) {
        packageVersion = [SELECT Id, Name, copado__Artifact__c, copado__Release_Status__c, copado__Release__c, copado__Version__c, copado__View_In_Git__c, copado__Branch__c, copado__Is_released__c, copado__Package_Version_Id__c, copado__Production_Installation_URL__c, copado__Sandbox_Installation_URL__c, copado__Subscriber_Version_Id__c, copado__Tag__c, copado__Version_Description__c, copado__Version_Name__c, copado__Version_number__c, copado__Status__c, copado__User_Story__c, copado__Data_JSON__c, copado__LastJobExecutionId__c, copado__DefinitionFile__c FROM copado__Artifact_Version__c WHERE Id = :packageVersionId];
    }
    
    private static void findRelease() {
        List<copado__Release__c> releases = [SELECT Id, Name, copado__Description__c, copado__Planned_Date__c, copado__Project__c, copado__Status__c, copado__Base_Branch__c, copado__Version__c FROM copado__Release__c WHERE Name = :packageVersion.copado__Version_Description__c AND copado__Version__c = :packageVersion.copado__Tag__c LIMIT 1];
    	releaseRecord = releases.isEmpty() ? new copado__Release__c() : releases[0];
    }
    
    private static void updateRelease() {
        releaseRecord.copado__Status__c = 'Released';
        releaseRecord.copado__Version__c = packageVersion.copado__Version_number__c;
        
        update releaseRecord;
    }
}