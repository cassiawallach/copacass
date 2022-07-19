/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class PolicyActionContext {
    global Map<String,Object> actionParameters {
        get;
        set;
    }
    global List<DecsOnD.PolicyActionRecord> actionRecords {
        get;
        set;
    }
    global List<SObject> detailObjects {
        get;
    }
    global SObject mainObject {
        get;
    }
    global SObject mainRecord {
        get;
    }
    global DecsOnD__Policy__c policy {
        get;
    }
    global DecsOnD.PolicyInvocationContext policyContext {
        get;
    }
    global DecsOnD.DecisionResponse response {
        get;
        set;
    }
    global PolicyActionContext() {

    }
    global PolicyActionContext(DecsOnD.PolicyInvocationContext policyContext) {

    }
    global PolicyActionContext(DecsOnD.PolicyInvocationContext policyContext, SObject mainRecord) {

    }
    global PolicyActionContext(DecsOnD.PolicyInvocationContext policyContext, SObject mainObject, List<SObject> detailObjects) {

    }
    global PolicyActionContext(DecsOnD.PolicyInvocationContext policyContext, SObject mainObject, Map<String,List<SObject>> detailObjects) {

    }
    global PolicyActionContext(DecsOnD.PolicyInvocationContext policyContext, SObject mainRecord, Map<String,Set<SObject>> detailRecords) {

    }
    global PolicyActionContext(DecsOnD.PolicyInvocationContext policyContext, SObject mainObject, Map<String,List<SObject>> detailObjects, Map<String,Object> parameters) {

    }
    global PolicyActionContext(DecsOnD.PolicyInvocationContext policyContext, SObject mainObject, List<SObject> detailObjects, Map<String,Object> parameters, DecsOnD.DecisionResponse response) {

    }
    global virtual Boolean areDetailRecordsLoaded() {
        return null;
    }
    global virtual SObject checkMainRecord() {
        return null;
    }
    global virtual DecsOnD__Policy__c checkPolicy() {
        return null;
    }
    @Deprecated
    global Schema.SObjectType getDetailObjectType() {
        return null;
    }
    @Deprecated
    global String getDetailObjectTypeName() {
        return null;
    }
    global virtual Map<String,Set<SObject>> getDetailRecordsMap(String relKey) {
        return null;
    }
    global virtual Set<SObject> getDetailRecords(String relKey) {
        return null;
    }
    @Deprecated
    global String getDetailRelationName() {
        return null;
    }
    @Deprecated
    global Schema.SObjectType getMainObjectType() {
        return null;
    }
    @Deprecated
    global String getMainObjectTypeName() {
        return null;
    }
    global virtual String getMainRecordParamName() {
        return null;
    }
    global virtual Schema.SObjectType getMainRecordType() {
        return null;
    }
    global virtual String getMainRecordTypeName() {
        return null;
    }
    global String getPolicyName() {
        return null;
    }
    global virtual Boolean isLookupRelation(String relKey) {
        return null;
    }
    global virtual void setDetailRecords(String parentKey, String relationName, Set<SObject> detailRecords) {

    }
    global virtual void setInputParameter(String paramName, Object paramVal) {

    }
    global virtual void updateInputParameter(String paramName, Object paramVal) {

    }
}
