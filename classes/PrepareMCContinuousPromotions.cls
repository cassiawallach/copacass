public with sharing class PrepareMCContinuousPromotions {
    
    // VARIABLES
    
	@InvocableVariable(label='Promotion Id' description='Id of the Promotion record.')
    public Id promotionId;
    
    private static final String PROMOTED_USER_STORY = 'Promoted User Story: ';
    private static final String BACK_PROMOTED_USER_STORY = 'Back Promoted User Story: ';
    private static copado__Promotion__c promotion;
    private static copado__Deployment_Flow__c pipeline;
    private static Map<Id, List<Id>> connectionsBySourceEnvironment;
    private static Map<Id, List<Id>> connectionsByDestinationAsSourceEnvironment;
    private static List<copado__Promotion__c> promotionsToInsert;
    private static List<copado__Deployment_Flow_Step__c> connections;
    private static List<copado__Promoted_User_Story__c> promotedUserStories;
    private static Id finalEnvironmentId;
    private static String releaseVersion;
    private static String releaseName;
	   
    
    // PUBLIC
    
    @InvocableMethod(label='Prepare MC Continuous Promotions' description='' category='Copado Multi-Cloud APO Custom Development')
    public static void execute(List<Id> promotionId) {
        if(promotionId.isEmpty()) {
            return;
        }
        
        getPromotionDetails(promotionId[0]);
        
        if(promotion.copado__Status__c == 'Completed') {
         	Boolean otherPlatform = promotion.copado__Platform__c != 'Salesforce' && promotion.copado__Platform__c != '';
        
            getPipelineDetails();
            getPipelineConnections();
            finalEnvironmentId = findFinalEnvironment();
            
            // Automated Promotion Process
            if(otherPlatform && !promotion.copado__Back_Promotion__c && jobExecutionStatusSuccess()) {
                prepareExecutionsForAutomation();
                
                // New Version Process
                if(promotion.copado__Destination_Environment__c == finalEnvironmentId && pipeline != null && pipeline.Create_Package_Version__c) {
                    checkIfNewVersionNeeded();    
                }
            }   
        }
    }
    
    
    // PRIVATE COMMON
     
    private static void getPromotionDetails(Id promotionId) {
        promotion = [SELECT Id, Name,
                            copado__Status__c,
                            copado__Destination_Org_Credential__c,
                            copado__Destination_Environment__c,
                            copado__Source_Org_Credential__c,
                            copado__Source_Environment__c,
                            copado__Release__c,
                            copado__Project__c,
                            copado__Back_Promotion__c,
                            copado__Platform__c,
                     		copado__Last_Deployment_Execution_Id__c,
                            copado__Destination_Environment__r.Name,
                            copado__Source_Environment__r.Name,
                            copado__Project__r.copado__Deployment_Flow__c,
                            copado__Project__r.copado__Deployment_Flow__r.copado__Platform__c,
                            copado__Project__r.copado__Deployment_Flow__r.copado__Promotion_Job_Template__c,
                            copado__Project__r.copado__Deployment_Flow__r.copado__Promotion_Job_Template__r.Name,
                            copado__Project__r.copado__Deployment_Flow__r.copado__Promotion_Job_Template__r.copado__ApiName__c,
                            copado__Project__r.copado__Deployment_Flow__r.copado__Deployment_Job_Template__c,
                            copado__Project__r.copado__Deployment_Flow__r.copado__Deployment_Job_Template__r.Name,
                            copado__Project__r.copado__Deployment_Flow__r.copado__Deployment_Job_Template__r.copado__ApiName__c,
                            copado__Release__r.copado__Project__r.copado__Deployment_Flow__c,
                            copado__Release__r.copado__Project__r.copado__Deployment_Flow__r.copado__Platform__c,
                            copado__Release__r.copado__Project__r.copado__Deployment_Flow__r.copado__Promotion_Job_Template__c,
                            copado__Release__r.copado__Project__r.copado__Deployment_Flow__r.copado__Promotion_Job_Template__r.Name,
                            copado__Release__r.copado__Project__r.copado__Deployment_Flow__r.copado__Promotion_Job_Template__r.copado__ApiName__c,
                            copado__Release__r.copado__Project__r.copado__Deployment_Flow__r.copado__Deployment_Job_Template__c,
                            copado__Release__r.copado__Project__r.copado__Deployment_Flow__r.copado__Deployment_Job_Template__r.Name,
                            copado__Release__r.copado__Project__r.copado__Deployment_Flow__r.copado__Deployment_Job_Template__r.copado__ApiName__c,
                            copado__Destination_Environment__r.copado__Platform__c,
                            copado__Destination_Environment__r.copado__Promotion_Job_Template_Override__r.Name,
                            copado__Destination_Environment__r.copado__Deployment_Job_Template_Override__r.Name,
                            copado__Destination_Environment__r.copado__Deployment_Job_Template_Override__r.copado__ApiName__c,
                            copado__Destination_Environment__r.copado__Promotion_Job_Template_Override__r.copado__ApiName__c
                    FROM copado__Promotion__c
                    WHERE Id = :promotionId];
    }
    
    private static void getPipelineDetails() {
        pipeline = [SELECT Id, Name,
                     		Enable_Continuous_Promotion__c,
                     		Enable_Continuous_Back_Promotion__c,
                     		Continuous_Promotion_Until__c,
                     		Create_Package_Version__c,
                    		Skip_Validations__c	
                    FROM copado__Deployment_Flow__c
                    WHERE Id = :findPipelineId()];
    }
    
    private static Id findPipelineId(){
    	return String.isNotBlank(promotion.copado__Project__r.copado__Deployment_Flow__c)
            ? promotion.copado__Project__r.copado__Deployment_Flow__c
            : String.isNotBlank(promotion.copado__Release__r.copado__Project__r.copado__Deployment_Flow__c) ? promotion.copado__Release__r.copado__Project__r.copado__Deployment_Flow__c : null;
    }
    
    private static void getPipelineConnections() {
        connections = [SELECT Id, copado__Destination_Environment__c, copado__Source_Environment__c FROM copado__Deployment_Flow_Step__c WHERE copado__Deployment_Flow__c = :pipeline.Id];
    }
    
    private static Id findFinalEnvironment() {
        Set<Id> sourceEnvironments = new Set<Id>();
        Set<Id> destinationEnvironments = new Set<Id>();
        for(copado__Deployment_Flow_Step__c connection : connections) {
            sourceEnvironments.add(connection.copado__Source_Environment__c);
            destinationEnvironments.add(connection.copado__Destination_Environment__c);
        }
        Id result;
        for(Id environmentId : destinationEnvironments) {
            if(!sourceEnvironments.contains(environmentId)) {
            	result = environmentId;
                break;
            }
        }
        return result;
    }
    
    
    // PRIVATE MC AUTOMATION
    
    private static Boolean jobExecutionStatusSuccess() {
        return [SELECT Id, copado__Status__c FROM copado__JobExecution__c WHERE Id = :promotion.copado__Last_Deployment_Execution_Id__c]?.copado__Status__c == 'Successful';
    }
    
    private static void prepareExecutionsForAutomation() {
        defineDestinationEnvironments();
        createPromotionRecords();
        if(!Test.isRunningTest()) {
            Database.executeBatch(new MCContinuousDeliveryBatch(promotionsToInsert), 1);
        }
    }
    
    private static void defineDestinationEnvironments() {
        connectionsBySourceEnvironment = new Map<Id, List<Id>>();
        connectionsByDestinationAsSourceEnvironment = new Map<Id, List<Id>>();
        
        for(copado__Deployment_Flow_Step__c connection : connections) {
            if(pipeline.Enable_Continuous_Promotion__c && promotion.copado__Destination_Environment__c != pipeline.Continuous_Promotion_Until__c) {
            	populateEnvironmentMap(connectionsBySourceEnvironment, connection.copado__Source_Environment__c, connection.copado__Destination_Environment__c);
            }
            
            if(pipeline.Enable_Continuous_Back_Promotion__c && promotion.copado__Destination_Environment__c == connection.copado__Destination_Environment__c) {
                populateEnvironmentMap(connectionsByDestinationAsSourceEnvironment, connection.copado__Destination_Environment__c, connection.copado__Source_Environment__c);
            }
        }
    }
    
    private static void populateEnvironmentMap(Map<Id, List<Id>> destinationsBySource, Id sourceEnvironment, Id destinationEnvironment) {
        if(destinationsBySource.containsKey(sourceEnvironment)) {
            destinationsBySource.get(sourceEnvironment).add(destinationEnvironment);
        } else {
            destinationsBySource.put(sourceEnvironment, new List<Id>{ destinationEnvironment });
        }
    }
    
    public static void createPromotionRecords() {
        promotionsToInsert = new List<copado__Promotion__c>();
        forwardPromotions();
        backPromotions();
        
        insert promotionsToInsert;
        
        insertPromotedUserStories();
    }
    
    public static void forwardPromotions() {
        for(Id sourceEnvironment : connectionsBySourceEnvironment.keySet()) {
            if(sourceEnvironment == promotion.copado__Destination_Environment__c) {
                copado__Promotion__c newPromotion = new copado__Promotion__c();
                newPromotion.copado__Project__c = promotion.copado__Project__c;
                newPromotion.copado__Back_Promotion__c = false;
                newPromotion.copado__Source_Environment__c = sourceEnvironment;
                
                promotionsToInsert.add(newPromotion);
            }
        }
    }
    
    public static void backPromotions() {
        for(Id sourceEnvironment : connectionsByDestinationAsSourceEnvironment.keySet()) {
            for(Id destinationEnvironment : connectionsByDestinationAsSourceEnvironment.get(sourceEnvironment)) {
                if(promotion.copado__Source_Environment__c != destinationEnvironment) {
                    copado__Promotion__c newPromotion = new copado__Promotion__c();
                    newPromotion.copado__Project__c = promotion.copado__Project__c;
                    newPromotion.copado__Back_Promotion__c = true;
                    newPromotion.copado__Destination_Environment__c = destinationEnvironment; 
                    
                    promotionsToInsert.add(newPromotion);    
                }
            }
        }
    }
    
    private static void insertPromotedUserStories() {
        List<copado__Promoted_User_Story__c> promotedUserStories = new List<copado__Promoted_User_Story__c>();

        for (copado__Promotion__c promotion : promotionsToInsert) {
            for (copado__User_Story__c userStory : userStories()) {
                promotedUserStories.add(createPromotedUserStoryRecord(promotion, userStory));
            }
        }

        insert promotedUserStories;
    }
    
    private static List<copado__User_Story__c> userStories() {
        List<Id> userStoryIds = new List<Id>();
        promotedUserStories = [SELECT Id, copado__User_Story__c, copado__User_Story__r.copado__Release__c, copado__User_Story__r.copado__Release__r.copado__Version__c FROM copado__Promoted_User_Story__c WHERE copado__Promotion__c =: promotion.Id];
        for(copado__Promoted_User_Story__c pus : promotedUserStories){
            userStoryIds.add(pus.copado__User_Story__c);
        }
        return [SELECT Id, Name FROM copado__User_Story__c WHERE Id IN :userStoryIds];
    }
    
    public static copado__Promoted_User_Story__c createPromotedUserStoryRecord(copado__Promotion__c promotion, copado__User_Story__c userStory) {
        copado__Promoted_User_Story__c promotedUserStory = new copado__Promoted_User_Story__c();
        promotedUserStory.Name = promotedUserStoryName(promotion, userStory.Name);
        promotedUserStory.copado__Promotion__c = promotion.Id;
        promotedUserStory.copado__User_Story__c = userStory.Id;
        return promotedUserStory;
    }
    
    private static String promotedUserStoryName(copado__Promotion__c promotion, String userStoryName) {
        return promotion.copado__Back_Promotion__c ? BACK_PROMOTED_USER_STORY + userStoryName : PROMOTED_USER_STORY + userStoryName;
    }
    
    
    // PRIVATE MC PACKAGING
     
    private static void checkIfNewVersionNeeded() {
        if(userStoriesHasRelease()) {
            if(releaseVersion != null) {
                generateNewPackageVersion();
            }
        }
    }
    
    private static Boolean userStoriesHasRelease() {
        Boolean hasRelease = false; 
        promotedUserStories = [SELECT Id, copado__User_Story__c, copado__User_Story__r.copado__Release__c, copado__User_Story__r.copado__Release__r.Name, copado__User_Story__r.copado__Release__r.copado__Version__c FROM copado__Promoted_User_Story__c WHERE copado__Promotion__c =: promotion.Id];
        for(copado__Promoted_User_Story__c pus : promotedUserStories) {
            if(pus.copado__User_Story__r.copado__Release__c != null && pus.copado__User_Story__r.copado__Release__r.copado__Version__c != null) {
                hasRelease = true;
                releaseVersion = pus.copado__User_Story__r.copado__Release__r.copado__Version__c;
                releaseName = pus.copado__User_Story__r.copado__Release__r.Name;
                break;
            }
        }
        
        return hasRelease;
    }
    
    private static void generateNewPackageVersion() {
        List<copado__Artifact__c> pipelinePackages = getPackageDetails();
        
        if(pipelinePackages.isEmpty()) {
            return;
        }
        VersionJSONParameters parameters = generateParameters(pipelinePackages[0]);
        
        copado.PackageVersionCreateAction.Request request = new copado.PackageVersionCreateAction.Request(pipelinePackages[0].Id , JSON.serialize(parameters));
        request.versionName = releaseVersion;
        request.versionNumber = releaseVersion;
        request.description = releaseName;
        
        if(!Test.isRunningTest()) {
        	copado.PackageVersionCreateAction.create(new List<copado.PackageVersionCreateAction.Request>{ request });
        }
    }
    
    private static List<copado__Artifact__c> getPackageDetails() {
        return [SELECT copado__Artifact_Repository__c, copado__Description__c, copado__Org_Credential__c, copado__Artifact_Version__c, copado__No_Namespace__c, copado__Package_Id__c, copado__Package_Namespace__c, copado__Package_Type__c, copado__Sfdc_Login_Url__c, copado__Source_Api_Version__c, copado__Target_Dev_Hub_Org__c, copado__Pipeline__c, copado__LastJobExecutionId__c, copado__DataJSON__c, copado__DefaultBranch__c, copado__DefaultPath__c, cmcSf__IsOrgDependent__c FROM copado__Artifact__c WHERE copado__Pipeline__c  = :pipeline.Id LIMIT 1];
    }
    
    private static VersionJSONParameters generateParameters(copado__Artifact__c mainPackage) {
		VersionJSONParameters result = new VersionJSONParameters();
        result.branch = mainPackage.copado__DefaultBranch__c;
        result.path = mainPackage.copado__DefaultPath__c;
        result.tag = releaseVersion;
        result.installationkeybypass = true;
        result.codecoverage = pipeline.Skip_Validations__c ? false : true;
        result.skipvalidation = pipeline.Skip_Validations__c;
        
        return result;
    }
    
    // WRAPPER
    
    public class VersionJSONParameters {
        public String branch;
        public String path;
        public Boolean installationkeybypass;
        public Boolean codecoverage; 
        public Boolean skipvalidation;
        public String tag;
    }
    
}