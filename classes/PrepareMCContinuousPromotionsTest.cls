@IsTest
private class PrepareMCContinuousPromotionsTest {
    private static copado__User_Story__c userStory;
    private static copado__Deployment_Flow__c deploymentFlow;
    private static List<copado__Environment__c> environments;
    private static copado__JobTemplate__c deploymentJobTemplate;
    private static copado__JobTemplate__c promotionJobTemplate;
    private static copado__Project__c project;
    private static copado__Function__c functionPromotion;
    private static copado__Function__c functionDeployment;

    @TestSetup
    private static void setupData() {
        List<User> userList = createUsers();
        List<PermissionSet> permissionSets = [
            SELECT Id
            FROM PermissionSet
            WHERE Name IN ('Copado_User', 'Copado_Functions', 'Copado_Job_Engine', 'Quality_Gates_Admin')
        ];
        List<PermissionSetAssignment> assignments = new List<PermissionSetAssignment>();
        for (PermissionSet permissionSet : permissionSets) {
            assignments.add(new PermissionSetAssignment(AssigneeId = userList[0].Id, PermissionSetId = permissionSet.Id));
        }
        insert assignments;
    }

    private static List<User> createUsers() {
        List<User> users = new List<User>();

        String orgTimezoneKey = getOrgTimeZoneKey();
        orgTimezoneKey = orgTimezoneKey != null ? orgTimezoneKey : 'America/Los_Angeles';

        User sysUs = new User();
        sysUs.ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
        sysUs.LastName = 'LastName';
        sysUs.Email = 'test1@test1.com';
        sysUs.Username = 'psysUser000@amamama.com' + System.currentTimeMillis();
        sysUs.CompanyName = 'TEST';
        sysUs.Title = 'title';
        sysUs.Alias = 'alias';
        sysUs.TimeZoneSidKey = orgTimezoneKey;
        sysUs.EmailEncodingKey = 'UTF-8';
        sysUs.LanguageLocaleKey = 'en_US';
        sysUs.LocaleSidKey = 'en_US';
        users.add(sysUs);

        User stdUs = new User();
        stdUs.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id;
        stdUs.LastName = 'LastName';
        stdUs.Email = 'test2@test2.com';
        stdUs.Username = 'pstdUser002@amamama.com' + System.currentTimeMillis();
        stdUs.CompanyName = 'TEST';
        stdUs.Title = 'title2';
        stdUs.Alias = 'alias2';
        stdUs.TimeZoneSidKey = orgTimezoneKey;
        stdUs.EmailEncodingKey = 'UTF-8';
        stdUs.LanguageLocaleKey = 'en_US';
        stdUs.LocaleSidKey = 'en_US';
        users.add(stdUs);

        insert users;
        
        return users;
    }
    
    private static String getOrgTimeZoneKey() {
        String result;

        List<Organization> organizations = [SELECT TimeZoneSidKey FROM Organization LIMIT 1];
        if (!organizations.isEmpty()) {
            result = organizations.get(0).TimeZoneSidKey;
        }

        return result;
    }
    
