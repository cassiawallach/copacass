{
    "recordTypeMap": {},
    "RecordSetBundles": [
        {
            "Records": [
                {
                    "attributes": {
                      "type": "copado__JobTemplate__c",
                      "url": "/services/data/v54.0/sobjects/copado__JobTemplate__c/a0u7Z00000BeqzxQAB"
                    },
                    "copado__ApiName__c": "RunCrtTests",
                    "copado__Type__c": "Standard",
                    "copado__Version__c": 1,
                    "Id": "a0u7Z00000BeqzxQAB",
                    "LastReferencedDate": "2022-04-25T15:13:34.000+0000",
                    "LastViewedDate": "2022-04-25T15:13:34.000+0000",
                    "Name": "Run Copado Robotic Tests"
                  }
            ],
            "ObjectType": "copado__JobTemplate__c"
        },
        {
            "Records": [
                {
                    "attributes": {
                      "type": "copado__JobStep__c",
                      "url": "/services/data/v54.0/sobjects/copado__JobStep__c/a0t7Z00000JURFPQA5"
                    },
                    "copado__ApiName__c": "OrchestrateTestsExecution",
                    "copado__ConfigJson__c": "{\"flowName\":\"copadoQuality.RunCrtTests\",\"parameters\":[{\"name\":\"stepId\",\"value\":\"{$context.Id}\"},{\"name\":\"credentialBaseUrl\",\"value\":\"{$Source.Credential.Endpoint}\"},{\"name\":\"credentialSessionId\",\"value\":\"{$Source.Credential.SessionId}\"}]}",
                    "copado__CustomType__c": "Salesforce Flow",
                    "copado__JobTemplate__c": "a0u7Z00000BeqzxQAB",
                    "copado__Order__c": 2,
                    "copado__Type__c": "Flow",
                    "Id": "a0t7Z00000JURFPQA5",
                    "Name": "Orchestrate Tests Execution"
                  },
                  {
                    "attributes": {
                      "type": "copado__JobStep__c",
                      "url": "/services/data/v54.0/sobjects/copado__JobStep__c/a0t7Z00000JURFQQA5"
                    },
                    "copado__ApiName__c": "Run Copado Robotic Tests_Set Source Environment On CRT Job Execution",
                    "copado__ConfigJson__c": "{\"flowName\":\"copadoQuality.SetSourceEnvironmentOnCrtJobExecution\",\"parameters\":[{\"name\":\"jobExecutionId\",\"value\":\"{$Context.JobExecution__r.Id}\"},{\"name\":\"testIds\",\"value\":\"{$Context.JobExecution__r.DataJson.testIds}\"}]}",
                    "copado__CustomType__c": "Salesforce Flow",
                    "copado__JobTemplate__c": "a0u7Z00000BeqzxQAB",
                    "copado__Order__c": 1,
                    "copado__Type__c": "Flow",
                    "Id": "a0t7Z00000JURFQQA5",
                    "Name": "Set Source Environment On CRT Job Execution"
                  }
            ],
            "ObjectType": "copado__JobStep__c"
        },
        {
            "Records": [
              {
                "attributes": {
                  "type": "copado__ExtensionConfiguration__c",
                  "url": "/services/data/v54.0/sobjects/copado__ExtensionConfiguration__c/a0e7Q000000bs11QAA"
                },
                "CreatedDate": "2022-02-11T07:45:52.000+0000",
                "copado__ExtensionApplication__c": "Test",
                "Id": "a0e7Q000000bs11QAA",
                "IsDeleted": false,
                "LastModifiedDate": "2022-02-11T07:45:52.000+0000",
                "LastReferencedDate": "2022-02-11T07:45:52.000+0000",
                "LastViewedDate": "2022-02-11T07:45:52.000+0000",
                "Name": "Copado Robotic Testing [Copado Default]",
                "SystemModstamp": "2022-02-11T07:45:52.000+0000"
              }
            ],
            "ObjectType": "copado__ExtensionConfiguration__c"
          }
    ],
    "blobsByUID": {}
}