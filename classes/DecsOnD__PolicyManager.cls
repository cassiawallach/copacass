/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class PolicyManager {
    global static String STATUS_ACTIVE;
    global static String STATUS_ARCHIVED;
    global static String STATUS_DRAFT;
    global static String STATUS_INVALID;
    global PolicyManager() {

    }
    @Deprecated
    global static Boolean acquireLock(DecsOnD__Policy__c policy, Boolean updateDB) {
        return null;
    }
    global static void activatePolicy(DecsOnD__Policy__c policy) {

    }
    global static void archivePolicy(DecsOnD__Policy__c policy) {

    }
    global static DecsOnD.DecisionPointDescriptor clonePolicy(DecsOnD__Policy__c policy, String newPolicyName, String description, String documentationURL, DecsOnD.VersionDescriptor versionInfo, Boolean preserveVersionHistory) {
        return null;
    }
    global static String computeBaseURL() {
        return null;
    }
    global static DecsOnD.DecisionPointDescriptor createNewPolicy(DecsOnD.DecisionPointDescriptor dpDesc, DecsOnD.DecisionPointConfig dpConfig, Map<String,DecsOnD.DecisionTableConfig> decisionTables, DecsOnD.VersionDescriptor versionInfo) {
        return null;
    }
    global static void deletePolicy(DecsOnD__Policy__c policy) {

    }
    global static DecsOnD__Policy__c findPolicy(String objectType, String policyName, Boolean isExceptionWhenNotFound) {
        return null;
    }
    global static Map<String,DecsOnD.DecisionTableConfig> getAllDecisionTableConfigs(DecsOnD__Policy__c policy, DecsOnD.VersionDescriptor version) {
        return null;
    }
    global static List<DecsOnD.DecisionPointDescriptor> getAvailableTemplates() {
        return null;
    }
    global static DecsOnD.DecisionPointConfig getDecisionPointConfig(DecsOnD__Policy__c policy, DecsOnD.VersionDescriptor version) {
        return null;
    }
    global static String getDecisionPointURL(DecsOnD.DecisionPointDescriptor dpDesc) {
        return null;
    }
    global static String getDecisionPointURL(DecsOnD__Policy__c policy) {
        return null;
    }
    global static String getDecisionPointURL(DecsOnD__Policy__c policy, DecsOnD.VersionDescriptor version) {
        return null;
    }
    global static DecsOnD.DecisionTableConfig getDecisionTableConfig(DecsOnD__Policy__c policy, String tableName, DecsOnD.VersionDescriptor version) {
        return null;
    }
    webService static String getImportAuthorizationToken(String dpFQN, Long timestamp) {
        return null;
    }
    global static List<DecsOnD.VersionDescriptor> getPolicyVersions(DecsOnD__Policy__c policy) {
        return null;
    }
    global static DecsOnD.DecisionPointDescriptor importPolicy(DecsOnD.DecisionPointDescriptor newDpDesc, DecsOnD.VersionDescriptor versionInfo, String sourcePolicyName, String sourceOrg, String authorizationToken, Long timestamp, Boolean preserveVersionHistory) {
        return null;
    }
    @Deprecated
    global static DecsOnD.DecisionPointDescriptor installTemplate(DecsOnD.DecisionPointDescriptor selTemplate) {
        return null;
    }
    global static DecsOnD.DecisionPointDescriptor installTemplate(DecsOnD.DecisionPointDescriptor selTemplate, String newPolicyName) {
        return null;
    }
    @Deprecated
    global static List<DecsOnD.DecisionPointDescriptor> installTemplates(List<DecsOnD.DecisionPointDescriptor> selTemplates) {
        return null;
    }
    @Deprecated
    global static Boolean isLockExpired(DecsOnD__Policy__c dbPolicy) {
        return null;
    }
    @Deprecated
    global static Boolean isLockedByCurrentUser(DecsOnD__Policy__c dbPolicy) {
        return null;
    }
    @Deprecated
    global static Boolean isLockedByOther(DecsOnD__Policy__c dbPolicy) {
        return null;
    }
    @Deprecated
    global static void refreshAllPolicies() {

    }
    @Deprecated
    global static void releaseLock(String policyID) {

    }
    global static void restorePolicy(DecsOnD__Policy__c policy) {

    }
    @Deprecated
    global static void saveDecisionTableConfig(DecsOnD__Policy__c policy, String tableName, DecsOnD.DecisionTableConfig newDtConfig, DecsOnD.VersionDescriptor version, Boolean updateServer) {

    }
    global static DecsOnD.VersionDescriptor saveMultipleDecisionTableContentsCSVMap(DecsOnD__Policy__c policy, DecsOnD.VersionDescriptor version, Map<String,String> contentsAsCSVMap) {
        return null;
    }
    global static DecsOnD.VersionDescriptor setActiveVersion(DecsOnD__Policy__c policy, Integer newActiveVersionNum) {
        return null;
    }
    @Deprecated
    global static List<DecsOnD.DecisionPointDescriptor> uninstallTemplates(List<DecsOnD.DecisionPointDescriptor> selTemplates) {
        return null;
    }
}