    private static void data() {
        copado__Personal_Settings__c ps = copado__Personal_Settings__c.getInstance();
        if (String.isBlank(ps.copado__API_Key__c)) {
            ps.copado__API_Key__c = EncodingUtil.base64Encode(Crypto.encryptWithManagedIV('AES256', EncodingUtil.base64Decode('C9fZmwq5+7B2VTq09BCS3tfw7vgsek/FkPySC+XYTIE='), Blob.valueOf('99999999999999999999')));
            upsert ps;
        }

        //Environment creation
        environments = new List<copado__Environment__c>();
        for (Integer i = 0; i < 5; i++) {
            copado__Environment__c environment = createEnvironments('Environment ' + i, 'Production/Developer');
            environment.copado__Platform__c = 'Other';
            environments.add(environment);
        }
        insert environments;

        // Function creation
        String namespace = 'copado.';
        functionPromotion = new copado__Function__c(
            Name = 'mulePromotion',
            copado__API_Name__c = 'mulePromotion',
            copado__Script__c = 'echo hello world $par1',
            copado__Type__c = 'Custom',
            copado__Parameters__c = '[{"name": "SourceDBName", "defaultValue": "{!$Source.Property.DBName}", "required": true},' +
                '{"name": "DestinationDBProvider", "defaultValue": "{!$Destination.Property.DB-Provider}", "required": true},' +
                '{"name": "PipelineUsername", "defaultValue": "{!$Pipeline.Property.Username}", "required": true},' +
                '{"name": "UserEmail", "defaultValue": "{!$User.Property.Email}", "required": true},' +
                '{"name": "LogLevel", "defaultValue": "ERROR", "required": false}]',
            copado__Options__c = '[{"name": "gitUrl", "value": "xxxxxx", "sensitive": true},' +
                '{"name": "gitUsername", "value": "", "sensitive": true},' +
                '{"name": "gitPassword", "value": "", "sensitive": true},' +
                '{"name": "branchName", "value": "", "sensitive": false}]',
            copado__Callback_Type__c = 'ApexClass',
            copado__ApexClass__c = namespace + 'FunctionStepExecutionCallback'
        );
        functionDeployment = new copado__Function__c(
            Name = 'muleDeployment',
            copado__API_Name__c = 'muleDeployment',
            copado__Script__c = 'echo hello world $par1',
            copado__Type__c = 'Custom',
            copado__Parameters__c = '[{"name": "SourceDBName", "defaultValue": "{!$Source.Property.DBName}", "required": true},' +
                '{"name": "DestinationDBProvider", "defaultValue": "{!$Destination.Property.DB-Provider}", "required": true},' +
                '{"name": "PipelineUsername", "defaultValue": "{!$Pipeline.Property.Username}", "required": true},' +
                '{"name": "UserEmail", "defaultValue": "{!$User.Property.Email}", "required": true},' +
                '{"name": "LogLevel", "defaultValue": "ERROR", "required": false}]',
            copado__Options__c = '[{"name": "gitUrl", "value": "xxxxxx", "sensitive": true},' +
                '{"name": "gitUsername", "value": "", "sensitive": true},' +
                '{"name": "gitPassword", "value": "", "sensitive": true},' +
                '{"name": "branchName", "value": "", "sensitive": false}]',
            copado__Callback_Type__c = 'ApexClass',
            copado__ApexClass__c = namespace + 'FunctionStepExecutionCallback'
        );
        insert new List<copado__Function__c>{ functionPromotion, functionDeployment };

        // Job template creation
        deploymentJobTemplate = createJobTemplate(
            'JOB_TEMPLATE_DEPLOYMENT',
            'JOB_TEMPLATE_DEPLOYMENT',
            1,
            '[{ "name": "volumeEnabled", "value": "false" }]'
        );
        promotionJobTemplate = createJobTemplate(
            'JOB_TEMPLATE_PROMOTION',
            'JOB_TEMPLATE_PROMOTION',
            1,
            '[{ "name": "volumeEnabled", "value": "false" }]'
        );
        insert new List<copado__JobTemplate__c>{ deploymentJobTemplate, promotionJobTemplate };

        // Job step creation
        copado__JobStep__c functionDeploymentStep = createJobStep(
            'Function',
            deploymentJobTemplate.Id,
            'Function',
            1,
            '{"functionName":"muleDeployment","parameters":[]}'
        );
        copado__JobStep__c functionPromotionStep = createJobStep(
            'Function',
            promotionJobTemplate.Id,
            'Function',
            1,
            '{"functionName":"mulePromotion","parameters":[]}'
        );
        insert new List<copado__JobStep__c>{ functionDeploymentStep, functionPromotionStep };

        // Git repository creation
        copado__Git_Repository__c gitRepository = createGitRepository();
        insert gitRepository;

        // Deployment flow creation
        deploymentFlow = createDeploymentFlow('Deployment Flow', true, gitRepository.Id, false);
        deploymentFlow.copado__Main_Branch__c = 'master';
        deploymentFlow.copado__Platform__c = 'Other';
        deploymentFlow.copado__Promotion_Job_Template__c = promotionJobTemplate.Id;
        deploymentFlow.copado__Deployment_Job_Template__c = deploymentJobTemplate.Id;
        deploymentFlow.Enable_Continuous_Promotion__c = true;
        deploymentFlow.Enable_Continuous_Back_Promotion__c = true;
        deploymentFlow.Continuous_Promotion_Until__c = environments[3].Id;
        deploymentFlow.Create_Package_Version__c = true;
        deploymentFlow.Skip_Validations__c = false;
        insert deploymentFlow;

        // Deployment flow steps creation
        copado__Deployment_Flow_Step__c deploymentFlowStep1 = createDeploymentFlowStep(
            environments[0].Id,
            environments[2].Id,
            deploymentFlow.Id,
            ''
        );
        deploymentFlowStep1.copado__Branch__c = 'dev1';
        copado__Deployment_Flow_Step__c deploymentFlowStep2 = createDeploymentFlowStep(
            environments[1].Id,
            environments[2].Id,
            deploymentFlow.Id,
            ''
        );
        deploymentFlowStep1.copado__Branch__c = 'dev2';
        copado__Deployment_Flow_Step__c deploymentFlowStep3 = createDeploymentFlowStep(
            environments[2].Id,
            environments[3].Id,
            deploymentFlow.Id,
            ''
        );
        deploymentFlowStep3.copado__Branch__c = 'int';
        insert new List<copado__Deployment_Flow_Step__c>{ deploymentFlowStep1, deploymentFlowStep2, deploymentFlowStep3 };

        // Org Credential creation
        List<copado__Org__c> credentials = [
            SELECT Id, Name, copado__Environment__c, copado__Platform__c, copado__Oauth_Signature__c, copado__Validated_Date__c, copado__Disable_Validation__c, copado__SFDC_Org_ID__c
            FROM copado__Org__c
            WHERE copado__Platform__c = 'Other'
        ];
        for (copado__Org__c org : credentials) {
            org.copado__Username__c = UserInfo.getUserName();
            org.copado__SFDC_Org_ID__c = UserInfo.getOrganizationId() + '_' + UserInfo.getUserId();
            org.copado__Oauth_Signature__c = org.Name;
            org.copado__Validated_Date__c = System.now();
            org.copado__Disable_Validation__c = true;
            break;
        }
        update credentials;
        
        // Package creation
        copado__Artifact__c firstPackage = createPackages('FirstPackage', deploymentFlow.Id, gitRepository.Id);
        insert firstPackage;

        // Project creation 
        project = createProject('My project', deploymentFlow.Id, false);
        insert project;
        
        // Release creation
        copado__Release__c  testRelease = createRelease('Release 1.0.0.NEXT', project.Id);
        testRelease.copado__Version__c = '1.0.0.NEXT';
        testRelease.copado__Base_Branch__c = 'master';
        testRelease.copado__Status__c  = 'Draft';
        insert testRelease;

        // User Story creation
        userStory = createUserStory('us-0000000', 'Approved', null, project.Id, null, credentials[0].Id);
        userStory.copado__Promote_Change__c = true;
        userStory.copado__Release__c = testRelease.Id;
        insert userStory;
    }
    
