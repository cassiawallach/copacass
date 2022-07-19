/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class AssignmentCountHelper {
    global Schema.SObjectField assigneeField {
        get;
    }
    global Schema.SObjectField assignmentGroupField {
        get;
    }
    global Boolean fullAssignmentCountsLoaded {
        get;
    }
    global static String NO_GROUP;
    global Schema.SObjectType objectType {
        get;
    }
    global AssignmentCountHelper() {

    }
    global AssignmentCountHelper(Schema.SObjectType objType) {

    }
    global virtual void clearAssignmentCounts() {

    }
    global Integer getAssignmentCount(String groupName, String assignee) {
        return null;
    }
    global String getAssignmentCountFilter(String groupName) {
        return null;
    }
    global virtual Map<String,Integer> getAssignmentCounts(String groupName) {
        return null;
    }
    global virtual Map<String,Map<String,Integer>> getAssignmentCounts(Set<String> groups) {
        return null;
    }
    global Map<String,Map<String,Integer>> getCachedAssignmentCounts() {
        return null;
    }
    global virtual Map<String,Map<String,Integer>> queryAssignmentCounts(Set<String> groupsToQuery) {
        return null;
    }
    global void setAssignmentCountFilter(String groupName, String filter) {

    }
    global void setCachedAssignmentCounts(Map<String,Map<String,Integer>> newCounts) {

    }
    global virtual void updateAssignmentCount(String groupName, String assignee, Integer delta) {

    }
}
