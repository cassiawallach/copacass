/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class AssignmentSettings {
    global static void addSettingLoadRequest(String groupName, Id policyId) {

    }
    global static void addSettingLoadRequest(String groupName, Schema.SObjectType objType) {

    }
    global List<String> applyCustomAssigneeOrder(List<String> assignees) {
        return null;
    }
    global Object getAssigneeSetting(String assignee, String settingName) {
        return null;
    }
    global Map<String,Object> getAssigneeSettings(String assignee) {
        return null;
    }
    global String getAssignmentMode() {
        return null;
    }
    global Double getAssignmentWeight(String assignee, Double defaultVal) {
        return null;
    }
    global Map<String,Object> getCaps() {
        return null;
    }
    global List<String> getCustomAssigneeOrder() {
        return null;
    }
    global String getGroupName() {
        return null;
    }
    global static DecsOnD.AssignmentSettings getInstance(String groupName, Id policyId) {
        return null;
    }
    global static DecsOnD.AssignmentSettings getInstance(String groupName, Schema.SObjectType objType) {
        return null;
    }
    global String getLastAssignee() {
        return null;
    }
    global Datetime getLastAssignmentDateTime(String assignee) {
        return null;
    }
    global Datetime getLastConsideredDateTime(String assignee) {
        return null;
    }
    global static DecsOnD.AssignmentSettings getOrCreateInstance(String groupName) {
        return null;
    }
    global static DecsOnD.AssignmentSettings getOrCreateInstance(String groupName, Id policyId) {
        return null;
    }
    global static DecsOnD.AssignmentSettings getOrCreateInstance(String groupName, Schema.SObjectType objType) {
        return null;
    }
    global Id getPolicyId() {
        return null;
    }
    global Schema.SObjectType getSObjectType() {
        return null;
    }
    global Object getSetting(String settingName) {
        return null;
    }
    global Double getWeightedAssignmentCredit(String assignee) {
        return null;
    }
    global Boolean hasCustomAssigneeOrder() {
        return null;
    }
    global Boolean hasCustomAssignmentWeights() {
        return null;
    }
    global static void loadAndCacheRequestedSettings() {

    }
    global static void persistSettings() {

    }
    global void setAssignmentMode(String mode) {

    }
    global void setAssignmentWeight(String assignee, Double weight) {

    }
    global void setCaps(Map<String,Object> caps) {

    }
    global void setCustomAssigneeOrder(List<String> newOrder) {

    }
    global void setLastAssignee(String assignee) {

    }
    global void setLastAssignmentDateTime(String assignee, Datetime dt) {

    }
    global void setLastConsideredDateTime(String assignee, Datetime dt) {

    }
    global void setWeightedAssignmentCredit(String assignee, Double credit) {

    }
    global void updateAssigneeSetting(String assignee, String settingName, Object val) {

    }
    global void updateSetting(String settingName, Object val) {

    }
}