    private static copado__Environment__c createEnvironments(String environmentName, String environmentType) {
        copado__Environment__c environment = new copado__Environment__c();
        environment.Name = environmentName;
        environment.copado__Index_Back_Promotion_metadata__c = true;
        environment.copado__Type__c = environmentType;

        return environment;
    }
    
    private static copado__JobTemplate__c createJobTemplate(String name, String apiName, Integer version, String volumeOptions) {
        // NOPMD : Supressing rule to avoid large refactor.
        copado__JobTemplate__c template = new copado__JobTemplate__c();
        template.Name = name;
        template.copado__ApiName__c = apiName;
        template.copado__Version__c = version;
        template.copado__VolumeOptions__c = volumeOptions;
        return template;
    }
    
    private static copado__JobStep__c createJobStep(String name, Id jobTemplateId, String type, Integer order, String configJson) {
        // NOPMD : Supressing rule to avoid large refactor.
        copado__JobStep__c step = new copado__JobStep__c();
        step.Name = name;
        step.copado__Type__c = type;
        step.copado__Order__c = order;
        step.copado__ConfigJson__c = configJson;
        step.copado__JobTemplate__c = jobTemplateId;
        return step;
    }
    
    private static copado__JobExecution__c createJobExecution(Id jobTemplateId, String status) {
        copado__JobExecution__c execution = new copado__JobExecution__c(copado__Template__c = jobTemplateId, copado__Status__c = status);
        return execution;
    }
    
    private static copado__Git_Repository__c createGitRepository() {
        copado__Git_Repository__c repo = new copado__Git_Repository__c();
        repo.Name = 'test repo';

        return repo;
    }

