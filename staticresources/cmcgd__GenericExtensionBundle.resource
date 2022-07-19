{
  "recordTypeMap": {},
  "RecordSetBundles": [
    {
      "Records": [
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v54.0/sobjects/copado__Function__c/a0l3N000001j3LHQAY"
          },
          "copado__API_Name__c": "gdevops_commit",
          "copado__Image_Name__c": "copado-function-core:v1",
          "copado__Options__c": "[ ]",
          "copado__Parameters__c": "[ {\n  \"name\" : \"COPADO_DEVOPSTOOLS_URL\",\n  \"defaultValue\" : \"{Pipeline.Property.COPADO_DEVOPSTOOLS_URL}\"\n}, {\n  \"name\" : \"COPADO_DEVOPSTOOLS_VERSION\",\n  \"defaultValue\" : \"{Pipeline.Property.COPADO_DEVOPSTOOLS_VERSION}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_json\",\n  \"defaultValue\" : \"{$Context.Repository.Credential}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_email\",\n  \"defaultValue\" : \"{$User.Email}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_name\",\n  \"defaultValue\" : \"{$User.Name}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_depth\",\n  \"defaultValue\" : \"{$Pipeline.property.git_depth}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"file_changes_id\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.fileWithSelectedChanges}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"feature_branch\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.featureBranchName}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"recreate_if_exists\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.recreateFeatureBranch}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"commit_message\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.message}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"base_branch\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.baseBranch}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"replacement_rules\",\n  \"defaultValue\" : \"{$Pipeline.property.replacement_rules}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"environment_variables\",\n  \"defaultValue\" : \"{$Source.apex.EnvironmentVariables}\"\n} ]",
          "copado__Script__c": "#!/bin/bash\nset -euo pipefail\n\n# the following line will be removed in the actual production Functions. It is used for internal testing and development\nif [ -n \"${COPADO_DEVOPSTOOLS_URL:-}\" ]; then pip install --user \"$COPADO_DEVOPSTOOLS_URL\"  ${COPADO_DEVOPSTOOLS_VERSION:+\"$COPADO_DEVOPSTOOLS_VERSION\"}; export PATH=$PATH:~/.local/bin; echo \"(${SECONDS}s elapsed)\"; echo; fi\ncd /app\n\nsource copado_init\nfunction_parameter git_json '{$Context.Repository.Credential}'\nfunction_parameter git_email '{$User.Email}'\nfunction_parameter git_name '{$User.Name}'\nfunction_parameter git_depth '{$Pipeline.property.git_depth}'\nfunction_parameter file_changes_id '{$Context.JobExecution__r.DataJson.fileWithSelectedChanges}'\nfunction_parameter feature_branch '{$Context.JobExecution__r.DataJson.featureBranchName}'\nfunction_parameter recreate_if_exists '{$Context.JobExecution__r.DataJson.recreateFeatureBranch}'\nfunction_parameter commit_message '{$Context.JobExecution__r.DataJson.message}'\nfunction_parameter base_branch '{$Context.JobExecution__r.DataJson.baseBranch}'\nfunction_parameter replacement_rules '{$Pipeline.property.replacement_rules}' --optional\nfunction_parameter environment_variables '{$Source.apex.EnvironmentVariables}'\n\nfunction retrieve_changes() {\n    # NOTE: mock of retrieve changes\n    copado_file_mapper --filter-action add --root-directory=/tmp/retrieve --mock-retrieve | limit_output\n}\n\nfunction merge_retrieved_changes() {\n    echo '[merge] merge the retrieved files into the repository'\n    cp -afT /tmp/retrieve/ .\n    echo '[merge] delete any change marked as deletion'\n    copado_file_mapper --filter-action delete --delete | limit_output\n}\n\ncopado_files --download-id \"$file_changes_id\" --destination ~/.changes.json --do-not-overwrite\ncopado_log_changes\n\ncopado -p \"Retrieving changes\"\nprofiler retrieve_changes\n\ncopado -p \"Fetching branches\"\nprofiler copado_git --depth \"$git_depth\" \"$base_branch\"\nprofiler copado_git --depth \"$git_depth\" -c \"$feature_branch\"\n\nprofiler merge_retrieved_changes\n\ncopado -p \"Applying replacement rules\"\necho \"$replacement_rules\" > ~/.replacement_rules.json\necho \"$environment_variables\" > ~/.environment_variables.json\nprofiler copado_replacer --env-vars-replace-names --branch \"$feature_branch\"\n\necho '[git commit]'\nprofiler git add .\ngit commit -am \"$commit_message\" -- | limit_output || copado_finish 0 \"No changes\" '{\"status\": \"No changes\"}' \"\"\n\ncopado -p \"Pushing branch\"\nif [[ \"$recreate_if_exists\" == \"true\" && -n \"$(git ls-remote -h origin \"$feature_branch\")\" ]]; then\n    echo \"[git delete] re-create feature branch\"\n    git push origin --quiet --delete \"$feature_branch\" || true\nfi\nprofiler git push origin \"$feature_branch\"\ncopado -p \"Commit completed successfully (${SECONDS}s)\" -r '{\"status\": \"Complete\", \"commitId\": \"'\"$(git rev-parse HEAD)\"'\"}'",
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S",
          "Id": "a0l3N000001j3LHQAY",
          "Name": "gdevops_commit"
        },
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v54.0/sobjects/copado__Function__c/a0l3N000001j3LIQAY"
          },
          "copado__API_Name__c": "gdevops_promote",
          "copado__Image_Name__c": "copado-function-core:v1",
          "copado__Options__c": "[ ]",
          "copado__Parameters__c": "[ {\n  \"name\" : \"COPADO_DEVOPSTOOLS_URL\",\n  \"defaultValue\" : \"{Pipeline.Property.COPADO_DEVOPSTOOLS_URL}\"\n}, {\n  \"name\" : \"COPADO_DEVOPSTOOLS_VERSION\",\n  \"defaultValue\" : \"{Pipeline.Property.COPADO_DEVOPSTOOLS_VERSION}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_json\",\n  \"defaultValue\" : \"{$Context.Repository.Credential}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_email\",\n  \"defaultValue\" : \"{$User.Email}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_name\",\n  \"defaultValue\" : \"{$User.Name}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_depth\",\n  \"defaultValue\" : \"{$Pipeline.property.git_depth}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"file_changes_id\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.fileWithSelectedChanges}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"promotion_branch\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.promotionBranchName}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"target_branch\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.destinationBranchName}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"user_stories\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.userStoryBranches}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"promotion_id\",\n  \"defaultValue\" : \"{$Job.ExecutionParent.Id}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"repository_id\",\n  \"defaultValue\" : \"{$Pipeline.Git_Repository__r.Id}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"release_version\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.Promotion__r.Release__r.Version__c}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"exclude_autoresolve\",\n  \"defaultValue\" : \"{$Pipeline.property.exclude_autoresolve}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"conflict_resolution_attachments\",\n  \"defaultValue\" : \"{$Context.apex.GetConflictResolutionAttachments}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"smart_conflict_resolution_enabled\",\n  \"defaultValue\" : \"{$Pipeline.property.smart_conflict_resolution_enabled}\"\n} ]",
          "copado__Script__c": "#!/bin/bash\nset -euo pipefail\n# the following line should be removed in the actual production Functions. It is used for internal testing and development\nif [ -n \"${COPADO_DEVOPSTOOLS_URL:-}\" ]; then pip install --user \"$COPADO_DEVOPSTOOLS_URL\"  ${COPADO_DEVOPSTOOLS_VERSION:+\"$COPADO_DEVOPSTOOLS_VERSION\"}; export PATH=$PATH:~/.local/bin; echo \"(${SECONDS}s elapsed)\"; echo; fi\ncd /app\n\nsource copado_init\nfunction_parameter git_json '{$Context.Repository.Credential}'\nfunction_parameter git_email '{$User.Email}'\nfunction_parameter git_name '{$User.Name}'\nfunction_parameter git_depth '{$Pipeline.property.git_depth}'\nfunction_parameter file_changes_id '{$Context.JobExecution__r.DataJson.fileWithSelectedChanges}'\nfunction_parameter promotion_branch '{$Context.JobExecution__r.DataJson.promotionBranchName}'\nfunction_parameter target_branch '{$Context.JobExecution__r.DataJson.destinationBranchName}'\nfunction_parameter user_stories '{$Context.JobExecution__r.DataJson.userStoryBranches}'\nfunction_parameter promotion_id '{$Job.ExecutionParent.Id}'\nfunction_parameter repository_id '{$Pipeline.Git_Repository__r.Id}'\nfunction_parameter release_version '{$Context.JobExecution__r.Promotion__r.Release__r.Version__c}' --optional\nfunction_parameter exclude_autoresolve '{$Pipeline.property.exclude_autoresolve}'\nfunction_parameter conflict_resolution_attachments '{$Context.apex.GetConflictResolutionAttachments}'\nfunction_parameter smart_conflict_resolution_enabled '{$Pipeline.property.smart_conflict_resolution_enabled}'\n\nfunction fail_if_online_conflict_required() {\n    local exit_code=\"$1\"\n    if [[ $exit_code -eq 22 ]]; then\n        copado_finish 22 \"Conflict found while merging\" '{\"status\": \"conflicts\"}' \"Online conflict resolution required. Please correct the conflicts in the Promotion\"\n    fi\n}\n\nfunction fail_if_review_failed() {\n    local exit_code=\"$1\"\n    if [[ $exit_code -ne 0 ]]; then\n        copado_finish \"$exit_code\" \"Error reviewing conflicts. The error code was $exit_code\" \"\" \"Error reviewing conflicts. Please review the Logs of the operation\";\n    fi\n}\n\nfunction git_checkout_feature_branches() {\n    for merge_branch in \"${branches[@]}\"; do\n        git checkout -q \"$merge_branch\"\n    done\n}\n\n# get the feature branches from the parameters, filter out branches that do not exist in the remote, and leave the\n# result in the \"$branches\" variable\nfunction parse_feature_branches() {\n    jq -r -c '.[]' <<< \"$user_stories\" > ~/.git_branches.txt\n    readarray -t branches < ~/.git_branches.txt\n    echo \"[feature_branches] reading feature branches  ${branches[*]};\"\n    git ls-remote -h origin -- \"${branches[@]}\" | sed -e 's|^.*refs/heads/||g' > ~/.git_branches.txt\n    readarray -t branches < ~/.git_branches.txt\n    echo \"[feature_branches] existing feature branches ${branches[*]};\"\n}\n\n# merge each branch, in order, to the feature branch, resolving merges and conflicts, and committing the changes, if any.\nfunction merge_copado() {\n    for merge_branch in \"${branches[@]}\"; do\n        echo $'\\n'\"[merging] $merge_branch\"\n        # never fail, copado will process the result\n        git merge -- \"$merge_branch\" | limit_output || true\n        git status --porcelain=v2 > ~/.git_merge_result.txt\n        exit_code=0; copado_conflict_resolution --promotion-id \"$promotion_id\" --feature-branch \"$merge_branch\" || exit_code=$?\n        fail_if_online_conflict_required $exit_code\n        fail_if_review_failed $exit_code\n        git add .\n        # never fail, there might not be anything to commit\n        git commit -am \"Copado automatic merge of $merge_branch\" || true\n    done\n}\n\ncopado_files --download-id \"$file_changes_id\" --destination ~/.changes.json --do-not-overwrite\ncopado_log_changes\n\ncopado -p \"Preparing repository\"\ncopado_git --initialize-only \"$target_branch\"\nparse_feature_branches\ncopado -p \"Fetching branches\"\nprofiler copado_git --depth \"$git_depth\" -- \"$target_branch\" \"${branches[*]}\"\nprofiler git_checkout_feature_branches\n\necho \"[promotion] re-creating promotion branch\"\ngit checkout -b \"$promotion_branch\" \"$target_branch\"\n\ncopado -p \"Merging branches into promotion\"\necho \"$conflict_resolution_attachments\" > ~/.online_resolved.json\nprofiler merge_copado\n\ncopado_log_git_history \"$target_branch\" \"$promotion_branch\"\n\ncopado -p \"Pushing branch\"\n# delete the remote branch if it already exists, never fail\n[[ -n \"$(git ls-remote -h origin \"$promotion_branch\")\" ]] \\\n    && git push origin --quiet --delete \"$promotion_branch\" || true\n# tag the release, if present\n[[ -n \"$release_version\" ]] && git tag \"$release_version\"\nprofiler git push origin --follow-tags \"$promotion_branch\"\n\ncopado_finish 0 \"Promote completed successfully (${SECONDS}s)\" \"\"",
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S",
          "Id": "a0l3N000001j3LIQAY",
          "Name": "gdevops_promote"
        },
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v54.0/sobjects/copado__Function__c/a0l3N000001j3LJQAY"
          },
          "copado__API_Name__c": "gdevops_deploy",
          "copado__Image_Name__c": "copado-function-core:v1",
          "copado__Options__c": "[ ]",
          "copado__Parameters__c": "[ {\n  \"name\" : \"COPADO_DEVOPSTOOLS_URL\",\n  \"defaultValue\" : \"{Pipeline.Property.COPADO_DEVOPSTOOLS_URL}\"\n}, {\n  \"name\" : \"COPADO_DEVOPSTOOLS_VERSION\",\n  \"defaultValue\" : \"{Pipeline.Property.COPADO_DEVOPSTOOLS_VERSION}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_json\",\n  \"defaultValue\" : \"{$Context.Repository.Credential}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_email\",\n  \"defaultValue\" : \"{$User.Email}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_name\",\n  \"defaultValue\" : \"{$User.Name}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_depth\",\n  \"defaultValue\" : \"{$Pipeline.property.git_depth}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"file_changes_id\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.fileWithSelectedChanges}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"promotion_branch\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.promotionBranchName}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"target_branch\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.destinationBranchName}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"replacement_rules\",\n  \"defaultValue\" : \"{$Pipeline.property.replacement_rules}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"environment_variables\",\n  \"defaultValue\" : \"{$Destination.apex.EnvironmentVariables}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"release_version\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.Promotion__r.Release__r.Version__c}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"deploy_id\",\n  \"defaultValue\" : \"{$Job.ExecutionParent.Id}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"dry_run\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.deploymentDryRun}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"builder_config\",\n  \"defaultValue\" : \"{$Destination.property.builder_config}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"rollback_enabled\",\n  \"defaultValue\" : \"true\"\n} ]",
          "copado__Script__c": "#!/bin/bash\nset -euo pipefail\n# the following line should be removed in the actual production Functions. It is used for internal testing and development\nif [ -n \"${COPADO_DEVOPSTOOLS_URL:-}\" ]; then pip install --user \"$COPADO_DEVOPSTOOLS_URL\"  ${COPADO_DEVOPSTOOLS_VERSION:+\"$COPADO_DEVOPSTOOLS_VERSION\"}; export PATH=$PATH:~/.local/bin; echo \"(${SECONDS}s elapsed)\"; echo; fi\ncd /app\n\nsource copado_init\nfunction_parameter git_json '{$Context.Repository.Credential}'\nfunction_parameter git_email '{$User.Email}'\nfunction_parameter git_name '{$User.Name}'\nfunction_parameter git_depth '{$Pipeline.property.git_depth}'\nfunction_parameter file_changes_id '{$Context.JobExecution__r.DataJson.fileWithSelectedChanges}'\nfunction_parameter promotion_branch '{$Context.JobExecution__r.DataJson.promotionBranchName}'\nfunction_parameter target_branch '{$Context.JobExecution__r.DataJson.destinationBranchName}'\nfunction_parameter replacement_rules '{$Pipeline.property.replacement_rules}' --optional\nfunction_parameter environment_variables '{$Destination.apex.EnvironmentVariables}'\nfunction_parameter release_version '{$Context.JobExecution__r.Promotion__r.Release__r.Version__c}' --optional\nfunction_parameter deploy_id '{$Job.ExecutionParent.Id}'\nfunction_parameter dry_run '{$Context.JobExecution__r.DataJson.deploymentDryRun}'\nfunction_parameter builder_config '{$Destination.property.builder_config}'\nfunction_parameter rollback_enabled 'true'\n\ncopado_files --download-id \"$file_changes_id\" --destination ~/.changes.json --do-not-overwrite\ncopado_log_changes\n\ncopado -p \"fetching branches\"\nprofiler copado_git --depth \"$git_depth\" \"$promotion_branch\" \"$target_branch\"\n\nif [[ \"$rollback_enabled\" == \"true\" && \"$dry_run\" != \"true\" ]]; then\n    copado -p \"preparing rollback branch\"\n    rollback_branch=\"${promotion_branch/promotion/rollback-promotion}\"\n    # delete the remote branch if it already exists\n    [[ -n \"$(git ls-remote -h origin \"$rollback_branch\")\" ]] \\\n        && git push origin --quiet --delete \"$rollback_branch\" || true\n    git checkout \"$target_branch\"\n    copado_git --depth \"$git_depth\" -c \"$rollback_branch\"\n    echo\nfi\n\ncopado -p \"Merging branches\"\ngit checkout \"$promotion_branch\"\ngit checkout \"$target_branch\"\n# merge before deploying, to fail early if the merge cannot happen due to conflicts\ngit merge --no-progress \"$promotion_branch\" | limit_output \\\n    || copado_finish  1 \"git merge failed\" \"{}\" \"Could not merge promotion branch into destination branch\"\n\ncopado -p \"Applying replacement rules and environment rules...\"\necho \"$replacement_rules\" > ~/.replacement_rules.json\necho \"$environment_variables\" > ~/.environment_variables.json\nprofiler copado_replacer --branch \"$target_branch\"\n\necho \"$builder_config\" > ~/.builder_config.json\nif [ \"$dry_run\" == 'true' ]; then\n    copado -p \"Deploying (dry run) the promotion branch\"\n    profiler copado_builder\n    copado -p \"Deployment (dry run) successful (${SECONDS}s)\"\nelse\n    copado -p \"Deploying the changes of the promotion branch $promotion_branch\"\n    profiler copado_builder\n\n    copado -p \"Pushing result\"\n    git checkout -- .  # clear any change made by copado_replacer\n    profiler git push --all origin \\\n        || copado_finish 1 \"Deployment successful, but git merge failed\" \"{}\" \"Could not merge promotion branch into destination branch\"\n    copado_finish 0 \"Deployment successful (${SECONDS}s)\" \"{}\" \"\"\nfi",
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S",
          "Id": "a0l3N000001j3LJQAY",
          "Name": "gdevops_deploy"
        },
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v54.0/sobjects/copado__Function__c/a0l3N000001j3LKQAY"
          },
          "copado__API_Name__c": "gdevops_rollback",
          "copado__Image_Name__c": "copado-function-core:v1",
          "copado__Options__c": "[ ]",
          "copado__Parameters__c": "[ {\n  \"name\" : \"COPADO_DEVOPSTOOLS_URL\",\n  \"defaultValue\" : \"{Pipeline.Property.COPADO_DEVOPSTOOLS_URL}\"\n}, {\n  \"name\" : \"COPADO_DEVOPSTOOLS_VERSION\",\n  \"defaultValue\" : \"{Pipeline.Property.COPADO_DEVOPSTOOLS_VERSION}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_json\",\n  \"defaultValue\" : \"{$Context.Repository.Credential}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_email\",\n  \"defaultValue\" : \"{$User.Email}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_name\",\n  \"defaultValue\" : \"{$User.Name}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"git_depth\",\n  \"defaultValue\" : \"{$Pipeline.property.git_depth}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"file_changes_id\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.fileWithSelectedChanges}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"backup_branch\",\n  \"defaultValue\" : \"...\"\n}, {\n  \"required\" : false,\n  \"name\" : \"feature_branch\",\n  \"defaultValue\" : \"...\"\n} ]",
          "copado__Script__c": "#!/bin/bash\nset -euo pipefail\n# the following line should be removed in the actual production Functions. It is used for internal testing and development\nif [ -n \"${COPADO_DEVOPSTOOLS_URL:-}\" ]; then pip install --user \"$COPADO_DEVOPSTOOLS_URL\"  ${COPADO_DEVOPSTOOLS_VERSION:+\"$COPADO_DEVOPSTOOLS_VERSION\"}; export PATH=$PATH:~/.local/bin; echo \"(${SECONDS}s elapsed)\"; echo; fi\ncd /app\n\nsource copado_init\nfunction_parameter git_json '{$Context.Repository.Credential}'\nfunction_parameter git_email '{$User.Email}'\nfunction_parameter git_name '{$User.Name}'\nfunction_parameter git_depth '{$Pipeline.property.git_depth}'\nfunction_parameter file_changes_id '{$Context.JobExecution__r.DataJson.fileWithSelectedChanges}'\nfunction_parameter backup_branch '...'\nfunction_parameter feature_branch '...'\n\nfunction limit_output() { sed -n '1,100p'; }\n\ncopado_files --download-id \"$file_changes_id\" --destination ~/.changes.json --do-not-overwrite\ncopado_log_changes\n\ncopado -p \"fetching branches\"\nprofiler copado_git --depth \"$git_depth\" \"$backup_branch\"\nprofiler copado_git --depth \"$git_depth\" \"$target_branch\"\nprofiler copado_git --depth \"$git_depth\" -c \"$feature_branch\"\n\ncopado -p \"restoring files\"\ncopado_file_mapper > /tmp/restore.txt\ngit restore --progress --source \"$backup_branch\" --pathspec-from-file=/tmp/restore.txt\necho\n\necho '[git commit]'\nprofiler git add -v . | limit_output\ngit commit -am \"Rollback from $backup_branch\" -- | limit_output || copado_finish 0 \"No changes\" '{\"status\": \"No changes\"}' \"\"\n\ncopado -p \"Pushing result\"\ndu -xmsh /app\ngit checkout -- .  # clear any change made by copado_replacer\nprofiler git push origin \"$target_branch\" \\\n    || copado_finish 1 \"Rollback successful, but git merge failed\" \"{}\" \"Could not merge promotion branch into destination branch\"\ncopado -p \"Rollback completed successfully (${SECONDS}s)\" -r '{\"status\": \"Complete\", \"commitId\": \"'$(git rev-parse HEAD)'\"}'",
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S",
          "Id": "a0l3N000001j3LKQAY",
          "Name": "gdevops_rollback"
        }
      ],
      "ObjectType": "copado__Function__c"
    },
    {
      "Records": [
        {
          "attributes": {
            "type": "copado__JobTemplate__c",
            "url": "/services/data/v54.0/sobjects/copado__JobTemplate__c/a0u3N000006l5iwQAA"
          },
          "copado__ApiName__c": "gdevops_commit_1",
          "copado__Type__c": "Custom",
          "copado__Version__c": 1,
          "Id": "a0u3N000006l5iwQAA",
          "Name": "gdevops_commit"
        },
        {
          "attributes": {
            "type": "copado__JobTemplate__c",
            "url": "/services/data/v54.0/sobjects/copado__JobTemplate__c/a0u3N000006l5ixQAA"
          },
          "copado__ApiName__c": "gdevops_promote_1",
          "copado__Type__c": "Custom",
          "copado__Version__c": 1,
          "Id": "a0u3N000006l5ixQAA",
          "Name": "gdevops_promote"
        },
        {
          "attributes": {
            "type": "copado__JobTemplate__c",
            "url": "/services/data/v54.0/sobjects/copado__JobTemplate__c/a0u3N000006l5iyQAA"
          },
          "copado__ApiName__c": "gdevops_deploy_1",
          "copado__Type__c": "Custom",
          "copado__Version__c": 1,
          "Id": "a0u3N000006l5iyQAA",
          "Name": "gdevops_deploy"
        },
        {
          "attributes": {
            "type": "copado__JobTemplate__c",
            "url": "/services/data/v54.0/sobjects/copado__JobTemplate__c/a0u3N000006l5izQAA"
          },
          "copado__ApiName__c": "gdevops_rollback_1",
          "copado__Type__c": "Custom",
          "copado__Version__c": 1,
          "Id": "a0u3N000006l5izQAA",
          "Name": "gdevops_rollback"
        }
      ],
      "ObjectType": "copado__JobTemplate__c"
    },
    {
      "Records": [
        {
          "attributes": {
            "type": "copado__JobStep__c",
            "url": "/services/data/v54.0/sobjects/copado__JobStep__c/a0t3N000002AA02QAG"
          },
          "copado__ApiName__c": "gdevops_commit_gdevops_commit",
          "copado__ConfigJson__c": "{\"functionName\": \"gdevops_commit\", \"parameters\": [{\"name\": \"COPADO_DEVOPSTOOLS_URL\", \"value\": \"{Pipeline.Property.COPADO_DEVOPSTOOLS_URL}\"}, {\"name\": \"COPADO_DEVOPSTOOLS_VERSION\", \"value\": \"{Pipeline.Property.COPADO_DEVOPSTOOLS_VERSION}\"}, {\"name\": \"git_json\", \"value\": \"{$Context.Repository.Credential}\"}, {\"name\": \"git_email\", \"value\": \"{$User.Email}\"}, {\"name\": \"git_name\", \"value\": \"{$User.Name}\"}, {\"name\": \"git_depth\", \"value\": \"{$Pipeline.property.git_depth}\"}, {\"name\": \"file_changes_id\", \"value\": \"{$Context.JobExecution__r.DataJson.fileWithSelectedChanges}\"}, {\"name\": \"feature_branch\", \"value\": \"{$Context.JobExecution__r.DataJson.featureBranchName}\"}, {\"name\": \"recreate_if_exists\", \"value\": \"{$Context.JobExecution__r.DataJson.recreateFeatureBranch}\"}, {\"name\": \"commit_message\", \"value\": \"{$Context.JobExecution__r.DataJson.message}\"}, {\"name\": \"base_branch\", \"value\": \"{$Context.JobExecution__r.DataJson.baseBranch}\"}, {\"name\": \"replacement_rules\", \"value\": \"{$Pipeline.property.replacement_rules}\"}, {\"name\": \"environment_variables\", \"value\": \"{$Source.apex.EnvironmentVariables}\"}]}",
          "copado__CustomType__c": "Function",
          "copado__JobTemplate__c": "a0u3N000006l5iwQAA",
          "copado__Order__c": 0,
          "copado__Type__c": "Function",
          "Id": "a0t3N000002AA02QAG",
          "Name": "gdevops_commit"
        },
        {
          "attributes": {
            "type": "copado__JobStep__c",
            "url": "/services/data/v54.0/sobjects/copado__JobStep__c/a0t3N000002AA03QAG"
          },
          "copado__ApiName__c": "gdevops_promote_gdevops_promote",
          "copado__ConfigJson__c": "{\"functionName\": \"gdevops_promote\", \"parameters\": [{\"name\": \"COPADO_DEVOPSTOOLS_URL\", \"value\": \"{Pipeline.Property.COPADO_DEVOPSTOOLS_URL}\"}, {\"name\": \"COPADO_DEVOPSTOOLS_VERSION\", \"value\": \"{Pipeline.Property.COPADO_DEVOPSTOOLS_VERSION}\"}, {\"name\": \"git_json\", \"value\": \"{$Context.Repository.Credential}\"}, {\"name\": \"git_email\", \"value\": \"{$User.Email}\"}, {\"name\": \"git_name\", \"value\": \"{$User.Name}\"}, {\"name\": \"git_depth\", \"value\": \"{$Pipeline.property.git_depth}\"}, {\"name\": \"file_changes_id\", \"value\": \"{$Context.JobExecution__r.DataJson.fileWithSelectedChanges}\"}, {\"name\": \"promotion_branch\", \"value\": \"{$Context.JobExecution__r.DataJson.promotionBranchName}\"}, {\"name\": \"target_branch\", \"value\": \"{$Context.JobExecution__r.DataJson.destinationBranchName}\"}, {\"name\": \"user_stories\", \"value\": \"{$Context.JobExecution__r.DataJson.userStoryBranches}\"}, {\"name\": \"promotion_id\", \"value\": \"{$Job.ExecutionParent.Id}\"}, {\"name\": \"repository_id\", \"value\": \"{$Pipeline.Git_Repository__r.Id}\"}, {\"name\": \"release_version\", \"value\": \"{$Context.JobExecution__r.Promotion__r.Release__r.Version__c}\"}, {\"name\": \"exclude_autoresolve\", \"value\": \"{$Pipeline.property.exclude_autoresolve}\"}, {\"name\": \"conflict_resolution_attachments\", \"value\": \"{$Context.apex.GetConflictResolutionAttachments}\"}, {\"name\": \"smart_conflict_resolution_enabled\", \"value\": \"{$Pipeline.property.smart_conflict_resolution_enabled}\"}]}",
          "copado__CustomType__c": "Function",
          "copado__JobTemplate__c": "a0u3N000006l5ixQAA",
          "copado__Order__c": 0,
          "copado__Type__c": "Function",
          "Id": "a0t3N000002AA03QAG",
          "Name": "gdevops_promote"
        },
        {
          "attributes": {
            "type": "copado__JobStep__c",
            "url": "/services/data/v54.0/sobjects/copado__JobStep__c/a0t3N000002AA04QAG"
          },
          "copado__ApiName__c": "gdevops_deploy_gdevops_deploy",
          "copado__ConfigJson__c": "{\"functionName\": \"gdevops_deploy\", \"parameters\": [{\"name\": \"COPADO_DEVOPSTOOLS_URL\", \"value\": \"{Pipeline.Property.COPADO_DEVOPSTOOLS_URL}\"}, {\"name\": \"COPADO_DEVOPSTOOLS_VERSION\", \"value\": \"{Pipeline.Property.COPADO_DEVOPSTOOLS_VERSION}\"}, {\"name\": \"git_json\", \"value\": \"{$Context.Repository.Credential}\"}, {\"name\": \"git_email\", \"value\": \"{$User.Email}\"}, {\"name\": \"git_name\", \"value\": \"{$User.Name}\"}, {\"name\": \"git_depth\", \"value\": \"{$Pipeline.property.git_depth}\"}, {\"name\": \"file_changes_id\", \"value\": \"{$Context.JobExecution__r.DataJson.fileWithSelectedChanges}\"}, {\"name\": \"promotion_branch\", \"value\": \"{$Context.JobExecution__r.DataJson.promotionBranchName}\"}, {\"name\": \"target_branch\", \"value\": \"{$Context.JobExecution__r.DataJson.destinationBranchName}\"}, {\"name\": \"replacement_rules\", \"value\": \"{$Pipeline.property.replacement_rules}\"}, {\"name\": \"environment_variables\", \"value\": \"{$Destination.apex.EnvironmentVariables}\"}, {\"name\": \"release_version\", \"value\": \"{$Context.JobExecution__r.Promotion__r.Release__r.Version__c}\"}, {\"name\": \"deploy_id\", \"value\": \"{$Job.ExecutionParent.Id}\"}, {\"name\": \"dry_run\", \"value\": \"{$Context.JobExecution__r.DataJson.deploymentDryRun}\"}, {\"name\": \"builder_config\", \"value\": \"{$Destination.property.builder_config}\"}, {\"name\": \"rollback_enabled\", \"value\": \"true\"}]}",
          "copado__CustomType__c": "Function",
          "copado__JobTemplate__c": "a0u3N000006l5iyQAA",
          "copado__Order__c": 0,
          "copado__Type__c": "Function",
          "Id": "a0t3N000002AA04QAG",
          "Name": "gdevops_deploy"
        },
        {
          "attributes": {
            "type": "copado__JobStep__c",
            "url": "/services/data/v54.0/sobjects/copado__JobStep__c/a0t3N000002AA05QAG"
          },
          "copado__ApiName__c": "gdevops_rollback_gdevops_rollback",
          "copado__ConfigJson__c": "{\"functionName\": \"gdevops_rollback\", \"parameters\": [{\"name\": \"COPADO_DEVOPSTOOLS_URL\", \"value\": \"{Pipeline.Property.COPADO_DEVOPSTOOLS_URL}\"}, {\"name\": \"COPADO_DEVOPSTOOLS_VERSION\", \"value\": \"{Pipeline.Property.COPADO_DEVOPSTOOLS_VERSION}\"}, {\"name\": \"git_json\", \"value\": \"{$Context.Repository.Credential}\"}, {\"name\": \"git_email\", \"value\": \"{$User.Email}\"}, {\"name\": \"git_name\", \"value\": \"{$User.Name}\"}, {\"name\": \"git_depth\", \"value\": \"{$Pipeline.property.git_depth}\"}, {\"name\": \"file_changes_id\", \"value\": \"{$Context.JobExecution__r.DataJson.fileWithSelectedChanges}\"}, {\"name\": \"backup_branch\", \"value\": \"...\"}, {\"name\": \"feature_branch\", \"value\": \"...\"}]}",
          "copado__CustomType__c": "Function",
          "copado__JobTemplate__c": "a0u3N000006l5izQAA",
          "copado__Order__c": 0,
          "copado__Type__c": "Function",
          "Id": "a0t3N000002AA05QAG",
          "Name": "gdevops_rollback"
        }
      ],
      "ObjectType": "copado__JobStep__c"
    }
  ],
  "blobsByUID": {}
}