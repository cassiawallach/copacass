/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class PolicyContentViewerController {
    global PolicyContentViewerController() {

    }
    @Deprecated
    @RemoteAction
    global static Map<String,Object> acquireLock(DecsOnD__Policy__c policy, Boolean updateDB) {
        return null;
    }
    webService static String changeLookupFieldValue(String objLookupName, String objLookupField, String originalValue) {
        return null;
    }
    @Deprecated
    @RemoteAction
    global static Map<String,String> getAllTableContents(String policyId, DecsOnD.VersionDescriptor version) {
        return null;
    }
    @Deprecated
    @RemoteAction
    global static Map<String,List<DecsOnD.DecisionTableConfig.SectionConfig>> getAvailableColumns(DecsOnD.DecisionPointConfig dpConfig, Map<String,DecsOnD.DecisionTableConfig> tableConfigurations, Boolean generatePicklistValues) {
        return null;
    }
    @Deprecated
    @RemoteAction
    global static List<DecsOnD.DecisionTableConfig.PicklistValue> getPicklistValues(String tableName, DecsOnD.DecisionTableConfig.ColumnConfig column) {
        return null;
    }
    webService static List<String> loadLookupValues(String objName, String valueFieldName, String labelFieldName, List<String> recordNames) {
        return null;
    }
    @Deprecated
    @RemoteAction
    global static void releaseLock(String policyID) {

    }
    webService static String updateColumnConfig(String jsonPolicyBaseInfo, String tableName, String jsonEditedDtConfig, String jsonVersionDescriptor, String isSaveToServer) {
        return null;
    }
    webService static String updateColumnWidths(String policyId, String tableName, String jsonEditedNonStructuralValues, String userId) {
        return null;
    }
    @Deprecated
    @RemoteAction
    global static String updateMultipleTableConfigurations(String policyId, Map<String,DecsOnD.DecisionTableConfig> mapEditedTableConfigs, Map<String,Map<String,String>> mapEditedNonStructuralValues, DecsOnD.VersionDescriptor version, Boolean isSaveToServer) {
        return null;
    }
    @Deprecated
    @RemoteAction
    global static String updateTableConfiguration(String policyId, String tableName, DecsOnD.DecisionTableConfig editedDtConfig, DecsOnD.VersionDescriptor version, Map<String,String> editedNonStructuralValues, Boolean isSaveToServer) {
        return null;
    }
    @Deprecated
    @RemoteAction
    global static List<Map<String,String>> validateAndCompleteLookupValues(String objName, String valueFieldName, String labelFieldName, String qualifier, List<String> namesValuesOrLabels) {
        return null;
    }
    webService static List<String> validateAndCompleteLookups(String objName, String valueFieldName, String labelFieldName, String qualifier, List<String> namesValuesOrLabels) {
        return null;
    }
    webService static String validateLookupField(String objName, String fieldName, String lookupValues) {
        return null;
    }
    webService static List<String> validateLookups(String objName, String fieldName, String qualifier, List<String> values) {
        return null;
    }
}