	private static copado__Deployment_Flow__c createDeploymentFlow(String name, Boolean isActive, String gitRepositoryId, Boolean enableDX) {
        // NOPMD : Supressing rule to avoid large refactor.
        copado__Deployment_Flow__c deploymentFlow = new copado__Deployment_Flow__c();
        deploymentFlow.Name = name;
        deploymentFlow.copado__Active__c = isActive;
        deploymentFlow.copado__Git_Repository__c = gitRepositoryId;
        deploymentFlow.copado__Enable_Copado_DX__c = enableDX;

        return deploymentFlow;
    }

    private static copado__Deployment_Flow_Step__c createDeploymentFlowStep(String sourceEnvironmentId, String destinationEnvironmentId, String deploymentFlowId, String scratchOrgDestination) {
        copado__Deployment_Flow_Step__c deploymentFlowStep = new copado__Deployment_Flow_Step__c();
        deploymentFlowStep.copado__Source_Environment__c = sourceEnvironmentId;
        deploymentFlowStep.copado__Destination_Environment__c = destinationEnvironmentId;
        deploymentFlowStep.copado__Deployment_Flow__c = deploymentFlowId;
        deploymentFlowStep.copado__Enable_as_Scratch_Org_Destination__c = scratchOrgDestination;

        return deploymentFlowStep;
    }

    private static copado__Project__c createProject(String name, String deploymentFlowId, Boolean indexMetadata) {
        copado__Project__c project = new copado__Project__c();
        project.Name = name;
        project.copado__Deployment_Flow__c = deploymentFlowId;
        project.copado__Index_Metadata__c = indexMetadata;

        return project;
    }
    
    private static copado__Release__c createRelease(String name, String projectId) {
        copado__Release__c release = new copado__Release__c();
        release.Name = name;
        release.copado__Project__c = projectId;

        return release;
    }
    
    private static copado__User_Story__c createUserStory(String userStoryTitle, String status, String sprintId, String projectId, String environmentId, String orgId) {
        copado__User_Story__c userStory = new copado__User_Story__c();
        userStory.copado__User_Story_Title__c = userStoryTitle;
        userStory.copado__Status__c = status;
        userStory.copado__Sprint__c = sprintId;
        userStory.copado__Project__c = projectId;
        userStory.copado__Environment__c = environmentId;
        userStory.copado__Org_Credential__c = orgId;

        return userStory;
    }
    
    private static copado__Promotion__c createPromotion(String projectId, String sourceOrgId, String sourceEnvId, String destinationOrgId, String destinationEnvId, String status) {
        copado__Promotion__c promotion = new copado__Promotion__c();
        promotion.copado__Project__c = projectId;
        promotion.copado__Source_Org_Credential__c = sourceOrgId;
        promotion.copado__Source_Environment__c = sourceEnvId;
        promotion.copado__Destination_Org_Credential__c = destinationOrgId;
        promotion.copado__Destination_Environment__c = destinationEnvId;
        promotion.copado__Status__c = status;

        return promotion;
    }
    
    private static copado__Deployment__c createDeployment(String name, String recordTypeId, String fromOrgId) {
        copado__Deployment__c deployment = new copado__Deployment__c();
        deployment.Name = name;
        deployment.copado__Active__c = true;
        deployment.copado__From_Org__c = fromOrgId;
        deployment.RecordTypeId = recordTypeId;

        return deployment;
    }
    
    private static copado__Result__c createResult(Id jobStepId, String type, String status, Id functionId) {
        copado__Result__c result = new copado__Result__c(copado__JobStep__c = jobStepId, copado__Job_Type__c = type, copado__Status__c = status, copado__Function__c = functionId);
        return result;
    }
    
    private static copado__Artifact__c createPackages(String name, String pipelineId, String repoId) {
        copado__Artifact__c artifact = new copado__Artifact__c(
                Name = name,
                RecordTypeId = Schema.SObjectType.copado__Artifact__c.getRecordTypeInfosByDeveloperName().get('Package_Artifact').getRecordTypeId(),
             	copado__Pipeline__c = pipelineId,
             	copado__Artifact_Repository__c  = repoId,
             	copado__Package_Type__c = 'Unlocked',
            	copado__DefaultBranch__c = 'master'
            );
        return artifact;
    }
    
