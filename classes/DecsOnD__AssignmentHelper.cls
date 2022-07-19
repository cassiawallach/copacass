/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class AssignmentHelper implements DecsOnD.PolicyActionBatch.CustomScopeLoader {
    global static String MODE_CUSTOM;
    global static String MODE_DIRECT;
    global static String MODE_RANDOM;
    global static String MODE_ROUND_ROBIN;
    global DecsOnD.PolicyInvocationContext policyContext {
        get;
    }
    global AssignmentHelper() {

    }
    global virtual void addScopeToBatch(DecsOnD.PolicyActionRecord actionRec, Boolean addMainRecordAsTarget) {

    }
    global static DecsOnD.AssignmentHelper createHelper(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global static DecsOnD.AssignmentHelper createHelper(System.Type helperType, DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual void finishApply(DecsOnD.PolicyActionRecord actionRec) {

    }
    global virtual void finishPrepare(DecsOnD.PolicyActionRecord actionRec, SObject owner) {

    }
    global virtual SObject getAssignedOwner(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual User getAssignedOwner(Group grp, Map<String,Object> parameters) {
        return null;
    }
    global virtual String getAssignmentGroupName(SObject mainRec, DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual List<User> getEligibleUsers(Group grp, Map<String,Object> parameters) {
        return null;
    }
    global virtual DecsOnD.GroupAssignmentHelper getGroupAssignmentHelper() {
        return null;
    }
    global virtual Schema.SObjectType getMainRecordType() {
        return null;
    }
    global virtual SObject getUserOrGroup(Map<String,Object> parameters) {
        return null;
    }
    global virtual void initialize(DecsOnD.PolicyInvocationContext context, Boolean allowQueueAsOwner, Boolean allowQueueAsGroup) {

    }
    @Deprecated
    global virtual Map<Id,List<User>> loadGroupMembers(Map<Id,Group> groups) {
        return null;
    }
    global virtual void loadScope(DecsOnD.PolicyActionBatch batch) {

    }
    @Deprecated
    global virtual Map<Id,User> queryEligibleUsers(Set<Id> userIds, Set<Id> roleIds) {
        return null;
    }
    global virtual User selectNextUser(Group grp, Map<String,Object> parameters) {
        return null;
    }
    global virtual String setAssignmentGroup(SObject mainRec, Group assignedGroup, DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual void setAssignmentStatus(DecsOnD.PolicyActionRecord actionRec, String status, Boolean doUpdate) {

    }
    global virtual void setGroupAssignmentHelper(DecsOnD.GroupAssignmentHelper helper) {

    }
    global virtual void startApply(DecsOnD.PolicyActionRecord actionRec) {

    }
    global virtual void startPrepare(DecsOnD.PolicyActionRecord actionRec) {

    }
}
