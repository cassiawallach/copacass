/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class TestUtils {
    global TestUtils() {

    }
    global static List<GroupMember> addGroupMembers(Group theGroup, List<Group> groups, Boolean insertIntoDB) {
        return null;
    }
    global static List<GroupMember> addGroupMembers(Group theGroup, List<User> users, Boolean insertIntoDB) {
        return null;
    }
    global static DecsOnD.PolicyActionRecord applyAction(String actionName, DecsOnD.PolicyInvocationContext ctxt, Map<String,Object> params, Boolean expectFailure) {
        return null;
    }
    global static DecsOnD.PolicyActionRecord applyAction(String actionName, DecsOnD.PolicyInvocationContext ctxt, SObject mainRec, Map<String,Object> params, Boolean expectFailure) {
        return null;
    }
    global static void clearResults() {

    }
    global static void clearTriggerTestSettings() {

    }
    global static Account createTestAccount(User owner, Boolean insertIntoDB) {
        return null;
    }
    global static List<Account> createTestAccounts(Integer numAccts, User owner, Boolean insertIntoDB) {
        return null;
    }
    global static DecsOnD.PolicyActionRecord createTestActionRecord(DecsOnD.PolicyActionContext actionContext, String actionName, Map<String,Object> parameters) {
        return null;
    }
    global static DecsOnD.PolicyActionRecord createTestActionRecord(DecsOnD.PolicyActionContext actionContext, String actionName, Map<String,Object> parameters, DecsOnD.PolicyActionBatch batch) {
        return null;
    }
    global static DecsOnD.PolicyActionRecord createTestActionRecord(DecsOnD.PolicyInvocationContext context, SObject mainRec, String actionName, Map<String,Object> parameters) {
        return null;
    }
    global static DecsOnD.PolicyActionRecord createTestActionRecord(DecsOnD.PolicyInvocationContext context, SObject mainRec, String actionName, Map<String,Object> parameters, DecsOnD.PolicyActionBatch batch) {
        return null;
    }
    global static List<SObject> createTestActivities(Schema.SObjectType activityType, List<SObject> whos, SObject what, Boolean insertIntoDB) {
        return null;
    }
    global static List<SObject> createTestActivities(Schema.SObjectType activityType, SObject who, List<SObject> whats, Boolean insertIntoDB) {
        return null;
    }
    global static List<SObject> createTestActivities(Schema.SObjectType activityType, SObject who, SObject what, Integer numActivities, Boolean insertIntoDB) {
        return null;
    }
    global static Contact createTestContact(Account owner, Boolean insertIntoDB) {
        return null;
    }
    global static List<Contact> createTestContacts(Integer numContacts, Account owner, Boolean insertIntoDB) {
        return null;
    }
    global static Lead createTestLead(Boolean insertIntoDB) {
        return null;
    }
    global static Lead createTestLead(SObject owner, Boolean insertIntoDB) {
        return null;
    }
    global static List<Lead> createTestLeads(Integer numLeads, Boolean insertIntoDB) {
        return null;
    }
    global static List<Lead> createTestLeads(Integer numLeads, SObject owner, Boolean insertIntoDB) {
        return null;
    }
    global static List<Opportunity> createTestOpportunities(Integer numOppts, Account acct, Boolean insertIntoDB) {
        return null;
    }
    global static Opportunity createTestOpportunity(Account acct, Boolean insertIntoDB) {
        return null;
    }
    global static DecsOnD__Policy__c createTestPolicy(String objectType, Boolean insertIntoDB) {
        return null;
    }
    global static DecsOnD__Policy__c createTestPolicy(String objectType, String name, Boolean insertIntoDB) {
        return null;
    }
    global static DecsOnD__Policy__c createTestPolicy(String objectType, String name, DecsOnD.DecisionPointConfig dpConfig, Boolean insertIntoDB) {
        return null;
    }
    global static DecsOnD__Policy__c createTestPolicy(String objectType, String name, Boolean doRandomizeName, Boolean insertIntoDB) {
        return null;
    }
    global static DecsOnD__Policy__c createTestPolicy(String objectType, String name, DecsOnD.DecisionPointConfig dpConfig, Boolean doRandomizeName, Boolean insertIntoDB) {
        return null;
    }
    global static DecsOnD.PolicyInvocationContext createTestPolicyAndContext(String policyBaseName, DecsOnD.DecisionPointConfig dpConfig) {
        return null;
    }
    global static DecsOnD.PolicyInvocationContext createTestPolicyAndContext(String objectType, String policyBaseName) {
        return null;
    }
    global static Group createTestPublicGroup(String name, Boolean insertIntoDB) {
        return null;
    }
    global static Group createTestQueue(String name, String objType, Boolean insertIntoDB) {
        return null;
    }
    global static User createTestUser(Boolean adminProfile, Boolean insertIntoDB) {
        return null;
    }
    global static Boolean didBatchFail(String batchName) {
        return null;
    }
    @Deprecated
    global DecsOnD.DecisionPointConfig getMockDecisionPointConfig(Schema.SObjectType mainObjType) {
        return null;
    }
    global static DecsOnD.DecisionPointConfig getMockDecisionPointConfigSimple(Schema.SObjectType mainObjType) {
        return null;
    }
    @Deprecated
    global DecsOnD.DecisionTableConfig getMockDecisionTableConfig() {
        return null;
    }
    global static DecsOnD.DecisionTableConfig getMockDecisionTableConfig(String tableLabel) {
        return null;
    }
    global static Datetime getTestNow() {
        return null;
    }
    @Deprecated
    global static DecsOnD.PolicyInvocationContext getTestPolicyContext(String objectType, String policyName) {
        return null;
    }
    global static List<String> getTriggerEventSequence(String triggerName, Boolean success) {
        return null;
    }
    global static Boolean initializeTestSetup() {
        return null;
    }
    global static User insertAndReselect(User usr) {
        return null;
    }
    global static User insertAndReselect(User usr, Set<String> extraFieldNames) {
        return null;
    }
    global static void insertRecordsAllowingDupes(List<SObject> objs) {

    }
    global static Boolean isTriggerTestActive() {
        return null;
    }
    global static String randomizeName(String baseName) {
        return null;
    }
    global static void registerBatchResults(String batchName, Boolean success) {

    }
    global static void registerTriggerResult(String triggerName, String triggerEvent, Boolean success) {

    }
    global static Account reloadTestAccountByName(String name) {
        return null;
    }
    global static List<Account> reloadTestAccounts(List<Account> accts) {
        return null;
    }
    global static List<Contact> reloadTestContacts(List<Contact> ctcts) {
        return null;
    }
    global static List<Contact> reloadTestContacts(String firstNameBase) {
        return null;
    }
    global static List<Lead> reloadTestLeads(List<Lead> leads) {
        return null;
    }
    global static List<Lead> reloadTestLeads(String firstNameBase, String lastName) {
        return null;
    }
    global static List<Opportunity> reloadTestOpportunities(List<Opportunity> oppts) {
        return null;
    }
    global static void reset() {

    }
    global static void setDefaultBatchDecisionResponse(DecsOnD.DecisionResponse resp) {

    }
    global static System.HttpCalloutMock setMockJSONResponseForTest(String strBody, Integer statusCode) {
        return null;
    }
    global static void setMockResponseForTest(System.HttpCalloutMock mock) {

    }
    global static void setTestNow(Datetime dt) {

    }
    global static void setTestTriggerDataAfterInsert(Map<Id,SObject> recs) {

    }
    global static void setTestTriggerDataBeforeInsert(List<SObject> recs) {

    }
    global static void setTestTriggerDataDelete(Map<Id,SObject> recs, Boolean isBefore) {

    }
    global static void setTestTriggerDataUpdate(Map<Id,SObject> newMap, Map<Id,SObject> oldMap, Boolean isBefore) {

    }
    global static Group upsertAndReselect(Group grp, Set<String> extraFieldNames) {
        return null;
    }
    global static List<GroupMember> upsertAndReselect(List<GroupMember> groupMembers, Set<String> extraFieldNames) {
        return null;
    }
    global static Boolean wasBatchExecutedOK(String batchName) {
        return null;
    }
    global static Boolean wasTriggerEventRecorded(String triggerName, String triggerEvent, Boolean success) {
        return null;
    }
    global static Boolean wasTriggerFired(String triggerName) {
        return null;
    }
    global static Boolean wereTriggerFailuresRecorded() {
        return null;
    }
    global static Boolean wereTriggerFailuresRecorded(String triggerName) {
        return null;
    }
    global static Boolean wereTriggersFiredSuccessfully() {
        return null;
    }
    global static Boolean wereTriggersFiredSuccessfully(String triggerName) {
        return null;
    }
}