    private static void addSelectedUserStoriesToPromotion(copado__Promotion__c promotion, List<Id> userStoryIds) {
        List<copado__Promoted_User_Story__c> promotedUserStories = new List<copado__Promoted_User_Story__c>();
        for (copado__User_Story__c userStory : [SELECT Id, Name FROM copado__User_Story__c WHERE Id IN :userStoryIds]) {
            String promotedUserStoryName = promotion.copado__Back_Promotion__c
                ? 'Back Promoted User Story: ' + userStory.Name
                : 'Promoted User Story: ' + userStory.Name;
            promotedUserStories.add(
                new copado__Promoted_User_Story__c(Name = promotedUserStoryName, copado__Promotion__c = promotion.Id, copado__User_Story__c = userStory.Id)
            );
        }
        
        SObjectAccessDecision decision = Security.stripInaccessible(AccessType.CREATABLE, promotedUserStories);
        insert decision.getRecords();
    }
    
    @IsTest
    static void multiCloudAutomatedPromotions() {
        User sysUser = [SELECT Id, Name, LastName, Email, Username FROM User WHERE Email = 'test1@test1.com' LIMIT 1];
        
        copado.GlobalAPI copadoGlobalAPI = new copado.GlobalAPI();
        copado.GlobalAPI.UserLicense userLicense = new copado.GlobalAPI.UserLicense();
        userLicense.isCCMEnabled = true;
        userLicense.isCopadoEnabled = true;
        userLicense.userId = sysUser.Id;
        copadoGlobalAPI.upsertCopadoLicense(userLicense);

        System.runAs(sysUser) {
            data();
            
            copado__Promotion__c promotionFromDev1ToInt = createPromotion(project.Id, null, environments[0].Id, null, null, 'Draft');
            copado__Promotion__c promotionFromIntToProd = createPromotion(project.Id, null, environments[2].Id, null, null, 'Draft');
            insert new List<copado__Promotion__c> { promotionFromDev1ToInt, promotionFromIntToProd };

            for(copado__Promotion__c promotion : [SELECT Id, copado__Last_Promotion_Execution_Id__c, copado__Last_Deployment_Execution_Id__c, copado__Status__c, copado__Back_Promotion__c, copado__Source_Environment__c, copado__Source_Org_Credential__c, copado__Destination_Environment__c, copado__Destination_Org_Credential__c FROM copado__Promotion__c WHERE Id = :promotionFromDev1ToInt.Id OR Id = :promotionFromIntToProd.Id]) {
                if(promotionFromDev1ToInt.Id == promotion.Id) {
                    promotionFromDev1ToInt = promotion;
                } 
                
                if(promotionFromIntToProd.Id == promotion.Id) {
                    promotionFromIntToProd = promotion;
                }
            }
            
            addSelectedUserStoriesToPromotion(promotionFromDev1ToInt, new List<Id>{ userStory.Id });
            addSelectedUserStoriesToPromotion(promotionFromIntToProd, new List<Id>{ userStory.Id });

            String advancedDeploymentRecordTypeId = Schema.Sobjecttype.copado__Deployment__c.getRecordTypeInfosByDeveloperName()
                .get('Advanced_multi_step')
                .getRecordTypeId();
            copado__Deployment__c advancedDeployment = createDeployment('Test Dev 2', advancedDeploymentRecordTypeId, null);
            advancedDeployment.copado__Promotion__c = promotionFromDev1ToInt.Id;
            copado__Deployment__c advancedDeployment1 = createDeployment('Test Dev 2', advancedDeploymentRecordTypeId, null);
            advancedDeployment1.copado__Promotion__c = promotionFromIntToProd.Id;
            insert new List<copado__Deployment__c>{ advancedDeployment, advancedDeployment1 };

            copado__JobExecution__c promotionExecution = createJobExecution(promotionJobTemplate.Id, 'Successful');
            promotionExecution.copado__Promotion__c = promotionFromDev1ToInt.Id;
            promotionExecution.copado__Callback__c = 'copado.PromoteAction';

            copado__JobExecution__c deploymentExecution = createJobExecution(deploymentJobTemplate.Id, 'Successful');
            promotionExecution.copado__Deployment__c = advancedDeployment.Id;
            promotionExecution.copado__Callback__c = 'copado.PromotionDeployAction';
            
            copado__JobExecution__c promotionExecution1 = createJobExecution(promotionJobTemplate.Id, 'Successful');
            promotionExecution1.copado__Promotion__c = promotionFromIntToProd.Id;
            promotionExecution1.copado__Callback__c = 'copado.PromoteAction';

            copado__JobExecution__c deploymentExecution1 = createJobExecution(deploymentJobTemplate.Id, 'Successful');
            deploymentExecution1.copado__Deployment__c = advancedDeployment1.Id;
            deploymentExecution1.copado__Callback__c = 'copado.PromotionDeployAction';
            insert new List<copado__JobExecution__c>{ promotionExecution, deploymentExecution, promotionExecution1, deploymentExecution1 };

            copado__JobStep__c functionPromotionExecutionStep = createJobStep(
                'Function',
                null,
                'Function',
                1,
                '{"functionName":"mulePromotion","parameters":[]}'
            );
            functionPromotionExecutionStep.copado__JobExecution__c = promotionExecution.Id;

            copado__JobStep__c functionDeploymentExecutionStep = createJobStep(
                'Function',
                null,
                'Function',
                1,
                '{"functionName":"muleDeployment","parameters":[]}'
            );
            functionDeploymentExecutionStep.copado__JobExecution__c = deploymentExecution.Id;
            
            copado__JobStep__c functionPromotionExecutionStep1 = createJobStep(
                'Function',
                null,
                'Function',
                1,
                '{"functionName":"mulePromotion","parameters":[]}'
            );
            functionPromotionExecutionStep1.copado__JobExecution__c = promotionExecution1.Id;

            copado__JobStep__c functionDeploymentExecutionStep1 = createJobStep(
                'Function',
                null,
                'Function',
                1,
                '{"functionName":"muleDeployment","parameters":[]}'
            );
            functionDeploymentExecutionStep1.copado__JobExecution__c = deploymentExecution1.Id;
            insert new List<copado__JobStep__c>{ functionPromotionExecutionStep, functionDeploymentExecutionStep, functionPromotionExecutionStep1, functionDeploymentExecutionStep1 };

            copado__Result__c functionPromotionExecutionStepResult = createResult(
                functionPromotionExecutionStep.Id,
                functionPromotion.copado__API_Name__c,
                'Success',
                functionPromotion.Id
            );
            copado__Result__c functionDeploymentExecutionStepResult = createResult(
                functionDeploymentExecutionStep.Id,
                functionDeployment.copado__API_Name__c,
                'Success',
                functionDeployment.Id
            );
            copado__Result__c functionPromotionExecutionStepResult1 = createResult(
                functionPromotionExecutionStep1.Id,
                functionPromotion.copado__API_Name__c,
                'Success',
                functionPromotion.Id
            );
            copado__Result__c functionDeploymentExecutionStepResult1 = createResult(
                functionDeploymentExecutionStep1.Id,
                functionDeployment.copado__API_Name__c,
                'Success',
                functionDeployment.Id
            );
            insert new List<copado__Result__c>{ functionPromotionExecutionStepResult, functionDeploymentExecutionStepResult, functionPromotionExecutionStepResult1, functionDeploymentExecutionStepResult1 };

            functionPromotionExecutionStep.copado__Result__c = functionPromotionExecutionStepResult.Id;
            functionDeploymentExecutionStep.copado__Result__c = functionDeploymentExecutionStepResult.Id;
            functionPromotionExecutionStep1.copado__Result__c = functionPromotionExecutionStepResult1.Id;
            functionDeploymentExecutionStep1.copado__Result__c = functionDeploymentExecutionStepResult1.Id;
            update new List<copado__JobStep__c>{ functionPromotionExecutionStep, functionDeploymentExecutionStep, functionPromotionExecutionStep1, functionDeploymentExecutionStep1 };
                
            Test.startTest();

            promotionFromDev1ToInt.copado__Last_Promotion_Execution_Id__c  = promotionExecution.Id;
            promotionFromDev1ToInt.copado__Last_Deployment_Execution_Id__c = deploymentExecution.Id;
            promotionFromDev1ToInt.copado__Status__c = 'Completed';
            
            promotionFromIntToProd.copado__Last_Promotion_Execution_Id__c  = promotionExecution1.Id;
            promotionFromIntToProd.copado__Last_Deployment_Execution_Id__c = deploymentExecution1.Id;
            promotionFromIntToProd.copado__Status__c = 'Completed';
            
            update new List<copado__Promotion__c>{ promotionFromDev1ToInt };   

            PrepareMCContinuousPromotions request = new PrepareMCContinuousPromotions();
            PrepareMCContinuousPromotions.execute(new List<Id>{ promotionFromDev1ToInt.Id });
            PrepareMCContinuousPromotions.execute(new List<Id>{ promotionFromIntToProd.Id });
            Test.stopTest();
        }
    }
    
