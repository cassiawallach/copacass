/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class PolicyActionHandler {
    @Deprecated
    global static String ASSIGN_CASE_ACTION_NAME;
    @Deprecated
    global static String ASSIGN_LEAD_ACTION_NAME;
    global static String ASSIGN_OWNER;
    global static String ASSIGN_TEAM_MEMBER;
    global static String ASSIGN_TO_TERRITORY;
    @Deprecated
    global static String CREATE_AUDIT_LOG;
    @Deprecated
    global static String CREATE_AUDIT_NOTE_ACTION_NAME;
    global static String CREATE_EXECUTION_RECORD;
    global static String CREATE_OBJECT;
    global static String CREATE_TASK;
    global static DecsOnD.PolicyActionRecord currentActionRec {
        get;
    }
    global static String CUSTOM;
    global static String CUSTOMIZABLE_FEATURE_ACTIONS;
    global static String DELETE_OBJECT;
    global static String DISPLAY_MESSAGE;
    global static String SEND_EMAIL;
    global static String SEND_OUTBOUND_MESSAGE;
    @Deprecated
    global static String SET_REFERENCE_ACTION_NAME;
    @Deprecated
    global static String SHOW_MESSAGE_ACTION_NAME;
    global static String UPDATE_OBJECT;
    global PolicyActionHandler() {

    }
    global static void applyAction(DecsOnD.PolicyActionRecord actionRec) {

    }
    @Deprecated
    global static void applyAction(String actionName, SObject mainRecord, List<SObject> detailObjects, DecsOnD__Policy__c policy, Map<String,Object> parameters, DecsOnD.DecisionResponse response) {

    }
    global static DecsOnD.IPolicyAction getIPolicyAction(String name) {
        return null;
    }
    @Deprecated
    global static DecsOnD.PolicyAction getPolicyAction(String name) {
        return null;
    }
    global static DecsOnD.PolicyActionRecord prepareAction(String actionName, DecsOnD.PolicyActionContext context) {
        return null;
    }
    @Deprecated
    global static void registerPolicyAction(DecsOnD.IPolicyAction action) {

    }
    @Deprecated
    global static void registerPolicyAction(DecsOnD.PolicyAction action) {

    }
    global static void registerPolicyAction(System.Type actionClass) {

    }
global class AssignCaseAction implements DecsOnD.PolicyAction {
    global AssignCaseAction() {

    }
    global void applyAction(SObject mainRecord, List<SObject> detailObjects, DecsOnD__Policy__c policy, Map<String,Object> parameters, DecsOnD.DecisionResponse response) {

    }
    global String getName() {
        return null;
    }
}
global class AssignLeadAction implements DecsOnD.PolicyAction {
    global AssignLeadAction() {

    }
    global void applyAction(SObject mainRecord, List<SObject> detailObjects, DecsOnD__Policy__c policy, Map<String,Object> parameters, DecsOnD.DecisionResponse response) {

    }
    global String getName() {
        return null;
    }
}
global class AssignOwnerAction extends DecsOnD.PolicyActionHandler.DeprecatedActionBase implements DecsOnD.IPolicyAction {
    global override void apply(DecsOnD.PolicyActionRecord actionRec) {

    }
    global override String getLabel(String locale) {
        return null;
    }
    global override String getName() {
        return null;
    }
    global override void prepare(DecsOnD.PolicyActionRecord actionRec) {

    }
}
global class CreateAuditLogAction extends DecsOnD.PolicyActionHandler.DeprecatedActionBase implements DecsOnD.IPolicyAction {
    global override void apply(DecsOnD.PolicyActionRecord actionRec) {

    }
    global override String getLabel(String locale) {
        return null;
    }
    global override String getName() {
        return null;
    }
    global override void prepare(DecsOnD.PolicyActionRecord actionRec) {

    }
}
global class CreateAuditNoteAction implements DecsOnD.PolicyAction {
    global String MODIFIED_FIELDS;
    global CreateAuditNoteAction() {

    }
    global void applyAction(SObject mainRecord, List<SObject> detailObjects, DecsOnD__Policy__c policy, Map<String,Object> parameters, DecsOnD.DecisionResponse response) {

    }
    global String getName() {
        return null;
    }
}
global class CreateObjectAction extends DecsOnD.PolicyActionHandler.DeprecatedActionBase implements DecsOnD.IPolicyAction {
    global override void apply(DecsOnD.PolicyActionRecord actionRec) {

    }
    global override String getLabel(String locale) {
        return null;
    }
    global override String getName() {
        return null;
    }
    global override void prepare(DecsOnD.PolicyActionRecord actionRec) {

    }
}
global class CreateTaskAction extends DecsOnD.PolicyActionHandler.DeprecatedActionBase implements DecsOnD.IPolicyAction {
    global override void apply(DecsOnD.PolicyActionRecord actionRec) {

    }
    global override String getLabel(String locale) {
        return null;
    }
    global override String getName() {
        return null;
    }
    global override void prepare(DecsOnD.PolicyActionRecord actionRec) {

    }
}
global class DeleteObjectAction extends DecsOnD.PolicyActionHandler.DeprecatedActionBase implements DecsOnD.IPolicyAction {
    global override void apply(DecsOnD.PolicyActionRecord actionRec) {

    }
    global override String getLabel(String locale) {
        return null;
    }
    global override String getName() {
        return null;
    }
    global override void prepare(DecsOnD.PolicyActionRecord actionRec) {

    }
}
global class DisplayMessageAction extends DecsOnD.PolicyActionHandler.DeprecatedActionBase implements DecsOnD.IPolicyAction {
    global override void apply(DecsOnD.PolicyActionRecord actionRec) {

    }
    global override String getLabel(String locale) {
        return null;
    }
    global override String getName() {
        return null;
    }
    global override void prepare(DecsOnD.PolicyActionRecord actionRec) {

    }
}
global class SendEmailAction extends DecsOnD.PolicyActionHandler.DeprecatedActionBase implements DecsOnD.IPolicyAction {
    global override void apply(DecsOnD.PolicyActionRecord actionRec) {

    }
    global override String getLabel(String locale) {
        return null;
    }
    global override String getName() {
        return null;
    }
    global override void prepare(DecsOnD.PolicyActionRecord actionRec) {

    }
}
global class SendOutboundMessageAction extends DecsOnD.PolicyActionHandler.DeprecatedActionBase implements DecsOnD.IPolicyAction {
    global override void apply(DecsOnD.PolicyActionRecord actionRec) {

    }
    global override String getLabel(String locale) {
        return null;
    }
    global override String getName() {
        return null;
    }
    global override void prepare(DecsOnD.PolicyActionRecord actionRec) {

    }
}
global class SetReferenceAction implements DecsOnD.PolicyAction {
    global String FIELD_PARAMETER;
    global String LOOKUP_FIELD_PARAMETER;
    global String LOOKUP_VALUE_PARAMETER;
    global String REFERENCE_TYPE_PARAMETER;
    global SetReferenceAction() {

    }
    global void applyAction(SObject mainRecord, List<SObject> detailObjects, DecsOnD__Policy__c policy, Map<String,Object> parameters, DecsOnD.DecisionResponse response) {

    }
    global String getName() {
        return null;
    }
}
global class ShowMessageAction implements DecsOnD.PolicyAction {
    global String DETAIL_MESSAGE_PARAMETER;
    global String MESSAGE_PARAMETER;
    global String SEVERITY_PARAMETER;
    global ShowMessageAction() {

    }
    global void applyAction(SObject mainRecord, List<SObject> detailObjects, DecsOnD__Policy__c policy, Map<String,Object> parameters, DecsOnD.DecisionResponse response) {

    }
    global String getName() {
        return null;
    }
}
global class UpdateObjectAction extends DecsOnD.PolicyActionHandler.DeprecatedActionBase implements DecsOnD.IPolicyAction {
    global override void apply(DecsOnD.PolicyActionRecord actionRec) {

    }
    global override String getLabel(String locale) {
        return null;
    }
    global override String getName() {
        return null;
    }
    global override void prepare(DecsOnD.PolicyActionRecord actionRec) {

    }
}
}
