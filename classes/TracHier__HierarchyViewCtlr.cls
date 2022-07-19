/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class HierarchyViewCtlr {
    @RemoteAction
    global static TracHier.HierarchyViewCtlr.Response getChildData(String objectType, Map<String,String> rowIdToAccIdMap) {
        return null;
    }
    @RemoteAction
    global static Map<String,List<Map<String,Object>>> getChildHierarchyData(String objectType, Map<String,String> rowIdToAccIdMap) {
        return null;
    }
    @AuraEnabled
    global static TracHier.HierarchyViewCtlr.Response getChildPageLWC(String objectType, Map<String,String> rowIdToAccIdMap, Integer pageSize, String lastChildId) {
        return null;
    }
    @RemoteAction
    global static TracHier.HierarchyViewCtlr.Response getChildPage(String objectType, Map<String,String> rowIdToAccIdMap, Integer pageSize, String lastChildId) {
        return null;
    }
    @AuraEnabled
    global static TracHier.HierarchyData getDefaultHierarchyRecords(Id recordId, Integer pageSize, String startFromId) {
        return null;
    }
    @RemoteAction
    global static TracHier.HierarchyData getDefaultHierarchyRecordsVF(Id recordId, Integer pageSize, String startFromId) {
        return null;
    }
    @RemoteAction
    global static Boolean getDisablePerUserFields() {
        return null;
    }
    @AuraEnabled
    global static Map<String,String> getHierarchyConfiguration(Id recordId) {
        return null;
    }
    @RemoteAction
    global static TracHier.HierarchyData getHierarchyData(Id recordId) {
        return null;
    }
    @RemoteAction
    global static TracHier.HierarchyData getHierarchyRecords(Id recordId, Integer pageSize, String startFromId) {
        return null;
    }
    @AuraEnabled
    global static TracHier.HierarchyData getHierarchyRecordsLWC(Id recordId, Integer pageSize, String startFromId) {
        return null;
    }
    @RemoteAction
    global static void saveInteraction(String interactionDataJSON) {

    }
    @RemoteAction
    global static List<TracHier.HierarchyViewCtlr.GenericResult> saveObjectWithResult(String oName, String jsonList) {
        return null;
    }
    @RemoteAction
    global static TracHier__Hierarchy_Settings__c setDefaultHierarchy(String hierarchyName) {
        return null;
    }
    @RemoteAction
    global static void updateFullscreenWhitespaceOpensCount() {

    }
    @AuraEnabled
    global static void updateFullscreenWhitespaceOpensCountLWC() {

    }
global class GenericMetricResult {
}
global class GenericResult {
}
global class Response {
    global Response() {

    }
}
}
