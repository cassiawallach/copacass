/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class AssignTeamMemberAction implements DecsOnD.IBatchablePolicyAction2, DecsOnD.IPolicyAction {
    global static String ID_PARAMETER;
    global static String NAME;
    @Deprecated
    global static String ROLE_PARAMETER;
    global static String USER_PARAMETER;
    global AssignTeamMemberAction() {

    }
    global virtual void addScopeToBatch(DecsOnD.PolicyActionRecord actionRec) {

    }
    global virtual void apply(DecsOnD.PolicyActionRecord actionRec) {

    }
    @Deprecated
    global virtual DecsOnD.AssignTeamMemberAction.AssignTeamMemberHelper createHelper(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual DecsOnD.AssignTeamMemberHelper createHelper2(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual SObject createNewAssignment(SObject mainRec, User usr, Map<String,Object> parameters) {
        return null;
    }
    @Deprecated
    global virtual DecsOnD.AssignTeamMemberAction.AssignTeamMemberHelper createNoBatchHelper(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual DecsOnD.AssignTeamMemberHelper createNoBatchHelper2(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    @Deprecated
    global static DecsOnD.AssignTeamMemberAction.AssignTeamMemberHelper getCachedHelper(DecsOnD.PolicyInvocationContext ctxt) {
        return null;
    }
    global static DecsOnD.AssignTeamMemberHelper getCachedHelper2(DecsOnD.PolicyInvocationContext ctxt) {
        return null;
    }
    @Deprecated
    global virtual DecsOnD.AssignTeamMemberAction.AssignTeamMemberHelper getHelper(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual DecsOnD.AssignTeamMemberHelper getHelper2(DecsOnD.PolicyActionRecord actionRec) {
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
    @Deprecated
    global static void setCachedHelper(DecsOnD.PolicyInvocationContext ctxt, DecsOnD.AssignTeamMemberAction.AssignTeamMemberHelper helper) {

    }
    global static void setCachedHelper2(DecsOnD.PolicyInvocationContext ctxt, DecsOnD.AssignTeamMemberHelper helper) {

    }
global virtual class AssignTeamMemberHelper extends DecsOnD.AssignmentHelper {
    global Boolean loadShares {
        get;
    }
    global AssignTeamMemberHelper() {

    }
    global override void addScopeToBatch(DecsOnD.PolicyActionRecord actionRec, Boolean loadShares) {

    }
    global override void loadScope(DecsOnD.PolicyActionBatch batch) {

    }
}
}
