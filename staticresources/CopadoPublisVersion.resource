{
  "recordTypeMap": {},
  "RecordSetBundles": [
    {
      "Records": [
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v54.0/sobjects/copado__Function__c/aEg7Y0000008OuYSAU"
          },
          "copado__API_Name__c": "SFDX_Package_Version_Create",
          "copado__Description__c": "Create a package version record",
          "copado__Image_Name__c": "copado-multicloud-metadata:v1",
          "copado__Options__c": "[ ]",
          "copado__Parameters__c": "[ {\n  \"required\" : true,\n  \"name\" : \"ENDPOINT\",\n  \"defaultValue\" : \"{$Destination.Credential.Endpoint}\"\n}, {\n  \"required\" : true,\n  \"name\" : \"SESSION\",\n  \"defaultValue\" : \"{$Destination.Credential.SessionId}\"\n}, {\n  \"required\" : true,\n  \"name\" : \"packageId\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"versionName\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"versionNumber\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"description\",\n  \"defaultValue\" : \"\"\n}, {\n  \"required\" : false,\n  \"name\" : \"jsonInformation\",\n  \"defaultValue\" : \"\"\n}, {\n  \"required\" : true,\n  \"name\" : \"git_json\",\n  \"defaultValue\" : \"{$Context.Repository.Credential}\"\n} ]",
          "copado__Script__c": "#!/usr/bin/env node\n\nconst fs = require('fs');\nconst execSync = require('child_process').execSync;\nconst wait = 1000;\n\nconst endPoint = process.env['ENDPOINT'];\nconst session = process.env['SESSION'];\n\nconst packageId = process.env['packageId'];\nconst versionName = process.env['versionName'];\nconst versionNumber = process.env['versionNumber'];\nconst description = process.env['description'];\nconst params = JSON.parse(process.env['jsonInformation'].replace(/(\\\\r\\\\n|\\\\r|\\\\n|\\\\)/g, ''));\nconst branchName = params?.branch;\nconst baseUrl = endPoint.substring(0, endPoint.indexOf('/', endPoint.indexOf('/') + 2));\n\nfs.mkdirSync('sfProject');\nprocess.chdir('sfProject');\n\nconst setup = `\n    copado -p 'Cloning git repository'\n    copado-git-get ${branchName}\n    copado -p 'Checked out branch '${branchName}\n    \n\tcopado -p 'Setting instance url'\n    sfdx force:config:set instanceUrl=${baseUrl} --global\n`;\n\nexecSync(setup);\n\nlet flags = `\n${getFlag('loglevel', params?.loglevel)}\n${getFlag('targetdevhubusername', session)}\n${getFlag('apiversion', params?.apiversion)}\n${getStringFlag('package', packageId)}\n${getStringFlag('path', params?.path)}\n${getStringFlag('branch', branchName)}\n${getStringFlag('definitionfile', params?.definitionfile)}\n${getStringFlag('tag', params?.tag)}\n${getStringFlag('installationkey', params?.installationkey)}\n${getBooleanFlag('installationkeybypass', params?.installationkeybypass)}\n${getFlag('wait', wait)}\n${getStringFlag('versionname', versionName)}\n${getFlag('versionnumber', versionNumber)}\n${getStringFlag('versiondescription', description)}\n${getBooleanFlag('codecoverage', params?.codecoverage)}\n${getStringFlag('releasenotesurl', params?.releasenotesurl)}\n${getStringFlag('postinstallurl', params?.postinstallurl)}\n${getStringFlag('postinstallscript', params?.postinstallscript)}\n${getStringFlag('uninstallscript', params?.uninstallscript)}\n${getBooleanFlag('skipvalidation', params?.skipvalidation)}\n`;\n\nflags = flags.replace(/\\n|\\r/g, '');\n\nconst createCmd = `\n        \tcopado -p 'Creating package version'\n            sfdx force:package:version:create ${flags} --json > response.json\n            copado -p 'Finishing'\n        `;\n\nexecSync(createCmd);\n\nconst response = JSON.parse(fs.readFileSync('response.json'));\n\nlet updateCmd;\n\nif (response.status == 0 && response.result.Status == 'Success') {\n    const version = getLatestVersion();\n    commit(version);\n    updateCmd = `copado -p 'Package version created successfully' -r '${JSON.stringify(version)}'`;\n}\nelse if (response.status == 1 && response.name == 'Error') {\n\tupdateCmd = `copado -p 'Package Version creation failed'\n    \t\t\t\t\t-e '${JSON.stringify(response.message)}'\n                        -r '${JSON.stringify(response)}'\n                 exit 1`;\n}\nelse {\n\tupdateCmd = `copado -p 'Package version creation did not finish' -r '${JSON.stringify(response)}'`;\n}\n\nexecSync(updateCmd);\n\nfunction getFlag(flagname, value) {\n\treturn value ? ` --${flagname} ${value}` : '';\n}\n\nfunction getStringFlag(flagname, value) {\n\treturn value ? ` --${flagname} \"${value}\"` : '';\n}\n\nfunction getBooleanFlag(flagname, value) {\n\treturn value ? ` --${flagname}` : '';\n}\n\nfunction getLatestVersion() {\n\tconst listVersionsCmd = `sfdx force:package:version:list -v ${session} -p ${packageId} --json`;\n\tconst versions = JSON.parse(execSync(listVersionsCmd).toString());\n    const latestVersion = versions.result.find(\n  \t\t(version) => version.SubscriberPackageVersionId === response.result.SubscriberPackageVersionId\n\t);\n\n\treturn latestVersion;\n}\n\nfunction commit(version){\n    execSync(`git add \"sfdx-project.json\"`);\n    execSync(`git commit -m \"Committing sfdx-project.json. Package version ${version.Version}\"`);\n    execSync(`[[ -n ${version.Version} ]] && git tag ${version.Version}`);\n    execSync(`git push origin ${branchName} --tags`);\n}",
          "copado__Type__c": "Standard",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S",
          "CurrencyIsoCode": "USD",
          "Id": "aEg7Y0000008OuYSAU",
          "LastReferencedDate": "2022-04-13T08:47:06.000+0000",
          "LastViewedDate": "2022-04-13T08:47:06.000+0000",
          "Name": "SFDX Package Version Create"
        }
      ],
      "ObjectType": "copado__Function__c"
    }
  ],
  "blobsByUID": {}
}