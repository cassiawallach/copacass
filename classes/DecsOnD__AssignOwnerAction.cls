/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class AssignOwnerAction implements DecsOnD.IBatchablePolicyAction, DecsOnD.IBatchablePolicyAction2, DecsOnD.IPolicyAction {
    global static String ASSIGNMENT_MODE_PARAMETER;
    global static String ID_PARAMETER;
    global static String NAME;
    global static String PUBLIC_GROUP_PARAMETER;
    global static String QUEUE_PARAMETER;
    global static String ROLE_PARAMETER;
    global static String USER_PARAMETER;
    global AssignOwnerAction() {

    }
    global virtual void addScopeToBatch(DecsOnD.PolicyActionRecord actionRec) {

    }
    global virtual void apply(DecsOnD.PolicyActionRecord actionRec) {

    }
    global virtual DecsOnD.AssignmentHelper createHelper(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual DecsOnD.AssignmentHelper createNoBatchHelper(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual void enrichExecutionRecord(DecsOnD__PolicyExecutionRecord__c execRecord, DecsOnD.PolicyActionRecord actionRec) {

    }
    global virtual SObject getAssignedOwner(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    @Deprecated
    global virtual SObject getAssignedOwner(DecsOnD.PolicyActionRecord actionRec, Boolean allowQueueOwner) {
        return null;
    }
    global static DecsOnD.AssignmentHelper getCachedHelper(DecsOnD.PolicyInvocationContext ctxt) {
        return null;
    }
    global virtual DecsOnD.AssignmentHelper getHelper(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual String getLabel(String locale) {
        return null;
    }
    global virtual String getName() {
        return null;
    }
    global virtual void prepare(DecsOnD.PolicyActionRecord actionRec) {

    }
    global virtual String reassignRelatedRecords(DecsOnD.PolicyActionRecord actionRec, SObject mainRec, SObject owner, String relName, String objName) {
        return null;
    }
    global static void setCachedHelper(DecsOnD.PolicyInvocationContext ctxt, DecsOnD.AssignmentHelper helper) {

    }
}