    @IsTest
    static void multiCloudAutomatedPromotions1() {
        User sysUser = [SELECT Id, Name, LastName, Email, Username FROM User WHERE Email = 'test1@test1.com' LIMIT 1];
        
        copado.GlobalAPI copadoGlobalAPI = new copado.GlobalAPI();
        copado.GlobalAPI.UserLicense userLicense = new copado.GlobalAPI.UserLicense();
        userLicense.isCCMEnabled = true;
        userLicense.isCopadoEnabled = true;
        userLicense.userId = sysUser.Id;
        copadoGlobalAPI.upsertCopadoLicense(userLicense);

        System.runAs(sysUser) {
            data();
            
            copado__Promotion__c promotionFromDev1ToInt = createPromotion(project.Id, null, environments[0].Id, null, null, 'Draft');
            copado__Promotion__c promotionFromIntToProd = createPromotion(project.Id, null, environments[2].Id, null, null, 'Draft');
            insert new List<copado__Promotion__c> { promotionFromDev1ToInt, promotionFromIntToProd };

            for(copado__Promotion__c promotion : [SELECT Id, copado__Last_Promotion_Execution_Id__c, copado__Last_Deployment_Execution_Id__c, copado__Status__c, copado__Back_Promotion__c, copado__Source_Environment__c, copado__Source_Org_Credential__c, copado__Destination_Environment__c, copado__Destination_Org_Credential__c FROM copado__Promotion__c WHERE Id = :promotionFromDev1ToInt.Id OR Id = :promotionFromIntToProd.Id]) {
                if(promotionFromDev1ToInt.Id == promotion.Id) {
                    promotionFromDev1ToInt = promotion;
                } 
                
                if(promotionFromIntToProd.Id == promotion.Id) {
                    promotionFromIntToProd = promotion;
                }
            }
            
            addSelectedUserStoriesToPromotion(promotionFromDev1ToInt, new List<Id>{ userStory.Id });
            addSelectedUserStoriesToPromotion(promotionFromIntToProd, new List<Id>{ userStory.Id });

            String advancedDeploymentRecordTypeId = Schema.Sobjecttype.copado__Deployment__c.getRecordTypeInfosByDeveloperName()
                .get('Advanced_multi_step')
                .getRecordTypeId();
            copado__Deployment__c advancedDeployment = createDeployment('Test Dev 2', advancedDeploymentRecordTypeId, null);
            advancedDeployment.copado__Promotion__c = promotionFromDev1ToInt.Id;
            copado__Deployment__c advancedDeployment1 = createDeployment('Test Dev 2', advancedDeploymentRecordTypeId, null);
            advancedDeployment1.copado__Promotion__c = promotionFromIntToProd.Id;
            insert new List<copado__Deployment__c>{ advancedDeployment, advancedDeployment1 };

            copado__JobExecution__c promotionExecution = createJobExecution(promotionJobTemplate.Id, 'Successful');
            promotionExecution.copado__Promotion__c = promotionFromDev1ToInt.Id;
            promotionExecution.copado__Callback__c = 'copado.PromoteAction';

            copado__JobExecution__c deploymentExecution = createJobExecution(deploymentJobTemplate.Id, 'Successful');
            promotionExecution.copado__Deployment__c = advancedDeployment.Id;
            promotionExecution.copado__Callback__c = 'copado.PromotionDeployAction';
            
            copado__JobExecution__c promotionExecution1 = createJobExecution(promotionJobTemplate.Id, 'Successful');
            promotionExecution1.copado__Promotion__c = promotionFromIntToProd.Id;
            promotionExecution1.copado__Callback__c = 'copado.PromoteAction';

            copado__JobExecution__c deploymentExecution1 = createJobExecution(deploymentJobTemplate.Id, 'Successful');
            deploymentExecution1.copado__Deployment__c = advancedDeployment1.Id;
            deploymentExecution1.copado__Callback__c = 'copado.PromotionDeployAction';
            insert new List<copado__JobExecution__c>{ promotionExecution, deploymentExecution, promotionExecution1, deploymentExecution1 };

            copado__JobStep__c functionPromotionExecutionStep = createJobStep(
                'Function',
                null,
                'Function',
                1,
                '{"functionName":"mulePromotion","parameters":[]}'
            );
            functionPromotionExecutionStep.copado__JobExecution__c = promotionExecution.Id;

            copado__JobStep__c functionDeploymentExecutionStep = createJobStep(
                'Function',
                null,
                'Function',
                1,
                '{"functionName":"muleDeployment","parameters":[]}'
            );
            functionDeploymentExecutionStep.copado__JobExecution__c = deploymentExecution.Id;
            
            copado__JobStep__c functionPromotionExecutionStep1 = createJobStep(
                'Function',
                null,
                'Function',
                1,
                '{"functionName":"mulePromotion","parameters":[]}'
            );
            functionPromotionExecutionStep1.copado__JobExecution__c = promotionExecution1.Id;

            copado__JobStep__c functionDeploymentExecutionStep1 = createJobStep(
                'Function',
                null,
                'Function',
                1,
                '{"functionName":"muleDeployment","parameters":[]}'
            );
            functionDeploymentExecutionStep1.copado__JobExecution__c = deploymentExecution1.Id;
            insert new List<copado__JobStep__c>{ functionPromotionExecutionStep, functionDeploymentExecutionStep, functionPromotionExecutionStep1, functionDeploymentExecutionStep1 };

            copado__Result__c functionPromotionExecutionStepResult = createResult(
                functionPromotionExecutionStep.Id,
                functionPromotion.copado__API_Name__c,
                'Success',
                functionPromotion.Id
            );
            copado__Result__c functionDeploymentExecutionStepResult = createResult(
                functionDeploymentExecutionStep.Id,
                functionDeployment.copado__API_Name__c,
                'Success',
                functionDeployment.Id
            );
            copado__Result__c functionPromotionExecutionStepResult1 = createResult(
                functionPromotionExecutionStep1.Id,
                functionPromotion.copado__API_Name__c,
                'Success',
                functionPromotion.Id
            );
            copado__Result__c functionDeploymentExecutionStepResult1 = createResult(
                functionDeploymentExecutionStep1.Id,
                functionDeployment.copado__API_Name__c,
                'Success',
                functionDeployment.Id
            );
            insert new List<copado__Result__c>{ functionPromotionExecutionStepResult, functionDeploymentExecutionStepResult, functionPromotionExecutionStepResult1, functionDeploymentExecutionStepResult1 };

            functionPromotionExecutionStep.copado__Result__c = functionPromotionExecutionStepResult.Id;
            functionDeploymentExecutionStep.copado__Result__c = functionDeploymentExecutionStepResult.Id;
            functionPromotionExecutionStep1.copado__Result__c = functionPromotionExecutionStepResult1.Id;
            functionDeploymentExecutionStep1.copado__Result__c = functionDeploymentExecutionStepResult1.Id;
            update new List<copado__JobStep__c>{ functionPromotionExecutionStep, functionDeploymentExecutionStep, functionPromotionExecutionStep1, functionDeploymentExecutionStep1 };
                
            Test.startTest();

            promotionFromDev1ToInt.copado__Last_Promotion_Execution_Id__c  = promotionExecution.Id;
            promotionFromDev1ToInt.copado__Last_Deployment_Execution_Id__c = deploymentExecution.Id;
            promotionFromDev1ToInt.copado__Status__c = 'Completed';
            
            promotionFromIntToProd.copado__Last_Promotion_Execution_Id__c  = promotionExecution1.Id;
            promotionFromIntToProd.copado__Last_Deployment_Execution_Id__c = deploymentExecution1.Id;
            promotionFromIntToProd.copado__Status__c = 'Completed';
            
            update new List<copado__Promotion__c>{ promotionFromIntToProd };   

            PrepareMCContinuousPromotions request = new PrepareMCContinuousPromotions();
            PrepareMCContinuousPromotions.execute(new List<Id>{ promotionFromDev1ToInt.Id });
            PrepareMCContinuousPromotions.execute(new List<Id>{ promotionFromIntToProd.Id });
            Test.stopTest();
        }
    }
}