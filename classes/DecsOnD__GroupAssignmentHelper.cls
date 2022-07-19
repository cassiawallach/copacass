/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class GroupAssignmentHelper {
    global static String ASSIGNEE_COUNT_ACTIVE;
    global static String ASSIGNEE_COUNT_AVAILABLE;
    global static String ASSIGNEE_COUNT_BELOW_CAP;
    global static String ASSIGNEE_COUNT_LOGGED_IN;
    global static String ASSIGNEE_COUNT_PRESENT;
    global static String ASSIGNEE_COUNT_TOTAL;
    global static String ASSIGNEE_COUNT_WORKING_HOURS;
    global Map<String,Integer> assigneeCounts;
    global Schema.SObjectField assignmentWeightField {
        get;
        set;
    }
    global DecsOnD.PolicyInvocationContext context {
        get;
    }
    global String explanation {
        get;
    }
    global Boolean fullAssignmentCountsLoaded {
        get;
    }
    global Schema.SObjectType mainRecordType {
        get;
    }
    global String shortExplanation {
        get;
    }
    @Deprecated
    global static String USER_COUNT_ACTIVE;
    @Deprecated
    global static String USER_COUNT_AVAILABLE;
    @Deprecated
    global static String USER_COUNT_BELOW_CAP;
    @Deprecated
    global static String USER_COUNT_LOGGED_IN;
    @Deprecated
    global static String USER_COUNT_PRESENT;
    @Deprecated
    global static String USER_COUNT_TOTAL;
    @Deprecated
    global static String USER_COUNT_WORKING_HOURS;
    global Map<String,Integer> userCounts {
        get;
        set;
    }
    global GroupAssignmentHelper() {

    }
    global GroupAssignmentHelper(DecsOnD.PolicyInvocationContext context) {

    }
    global GroupAssignmentHelper(Schema.SObjectType sObj) {

    }
    global virtual void addScopeToBatch(DecsOnD.PolicyActionRecord actionRec) {

    }
    global virtual void addToExplanation(String msg, String sep) {

    }
    global virtual void addToShortExplanation(String msg, String sep) {

    }
    global void clearAssignmentCounts() {

    }
    global virtual List<User> filterActiveUsers(List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<String> filterAssigneesByAssignmentCap(String groupName, List<String> assignees, Map<String,Integer> counts, Integer assignmentCap, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<String> filterAssigneesByAssignmentCap(String groupName, List<String> assignees, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<User> filterAvailableUsers(List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<DecsOnD.CandidateAssignment> filterEligibleAssignees(String groupName, List<DecsOnD.CandidateAssignment> candidates, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<String> filterEligibleAssignees(String groupName, List<String> assignees, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<User> filterEligibleUsers(String groupName, List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<User> filterLoggedInUsers(List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<User> filterPresentUsers(List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<User> filterUsersByAssignmentCap(String groupName, List<User> users, Map<Id,Integer> countsById, Integer assignmentCap, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<User> filterUsersByAssignmentCap(String groupName, List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<User> filterWorkingUsers(List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global virtual Integer getAssignmentCap(String groupName, Map<String,Object> parameters) {
        return null;
    }
    @Deprecated
    global virtual String getAssignmentCountFilter(Map<String,Object> parameters) {
        return null;
    }
    global virtual DecsOnD.AssignmentCountHelper getAssignmentCountHelper() {
        return null;
    }
    global virtual String getAssignmentCountMode(String groupName, Map<String,Object> parameters) {
        return null;
    }
    global virtual Integer getAssignmentCount(String groupName, String assignee, Map<String,Object> parameters) {
        return null;
    }
    @Deprecated
    global virtual Map<Id,Integer> getAssignmentCounts(List<User> users, Map<String,Object> parameters) {
        return null;
    }
    @Deprecated
    global virtual Map<Id,Integer> getAssignmentCounts(Set<Id> ownerIds, Map<String,Object> parameters) {
        return null;
    }
    global virtual Map<String,Integer> getAssignmentCounts(String groupName, Map<String,Object> parameters) {
        return null;
    }
    global virtual String getAssignmentMode(String groupName, Map<String,Object> parameters) {
        return null;
    }
    global virtual Double getAssignmentWeight(String groupName, String assignee, Map<String,Object> parameters) {
        return null;
    }
    global virtual Double getAssignmentWeight(String groupName, User usr, Map<String,Object> parameters) {
        return null;
    }
    @Deprecated
    global virtual Integer getCachedAssignmentCount(Id usrId) {
        return null;
    }
    @Deprecated
    global virtual Map<Id,Integer> getCachedAssignmentCounts() {
        return null;
    }
    global virtual Id getLastAssignedUserId(String groupName) {
        return null;
    }
    global virtual String getLastAssignee(String groupName) {
        return null;
    }
    @Deprecated
    global virtual Double getMaxAssignmentWeight(String groupName, List<String> assignees, Map<String,Object> parameters) {
        return null;
    }
    @Deprecated
    global virtual Double getMaxAssignmentWeight(String groupName, List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global virtual Datetime getReferenceTime(Map<String,Object> parameters) {
        return null;
    }
    @Deprecated
    global virtual Map<Id,Integer> queryAssignmentCounts(Set<Id> ownersToQuery, Schema.SObjectType objType, String ownerIdField, String assignmentCountFilter, Map<String,Object> parameters) {
        return null;
    }
    @Deprecated
    global virtual void registerAssignment(Id userId) {

    }
    global virtual void registerAssignment(String groupName, Id ownerId, Map<String,Object> parameters) {

    }
    global virtual DecsOnD.CandidateAssignment selectNextAssigneeLoadBalanced(String groupName, List<DecsOnD.CandidateAssignment> candidates, Map<String,Object> parameters) {
        return null;
    }
    global virtual String selectNextAssigneeLoadBalanced(String groupName, List<String> assignees, Map<String,Object> parameters) {
        return null;
    }
    global virtual DecsOnD.CandidateAssignment selectNextAssigneeRoundRobin(String groupName, List<DecsOnD.CandidateAssignment> candidates, Map<String,Object> parameters) {
        return null;
    }
    global virtual String selectNextAssigneeRoundRobin(String groupName, List<String> assignees, Map<String,Object> parameters) {
        return null;
    }
    global virtual DecsOnD.CandidateAssignment selectNextAssigneeWeightedRoundRobin(String groupName, List<DecsOnD.CandidateAssignment> candidates, Map<String,Object> parameters) {
        return null;
    }
    global virtual User selectNextUserLoadBalanced(String groupName, List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global virtual User selectNextUserRandom(String groupName, List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global virtual User selectNextUserRoundRobin(String groupName, List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global virtual User selectNextUser(String groupName, List<User> users, Map<String,Object> parameters) {
        return null;
    }
    @Deprecated
    global virtual void setCachedAssignmentCounts(Map<Id,Integer> counts) {

    }
    global virtual void setContext(DecsOnD.PolicyInvocationContext context) {

    }
    global virtual void setExplanation(String msg) {

    }
    global virtual void setReferenceTime(Datetime rt) {

    }
    global virtual void setShortExplanation(String msg) {

    }
    @Deprecated
    global virtual void unregisterAssignment(Id userId) {

    }
    global virtual void unregisterAssignment(String groupName, Id ownerId, Map<String,Object> parameters) {

    }
}
