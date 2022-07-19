/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class TriggerExecutionHandler {
    global Integer batchSize;
    global static String defaultCreateExecutionRecords;
    global static String defaultEmailUserOnCompletion;
    global static Boolean emailSupportOnFailure;
    global String operation {
        get;
    }
    global Map<Id,SObject> scope {
        get;
    }
    global Schema.SObjectType scopeObjectType {
        get;
    }
    global Map<Id,SObject> scopeOld {
        get;
    }
    global Integer scopeSize {
        get;
        set;
    }
    global String triggerEvent {
        get;
    }
    global TriggerExecutionHandler() {

    }
    global static Boolean areTriggersActivated(Schema.SObjectType sType) {
        return null;
    }
    @Deprecated
    global static Boolean areTriggersDeactivated(Schema.SObjectType sType) {
        return null;
    }
    global static void clearTriggerTestSettings() {

    }
    global virtual void executeAll() {

    }
    global static Map<String,String> executePolicies() {
        return null;
    }
    global static Map<String,String> executePolicies(Integer batchSize) {
        return null;
    }
    global static Map<String,String> executePolicies(List<DecsOnD.PolicyInvocationContext> invocationContexts, Integer batchSize) {
        return null;
    }
    global static Map<String,String> executePolicySObjectDelete(Map<Id,SObject> scope) {
        return null;
    }
    global static Map<String,String> executePolicySObjectDelete(Map<Id,SObject> scope, String triggerName) {
        return null;
    }
    @Deprecated
    global static Map<String,String> executePolicySObjectInsert(List<SObject> scope) {
        return null;
    }
    global static Map<String,String> executePolicySObjectInsert(Map<Id,SObject> scope) {
        return null;
    }
    global static Map<String,String> executePolicySObjectInsert(Map<Id,SObject> scope, String triggerName) {
        return null;
    }
    global static Map<String,String> executePolicySObjectUndelete(Map<Id,SObject> scope) {
        return null;
    }
    global static Map<String,String> executePolicySObjectUndelete(Map<Id,SObject> scope, String triggerName) {
        return null;
    }
    @Deprecated
    global static Map<String,String> executePolicySObjectUpdate(List<SObject> scope) {
        return null;
    }
    global static Map<String,String> executePolicySObjectUpdate(Map<Id,SObject> scopeNew, Map<Id,SObject> scopeOld) {
        return null;
    }
    global static Map<String,String> executePolicySObjectUpdate(Map<Id,SObject> scopeNew, Map<Id,SObject> scopeOld, String triggerName) {
        return null;
    }
    global virtual void execute(List<DecsOnD.PolicyInvocationContext> policiesToExecute) {

    }
    global static String getFullTriggerEvent() {
        return null;
    }
    global virtual Set<Id> getMainRecordIdsForPolicy(DecsOnD.PolicyInvocationContext ctxt) {
        return null;
    }
    global static String getTriggerEvent() {
        return null;
    }
    global static Map<Id,SObject> getTriggerNewMap() {
        return null;
    }
    global static List<SObject> getTriggerNew() {
        return null;
    }
    global virtual String getTriggerNotOKReason() {
        return null;
    }
    global static String getTriggerNotOKReason(Schema.SObjectType sType) {
        return null;
    }
    global static Schema.SObjectType getTriggerObjectType() {
        return null;
    }
    global static Map<Id,SObject> getTriggerOldMap() {
        return null;
    }
    global static List<SObject> getTriggerOld() {
        return null;
    }
    global static void handleTriggerException(String triggerName, Exception e) {

    }
    global virtual void initialize(Map<Id,SObject> scope, String operation, Map<Id,SObject> scopeOld, String triggerName) {

    }
    global static Boolean isInAfterTrigger() {
        return null;
    }
    global static Boolean isInBeforeTrigger() {
        return null;
    }
    global static Boolean isInDeleteTrigger() {
        return null;
    }
    global static Boolean isInInsertTrigger() {
        return null;
    }
    global static Boolean isInUndeleteTrigger() {
        return null;
    }
    global static Boolean isInUpdateTrigger() {
        return null;
    }
    global virtual Boolean isOkToRunTrigger() {
        return null;
    }
    global static Boolean isOkToRunTrigger(Schema.SObjectType sType) {
        return null;
    }
    global static Boolean isTriggerExecuting() {
        return null;
    }
    global static void logTriggerErrors(String triggerName, Map<String,String> errors) {

    }
    global static void logTriggerResults(String triggerName, String msg) {

    }
    global virtual List<DecsOnD__Policy__c> selectPoliciesToExecute() {
        return null;
    }
    global static void setDefaultScopeFilter(Schema.SObjectType objType, DecsOnD.IScopeFilter filter) {

    }
    global static void setDefaultScopeFilter(DecsOnD__Policy__c policy, DecsOnD.IScopeFilter filter) {

    }
    global void setError(String policyName, String message) {

    }
    global static void setTestTriggerData(Map<Id,SObject> newMap, Map<Id,SObject> oldMap) {

    }
}
