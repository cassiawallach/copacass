/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class ApplyPolicyHelper {
    global DecsOnD.PolicyActionContext actionContext {
        get;
    }
    global static DecsOnD.PolicyActionBatch currentBatch {
        get;
    }
    global static DecsOnD.ApplyPolicyHelper.Factory factory {
        get;
        set;
    }
    global DecsOnD.PolicyInvocationContext invocationContext {
        get;
    }
    global ApplyPolicyHelper() {

    }
    global ApplyPolicyHelper(DecsOnD.PolicyActionContext actionContext) {

    }
    global virtual List<String> applyActions(List<DecsOnD.PolicyActionRecord> actions) {
        return null;
    }
    global virtual List<String> applyActions(List<DecsOnD.PolicyActionRecord> actions, Boolean restoreDBStateOnFail) {
        return null;
    }
    global static void applyBatchActions(List<DecsOnD.ApplyPolicyHelper> selectedHelpers, Boolean createExecutionRecord) {

    }
    @Deprecated
    global static void applyBatchActions(Map<Id,List<DecsOnD.PolicyActionRecord>> actionsMap, Boolean createExecutionRecord) {

    }
    global static List<DecsOnD.ApplyPolicyHelper> applyPolicyBatch(DecsOnD.PolicyInvocationContext invocationContext, List<SObject> parentRecs) {
        return null;
    }
    global static List<DecsOnD.ApplyPolicyHelper> applyPolicyBatch(DecsOnD.PolicyInvocationContext invocationContext, List<SObject> parentRecs, Boolean applyActions) {
        return null;
    }
    global static List<DecsOnD.ApplyPolicyHelper> applyPolicyBatch(DecsOnD.PolicyInvocationContext invocationContext, Set<Id> parentObjIds) {
        return null;
    }
    global static List<DecsOnD.ApplyPolicyHelper> applyPolicyBatch(List<DecsOnD.ApplyPolicyHelper> helpers, String requestMode, Boolean skipCreationOfAuditLog, Boolean applyActions) {
        return null;
    }
    global virtual List<DecsOnD.PolicyActionRecord> applyPolicy() {
        return null;
    }
    global virtual List<DecsOnD.PolicyActionRecord> applyPolicy(Boolean applyActions) {
        return null;
    }
    global static List<DecsOnD.PolicyActionRecord> createBatchExecutionRecords(List<DecsOnD.ApplyPolicyHelper> selectedHelpers) {
        return null;
    }
    global static List<DecsOnD.ApplyPolicyHelper> createBatchHelpers(DecsOnD.PolicyInvocationContext invocationContext, List<SObject> parentRecs, Boolean loadDetailRecords) {
        return null;
    }
    global static List<DecsOnD.ApplyPolicyHelper> createBatchHelpers(DecsOnD.PolicyInvocationContext invocationContext, List<SObject> parentRecs, Map<Id,Map<String,Set<SObject>>> detailObjectsMap) {
        return null;
    }
    global static List<DecsOnD.ApplyPolicyHelper> createBatchHelpers(DecsOnD.PolicyInvocationContext invocationContext, List<SObject> parentRecs, Map<Schema.SObjectType,Set<SObject>> detailObjectsMap) {
        return null;
    }
    @Deprecated
    global virtual DecsOnD.PolicyActionRecord createExecutionRecord() {
        return null;
    }
    global virtual DecsOnD.PolicyActionRecord createExecutionRecord(DecsOnD.DecisionResponse response, List<DecsOnD.PolicyActionRecord> actionRecs) {
        return null;
    }
    global static DecsOnD.ApplyPolicyHelper createHelper(DecsOnD.PolicyActionContext ctxt, Boolean loadDetailRelations) {
        return null;
    }
    global static DecsOnD.ApplyPolicyHelper createHelper(DecsOnD.PolicyInvocationContext invocationContext, Id mainRecordID) {
        return null;
    }
    global static DecsOnD.ApplyPolicyHelper createHelper(DecsOnD.PolicyInvocationContext invocationContext, SObject mainRecord) {
        return null;
    }
    @Deprecated
    global static List<DecsOnD.PolicyActionContext> executeBatchDecisionRequest(DecsOnD.PolicyInvocationContext invocationContext, DecsOnD.RESTDecisionService svc, List<SObject> parentObjs, Map<Id,List<SObject>> detailObjectsMap) {
        return null;
    }
    @Deprecated
    global static List<DecsOnD.PolicyActionContext> executeBatchDecisionRequest(DecsOnD.PolicyInvocationContext invocationContext, DecsOnD.RESTDecisionService svc, List<SObject> parentObjs, Map<Id,Map<String,List<SObject>>> detailObjectsMapWithList) {
        return null;
    }
    @Deprecated
    global static Map<Id,List<DecsOnD.PolicyActionRecord>> executeBatchRequest(DecsOnD.PolicyInvocationContext invocationContext, DecsOnD.RESTDecisionService svc, List<SObject> parentObjs, Map<Id,List<SObject>> detailObjectsMap) {
        return null;
    }
    global virtual DecsOnD.DecisionResponse executeDecisionRequest(DecsOnD.DecisionRequest request) {
        return null;
    }
    @Deprecated
    global virtual void executeDecisionRequest() {

    }
    @Deprecated
    global virtual List<DecsOnD.PolicyActionRecord> executeSingleRequest() {
        return null;
    }
    global virtual List<DecsOnD.PolicyActionRecord> getActionRecords() {
        return null;
    }
    global virtual SObject getMainRecord() {
        return null;
    }
    global virtual Id getMainRecordID() {
        return null;
    }
    global virtual DecsOnD.DecisionResponse getResponse() {
        return null;
    }
    global static void initialize() {

    }
    global static Map<Id,Map<String,Set<SObject>>> loadDetailRecordsBatch(DecsOnD.PolicyInvocationContext policyContext, List<SObject> parentRecords) {
        return null;
    }
    global static Map<Id,Map<String,Set<SObject>>> loadDetailRecordsBatch(List<DecsOnD.ApplyPolicyHelper> helpers) {
        return null;
    }
    global virtual Map<Id,Map<String,Set<SObject>>> loadDetailRecords(List<SObject> parentRecs) {
        return null;
    }
    global virtual Map<String,Set<SObject>> loadDetailRecords() {
        return null;
    }
    global virtual List<DecsOnD.PolicyActionRecord> prepareActions(DecsOnD.DecisionResponse resp) {
        return null;
    }
    global virtual DecsOnD.DecisionRequest prepareDecisionRequest() {
        return null;
    }
    @Deprecated
    global List<DecsOnD.PolicyActionRecord> processResponse(DecsOnD.DecisionResponse resp) {
        return null;
    }
    global virtual void setContext(DecsOnD.PolicyActionContext ctxt) {

    }
    global virtual void setDetailRecords(Map<String,Set<SObject>> detailRecs) {

    }
global virtual class Factory {
    global Factory() {

    }
    global virtual DecsOnD.ApplyPolicyHelper createHelper(DecsOnD.PolicyActionContext ctxt) {
        return null;
    }
}
}
