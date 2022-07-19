/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class ApplyPolicyControllerBase {
    global List<DecsOnD.PolicyActionRecord> actions {
        get;
    }
    global String application {
        get;
    }
    @Deprecated
    global static String AUDIT_URL_PARAMNAME;
    global static String AUTO_MODE;
    global Boolean autoMode {
        get;
    }
    global Boolean changesMade {
        get;
    }
    @Deprecated
    global static String DETAIL_RELATION_URL_PARAMNAME;
    global List<String> detailRecordFieldNames {
        get;
    }
    global List<SObject> detailRecords {
        get;
    }
    global Map<String,List<SObject>> detailRecordsMap {
        get;
    }
    global String detailRelationName {
        get;
    }
    @Deprecated
    global static String FIELDS_URL_PARAMNAME;
    global DecsOnD.PolicyInvocationContext invocationContext {
        get;
    }
    global static String LOG_EXECUTION_URL_PARAMNAME;
    global static String MODE_URL_PARAMNAME;
    global List<String> modifiedFieldNames {
        get;
    }
    global List<SObject> originalDetailRecords {
        get;
    }
    global Map<String,List<SObject>> originalDetailRecordsMap {
        get;
    }
    global SObject originalRecord {
        get;
    }
    global DecsOnD__Policy__c policy {
        get;
    }
    global static String POLICY_URL_PARAMNAME;
    global Boolean policyAppliedSuccessfully {
        get;
        set;
    }
    global String policyName {
        get;
        set;
    }
    global static String RECORD_ID_URL_PARAMNAME;
    global Map<String,String> recordFieldLabels {
        get;
    }
    global List<String> recordFieldNames {
        get;
    }
    global String recordName {
        get;
    }
    global String recordType {
        get;
    }
    global DecsOnD.DecisionResponse response {
        get;
    }
    global static String REVIEW_MODE;
    global Boolean reviewMode {
        get;
    }
    global virtual System.PageReference acceptChanges() {
        return null;
    }
    global virtual System.PageReference applyPolicy() {
        return null;
    }
    global virtual void applyPolicyActions() {

    }
    global virtual System.PageReference cancelChanges() {
        return null;
    }
    global virtual void completeSetup() {

    }
    @Deprecated
    global virtual DecsOnD.PolicyActionContext createActionContext(DecsOnD.PolicyInvocationContext policyContext, SObject mainRecord, Map<String,List<SObject>> detailRecordsMap) {
        return null;
    }
    @Deprecated
    global virtual DecsOnD.PolicyActionContext createActionContext(DecsOnD.PolicyInvocationContext policyContext, SObject mainRecord, Map<String,Set<SObject>> detailRecordsMap) {
        return null;
    }
    global virtual DecsOnD.ApplyPolicyHelper createHelper(DecsOnD.PolicyActionContext context) {
        return null;
    }
    @Deprecated
    global virtual List<SObject> getDetailRecords(String relName) {
        return null;
    }
    global virtual SObject getMainRecord() {
        return null;
    }
    global virtual System.PageReference handleError(DecsOnD.PolicyActionContext context) {
        return null;
    }
    @Deprecated
    global virtual void loadDetailRecords() {

    }
    @Deprecated
    global virtual Map<String,Set<SObject>> loadDetailRecords(DecsOnD.PolicyInvocationContext invocationContext, SObject mainRecord) {
        return null;
    }
    global virtual void loadMainRecord() {

    }
    global virtual System.PageReference prepareUserReview() {
        return null;
    }
}
