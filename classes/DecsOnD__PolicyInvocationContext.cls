/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class PolicyInvocationContext {
    global String auditType {
        get;
    }
    global static String BATCH_APEX;
    global static String CREATE_RECORD_NO;
    global static String CREATE_RECORD_ONFAILURE;
    global static String CREATE_RECORD_YES;
    global String createExecutionRecord {
        get;
        set;
    }
    global static String CUSTOM_APEX;
    global static String CUSTOM_BUTTON;
    global List<String> detailObjectsFieldNames {
        get;
    }
    global Schema.SObjectType detailObjectsType {
        get;
    }
    global Schema.ChildRelationship detailRelation {
        get;
    }
    global static String EMAIL_USER_ALWAYS;
    global static String EMAIL_USER_NEVER;
    global static String EMAIL_USER_ONFAILURE;
    global String emailUserOnCompletion {
        get;
        set;
    }
    global static String FUTURE_APEX;
    global Boolean interactiveMode {
        get;
        set;
    }
    global String invocationType {
        get;
        set;
    }
    global List<String> mainObjectFieldNames {
        get;
    }
    global Schema.SObjectType mainObjectType {
        get;
    }
    global Set<String> mainRecordFieldNames {
        get;
    }
    global String mainRecordParamName {
        get;
    }
    global Schema.SObjectType mainRecordType {
        get;
    }
    global static String PERIODIC_APEX;
    global DecsOnD__Policy__c policy {
        get;
    }
    global static String PROCESS_BUILDER;
    @Deprecated
    global static String QUEUABLE_APEX;
    global static String QUEUEABLE_APEX;
    global Map<String,Map<Integer,String>> rowsLogLevel {
        get;
        set;
    }
    global static String SCHEDULED_APEX;
    global Map<String,String> tableLogLevels {
        get;
        set;
    }
    global static String TEST_CONSOLE;
    global Set<String> triggerEvents {
        get;
        set;
    }
    global static String TRIGGERS;
    global DecsOnD.VersionDescriptor version {
        get;
        set;
    }
    global static String WORKFLOW;
    global PolicyInvocationContext(DecsOnD.PolicyInvocationContext context) {

    }
    global PolicyInvocationContext(DecsOnD__Policy__c newPolicy) {

    }
    global PolicyInvocationContext(Schema.SObjectType mainRecordType, String policyName) {

    }
    global PolicyInvocationContext(String policyName, Schema.SObjectType mainObjectType) {

    }
    global void addTriggerEvent(String event) {

    }
    global List<String> convertParameterKeyToNameList(String key) {
        return null;
    }
    global Object getDefaultInputParameterValue(String paramName) {
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
    global Schema.ChildRelationship getDetailRelationByKey(String relationKey) {
        return null;
    }
    global List<String> getDetailRelationKeys() {
        return null;
    }
    global Set<String> getDetailRelationKeys(String parentKey) {
        return null;
    }
    global Set<String> getDetailRelationKeys(String parentKey, Boolean nextLevelOnly) {
        return null;
    }
    global String getDetailRelationLoadCondition(String relationKey) {
        return null;
    }
    @Deprecated
    global String getDetailRelationName() {
        return null;
    }
    global Set<String> getDetailRelationNames(List<String> ancestorNames) {
        return null;
    }
    global Set<String> getDetailRelationNames(String parentName) {
        return null;
    }
    global Schema.SObjectType getDetailRelationSourceType(String relationKey) {
        return null;
    }
    global Map<String,Schema.SObjectType> getInputParameters() {
        return null;
    }
    global Schema.SObjectField getLookupRelationFieldByKey(String relationKey) {
        return null;
    }
    @Deprecated
    global String getMainObjectTypeName() {
        return null;
    }
    global String getMainRecordTypeName() {
        return null;
    }
    global Set<String> getParameterFieldNames(String paramKey) {
        return null;
    }
    global String getParameterName(String relationKey) {
        return null;
    }
    global Schema.SObjectType getParameterObjectType(String paramKey) {
        return null;
    }
    global static String getParentKey(String relKey) {
        return null;
    }
    global String getPolicyFQN() {
        return null;
    }
    global String getPolicyName() {
        return null;
    }
    global Boolean hasDetailRelations() {
        return null;
    }
    global static Boolean isFirstLevelRelationKey(String key) {
        return null;
    }
    global Boolean isInputParameter(String key) {
        return null;
    }
    global static Boolean isInputParameterKey(String key) {
        return null;
    }
    global static String makeDetailRelationKey(String parentKey, String relationName) {
        return null;
    }
    global void setDefaultInputParameterValue(String paramName, Object value) {

    }
    @Deprecated
    global void setDetailRelation(String relationName, List<String> additionalFields) {

    }
    @Deprecated
    global void setMainObjectExtraFields(List<String> extraFields) {

    }
}
