public with sharing class AccountFeatureManagerController {
    private Salesforce_Org__c org {get;set;}
    public List<sfFma__FeatureParameterInteger__c> orgFeatures {get;set;}
    public Contract contractForOrg {get;set;}
    
    public AccountFeatureManagerController(ApexPages.StandardController stdController) {
        org = (Salesforce_Org__c)stdController.getRecord();
        org = [SELECT Id, Parent_Account__c FROM Salesforce_Org__c WHERE Id = :org.Id];
        getorgFeatures();
        List<Contract> cs = [SELECT Id, ContractNumber, Custom_Salesforce_Org__c, StartDate, EndDate, Status
                             FROM Contract WHERE AccountId = :org.Parent_Account__c AND Status = 'Activated' ORDER BY EndDate DESC LIMIT 1];
        if(cs.size()== 1){
            contractForOrg = cs.get(0);
        }
        else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'This org does not have an activated contract.'));
        }
    }
    public void getorgFeatures(){
        orgFeatures = new List<sfFma__FeatureParameterInteger__c>();
        orgFeatures = [select Id, sfFma__FullName__c, Expiration_Date__c, sfFma__Value__c, sfFma__License__c, sfFma__FeatureParameter__c
                       from sfFma__FeatureParameterInteger__c
                       where sfFma__License__r.Salesforce_Org__c =:org.Id
                       and sfFma__FullName__c != null];
        for (sfFma__FeatureParameterInteger__c fpi: orgFeatures) {
            if (fpi.sfFma__Value__c == null) fpi.sfFma__Value__c = 0;
        }
        system.debug('orgFeatures Size: '+orgFeatures.size());
    }
    public void updateorgFeatures(){
        
        Salesforce_Org__c sfOrg = new Salesforce_Org__c();
        sfOrg.Id = org.Id;
        sfOrg.Last_Sync_Date__c = system.today();
        sfOrg.Sync_Status__c = 'Pending';
        sfOrg.Sync_Status_Details__c = 'Saving Feature Values';
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Saving Feature Values'));
        
        try{
            update orgFeatures;
            sfOrg.Sync_Status__c = 'Pending';
            sfOrg.Sync_Status_Details__c = 'Feature Values Saved';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Feature Values Saved'));
            
        }
        catch(DmlException e){
            sfOrg.Sync_Status__c = 'Failed';
            sfOrg.Sync_Status_Details__c = 'Feature Save Error: ' + e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Error Saving Features: ' + e.getMessage()));
        }
        update sfOrg;
        try {
            syncFeatures(org.Id);
            sfOrg.Sync_Status__c = 'Pending';
            sfOrg.Sync_Status_Details__c = 'Sync Requested';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Sync requested. Refresh page to view Sync Status'));
        } 
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            sfOrg.Sync_Status__c = 'Failed';
            sfOrg.Sync_Status_Details__c = 'Sync Request Error: ' + e.getMessage();
        }
        Update sfOrg;
        System.debug('sfOrg processed: '+ sfOrg);
    }
    @future(callout=true)
    private static void syncFeatures(Id orgId){
        Salesforce_Org__c sfOrg = new Salesforce_Org__c();
        sfOrg.Id = orgId;
        sfOrg.Last_Sync_Date__c = system.today();
        try {
            admin_utilities.syncFeatures(orgId);
            sfOrg.Sync_Status__c = 'Pending';
            sfOrg.Sync_Status_Details__c = 'Sync Starting';
        }catch(DmlException e) {
            System.debug('Error Starting Sync: ' + e.getMessage());
            sfOrg.Sync_Status__c = 'Failed';
            sfOrg.Sync_Status_Details__c = 'Error Starting Sync: ' + e.getMessage();
        }
        Update sfOrg;
    }
    
}