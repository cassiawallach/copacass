{
    "recordTypeMap": {},
    "RecordSetBundles": [
        {
            "Records": [
                {
                    "attributes": {
                        "type": "copado__JobTemplate__c",
                        "url": "/services/data/v53.0/sobjects/copado__JobTemplate__c/a0t5g000000Nb2SAAS"
                    },
                    "copado__ApiName__c": "RunCrtTests",
                    "copado__Type__c": "Standard",
                    "copado__Version__c": 1,
                    "CreatedDate": "2021-11-18T06:12:06.000+0000",
                    "Id": "a0t5g000000Nb2SAAS",
                    "IsDeleted": false,
                    "LastModifiedDate": "2021-11-23T07:35:17.000+0000",
                    "LastReferencedDate": "2021-11-23T11:21:00.000+0000",
                    "LastViewedDate": "2021-11-23T11:21:00.000+0000",
                    "Name": "Run Copado Robotic Tests",
                    "SystemModstamp": "2021-11-23T07:35:17.000+0000"
                },
                {
                    "attributes": {
                      "type": "copado__JobTemplate__c",
                      "url": "/services/data/v54.0/sobjects/copado__JobTemplate__c/a0u7Z00000BeuNAQAZ"
                    },
                    "copado__ApiName__c": "Run PMD_1",
                    "copado__Type__c": "Standard",
                    "copado__Version__c": 1,
                    "Id": "a0u7Z00000BeuNAQAZ",
                    "LastReferencedDate": "2022-04-07T11:09:29.000+0000",
                    "LastViewedDate": "2022-04-07T11:09:29.000+0000",
                    "Name": "Run PMD"
                }
            ],
            "ObjectType": "copado__JobTemplate__c"
        },
        {
            "Records": [
                {
                    "attributes": {
                        "type": "copado__JobStep__c",
                        "url": "/services/data/v53.0/sobjects/copado__JobStep__c/a0s5g000000E0SBAA0"
                    },
                    "copado__ApiName__c": "OrchestrateTestsExecution",
                    "copado__ConfigJson__c": "{\"flowName\":\"copadoQuality.RunCrtTests\",\"parameters\":[{\"name\":\"stepId\",\"value\":\"{$context.Id}\"}]}",
                    "copado__CustomType__c": "Salesforce Flow",
                    "copado__JobTemplate__c": "a0t5g000000Nb2SAAS",
                    "copado__Order__c": 1,
                    "copado__Type__c": "Flow",
                    "CreatedDate": "2021-11-18T06:12:18.000+0000",
                    "Id": "a0s5g000000E0SBAA0",
                    "IsDeleted": false,
                    "LastModifiedDate": "2021-11-23T10:53:52.000+0000",
                    "Name": "Orchestrate Tests Execution",
                    "SystemModstamp": "2021-11-23T10:53:52.000+0000"
                },
                {
                    "attributes": {
                      "type": "copado__JobStep__c",
                      "url": "/services/data/v54.0/sobjects/copado__JobStep__c/a0t7Z00000IGdRzQAL"
                    },
                    "copado__ApiName__c": "Run PMD_Execute PMD",
                    "copado__ConfigJson__c": "{\"functionName\":\"RunPmd\",\"parameters\":[{\"name\":\"git_json\",\"value\":\"{$Context.Repository.Credential}\",\"required\":false},{\"name\":\"RulesetFileName\",\"value\":\"ruleset\",\"required\":false},{\"name\":\"TestResultId\",\"value\":\"{$Context.JobExecution__r.DataJson.resultIds}\",\"required\":false},{\"name\":\"branchesAndFileIdJson\",\"value\":\"{$Job.PrevStep.ResultDataJson__c}\"},{\"name\":\"deltaScan\",\"value\":\"true\"}]}",
                    "copado__CustomType__c": "Function",
                    "copado__JobTemplate__c": "a0u7Z00000BeuNAQAZ",
                    "copado__Order__c": 3,
                    "copado__Type__c": "Function",
                    "Id": "a0t7Z00000IGdRzQAL",
                    "Name": "Execute PMD"
                  },
                  {
                    "attributes": {
                      "type": "copado__JobStep__c",
                      "url": "/services/data/v54.0/sobjects/copado__JobStep__c/a0t7Z00000IGfOKQA1"
                    },
                    "copado__ApiName__c": "Run PMD_Set Pipeline On Job Execution",
                    "copado__ConfigJson__c": "{\"flowName\":\"copadoQuality.SetPipelineOnPMDJobExecution\",\"parameters\":[{\"name\":\"testIds\",\"value\":\"{$Context.JobExecution__r.DataJson.testIds}\"},{\"name\":\"jobExecutionId\",\"value\":\"{$Context.JobExecution__r.Id}\"}]}",
                    "copado__CustomType__c": "Salesforce Flow",
                    "copado__JobTemplate__c": "a0u7Z00000BeuNAQAZ",
                    "copado__Order__c": 1,
                    "copado__Type__c": "Flow",
                    "Id": "a0t7Z00000IGfOKQA1",
                    "Name": "Set Pipeline On Job Execution"
                  },
                  {
                    "attributes": {
                      "type": "copado__JobStep__c",
                      "url": "/services/data/v54.0/sobjects/copado__JobStep__c/a0t7Z00000IGfqYQAT"
                    },
                    "copado__ApiName__c": "Run PMD_Retrieve Branches and Ruleset File Id",
                    "copado__ConfigJson__c": "{\"flowName\":\"copadoQuality.RetrieveBranchesAndFileIdForPMDScan\",\"parameters\":[{\"name\":\"testIds\",\"value\":\"{$Context.JobExecution__r.DataJson.testIds}\"}]}",
                    "copado__CustomType__c": "Salesforce Flow",
                    "copado__JobTemplate__c": "a0u7Z00000BeuNAQAZ",
                    "copado__Order__c": 2,
                    "copado__Type__c": "Flow",
                    "Id": "a0t7Z00000IGfqYQAT",
                    "Name": "Retrieve Branches and Ruleset File Id"
                  },
                  {
                    "attributes": {
                      "type": "copado__JobStep__c",
                      "url": "/services/data/v54.0/sobjects/copado__JobStep__c/a0t7Z00000IGhFgQAL"
                    },
                    "copado__ApiName__c": "Run PMD_Evaluate PMD Acceptance Criteria",
                    "copado__ConfigJson__c": "{\"flowName\":\"copadoQuality.EvaluatePMDAcceptanceCriteria\",\"parameters\":[{\"name\":\"acceptanceCriteria\",\"value\":\"{$Context.JobExecution__r.DataJson.acceptanceCriteria}\"},{\"name\":\"resultIds\",\"value\":\"{$Context.JobExecution__r.DataJson.resultIds}\"}]}",
                    "copado__CustomType__c": "Salesforce Flow",
                    "copado__JobTemplate__c": "a0u7Z00000BeuNAQAZ",
                    "copado__Order__c": 4,
                    "copado__Type__c": "Flow",
                    "Id": "a0t7Z00000IGhFgQAL",
                    "Name": "Evaluate PMD Acceptance Criteria"
                  }
            ],
            "ObjectType": "copado__JobStep__c"
        },
        {
            "Records": [
              {
                "attributes": {
                  "type": "copado__Function__c",
                  "url": "/services/data/v54.0/sobjects/copado__Function__c/a0l7Z0000041qFDQAY"
                },
                "copado__API_Name__c": "RunPmd",
                "copado__Image_Name__c": "us.gcr.io/copado/copado-multicloud-mulesoft:v1",
                "copado__Options__c": "[ ]",
                "copado__Parameters__c": "[ {\n  \"required\" : false,\n  \"name\" : \"git_json\",\n  \"defaultValue\" : \"{$Context.Repository.Credential}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"RulesetFileName\",\n  \"defaultValue\" : \"ruleset\"\n}, {\n  \"required\" : false,\n  \"name\" : \"TestResultId\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"branchesAndFileIdJson\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"deltaScan\",\n  \"defaultValue\" : \"\"\n} ]",
                "copado__Script__c": "getPmd() {\n\twget https://github.com/pmd/pmd/releases/download/pmd_releases%2F6.43.0/pmd-bin-6.43.0.zip\n\tunzip pmd-bin-6.43.0.zip\n\tcd pmd-bin-6.43.0\n}\n\nparseBranchesAndFileIdJson() {\n\toriginBranch=$(jq -r '.originBranch' <<< $branchesAndFileIdJson)\n    destinationBranch=$(jq -r '.destinationBranch' <<< $branchesAndFileIdJson)\n    rulesetFileId=$(jq -r '.rulesetFileId' <<< $branchesAndFileIdJson)\n}\n\ngetCode() {\n \tcopado -p \"Fetching Git branches: $originBranch\"\n\tmkdir code && cd code\n\n \tgit_depth=${git_depth:-100}\n\n \tcopado-git-get --depth \"$git_depth\" \"$originBranch\"\n}\n\ngetDiffFiles() {\n\tcopado -p \"Comparing $originBranch with $destinationBranch to obtain diffs\"\n    git fetch\n    git checkout $destinationBranch\n    git checkout $originBranch\n\tdiff=$(git diff --name-only origin/$originBranch..origin/$destinationBranch)\n\tfiles=\"\"\n    \n    for file in $diff;\n\tdo  \n    \tfile=$(echo $file | sed 's/.*\\///')\n    \tfiles=\"$files$file,\"\n\tdone\n\n\tfiles=${files::-1}\n    echo $files\n}\n\nremoveUnwantedFiles() {\n\tcd ..\n\tbase_command=\"find 'code/' -type f\"\n\n\tIFS=','\n\tfor value in ${files};\n\tdo  \n    \tbase_command=\"${base_command} -not -iname '${value}'\"\n\tdone\n\n\tbase_command=\"${base_command} -delete\"\n\n\techo ${base_command}\n\teval ${base_command}\n}\n\ngetRuleset() {\n\tcopado -p \"Downloading Ruleset file\"\n\tcopado --downloadfiles \"$rulesetFileId\" --downloaddir /tmp/\n\truleset=$(</tmp/\"$RulesetFileName\")\n}\n\nrunOriginBranchScan() {\n\tcopado -p \"Running PMD Scan\"\n    cat /tmp/ruleset\n\t./bin/run.sh pmd -d code/ -f sarif -R /tmp/ruleset > pmd-output.sarif.json || true\n}\n\ngetFilesInDestinationBranch() {\n  \tmkdir dest && cd dest\n  \tcopado-git-get \"$destinationBranch\"\n  \tcd ..\n  \n\tbase_command=\"find 'dest/' -type f\"\n\n\tIFS=','\n\tfor value in ${files};\n\tdo  \n    \tbase_command=\"${base_command} -not -iname '${value}'\"\n\tdone\n\n\tbase_command=\"${base_command} -delete\"\n\n\techo ${base_command}\n\teval ${base_command}\n}\n\nrunDestinationBranchScan() {\n\t./bin/run.sh pmd -d dest/ -f sarif -R /tmp/ruleset > pmd-dest-output.sarif.json || true\n}\n\ndeltaScanOutput() {\n######################## DELTA SCAN NODE.JS SCRIPT START ########################\ncat << __EOF__ > ./main.js\nconst fs = require('fs');\n\nconst sarifDest = JSON.parse(fs.readFileSync('pmd-dest-output.sarif.json'));\nconst sarifSrc = JSON.parse(fs.readFileSync('pmd-output.sarif.json'));\n\nconst originalViolations = flatten(sarifDest);\nconst latestViolations = flatten(sarifSrc);\n\nconst deltaViolations = latestViolations.filter( (violation) => isNew(violation, originalViolations));\n\nconst deltaSarif = createDeltaSarif(sarifSrc, deltaViolations);\nfs.writeFileSync('delta.sarif.json', JSON.stringify(deltaSarif, null, 2));\n\nfunction createDeltaSarif(completeSarif, deltaViolations) {\n    const result = completeSarif;\n\n    result.runs[0].tool.driver.rules = result.runs[0].tool.driver.rules.filter((rule) => idInViolations(rule.id, deltaViolations));\n\n    result.runs[0].results = result.runs[0].results.filter((result) => idInViolations(result.ruleId, deltaViolations));\n\n    result.runs[0].results = result.runs[0].results.filter((result) => {\n        result.locations = result.locations.filter((location) => {\n            let isNewLocation = false;\n\n            deltaViolations.forEach((newViolation) => {\n                if (result.ruleId == newViolation.ruleId &&\n                    withoutPrefix(location.physicalLocation.artifactLocation.uri) == newViolation.uri &&\n                    JSON.stringify(location.physicalLocation.region) == JSON.stringify(newViolation.region)) {\n                        isNewLocation = true;\n                    }\n            })\n\n            return isNewLocation;\n        });\n\n        return result.locations.length > 0;\n    });\n\n    return result;\n}\n\n\n\nfunction idInViolations(id, violations) {\n    let result = false;\n\n    violations.forEach((violation) => {\n        if (id == violation.ruleId) {\n            result = true;\n        }\n    });\n\n    return result;\n}\n\nfunction flatten(sarif) {\n    return sarif.runs[0].results.reduce( (result, ruleViolations) =>\n            result.concat(ruleViolations.locations.map((location) => {\n                return {\n                    ruleId: ruleViolations.ruleId,\n                    region: location.physicalLocation.region,\n                    uri: withoutPrefix(location.physicalLocation.artifactLocation.uri)\n                }\n            }))\n    , []);\n}\n\nfunction isNew(violation, originalViolations) {\n    let result = true;\n\n    originalViolations.forEach((originalViolation) => {\n        if (JSON.stringify(originalViolation) == JSON.stringify(violation)) {\n            result = false;\n        }\n    });\n\n\treturn result;\n}\n\nfunction withoutPrefix(uri) {\n    return uri.split('code/').pop().split('dest/').pop();\n}\n__EOF__\n######################## DELTA SCAN NODE.JS SCRIPT END ########################\n\n\tviolations=$(node main.js)\n}\n\nattachResult() {\n\tcopado -p \"Uploading Analysis Output\"\n\ttestResultId=$(echo $TestResultId | sed -e \"s/\\[//g\" | sed -e \"s/\\]//g\" | xargs)\n\n    if [ \"$deltaScan\" == 'true' ];\n    then\n    \tcopado -u delta.sarif.json --name \"pmd-output.sarif.json\"\n        copado -u delta.sarif.json --name \"pmd-output.sarif.json\" --parentid $testResultId\n    else\n    \tcopado -u pmd-output.sarif.json\n        copado -u pmd-output.sarif.json --parentid $testResultId\n    fi\n}\n\ngetPmd\nparseBranchesAndFileIdJson\ngetCode\ngetDiffFiles\nremoveUnwantedFiles\ngetRuleset\nrunOriginBranchScan\nif [ \"$deltaScan\" == 'true' ];\nthen\n\tcopado -p \"Executing Delta Scan\"\n\tgetFilesInDestinationBranch\n\trunDestinationBranchScan\n\tdeltaScanOutput\nfi\nattachResult",
                "copado__Timeout__c": 1440,
                "copado__Type__c": "Standard",
                "copado__Version__c": "1",
                "copado__Worker_Size__c": "S",
                "Id": "a0l7Z0000041qFDQAY",
                "LastReferencedDate": "2022-04-07T14:51:27.000+0000",
                "LastViewedDate": "2022-04-07T14:51:27.000+0000",
                "Name": "Run PMD"
              }
            ],
            "ObjectType": "copado__Function__c"
        }
    ],
    "blobsByUID": {}
}