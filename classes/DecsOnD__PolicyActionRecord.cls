/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class PolicyActionRecord {
    global DecsOnD.IPolicyAction action {
        get;
    }
    global String actionLabel {
        get;
    }
    global String actionName {
        get;
    }
    global Map<String,Object> actionParameters {
        get;
    }
    global DecsOnD.PolicyActionBatch batch {
        get;
        set;
    }
    global Map<Id,String> licenseMessages {
        get;
    }
    global List<String> messages {
        get;
    }
    global List<String> targetObjectNames {
        get;
    }
    global List<SObject> targetObjects {
        get;
        set;
    }
    global List<String> targetRecordNames {
        get;
    }
    global List<SObject> targetRecords {
        get;
    }
    global Long uuid {
        get;
    }
    global PolicyActionRecord(DecsOnD.PolicyActionContext context, DecsOnD.IPolicyAction action) {

    }
    global PolicyActionRecord(DecsOnD.PolicyActionContext context, String actionName, String actionLabel) {

    }
    global void addActionParameter(String name, Object value) {

    }
    global void addLicenseMessages(Map<Id,String> newMessages) {

    }
    global void addMessage(String msg) {

    }
    global void addMessages(List<String> newMessages) {

    }
    @Deprecated
    global void addTargetObject(SObject obj) {

    }
    global void addTargetRecord(SObject rec) {

    }
    global void appendToMainMessage(String msg) {

    }
    global void doDelete() {

    }
    global void doInsert() {

    }
    global void doUpdate() {

    }
    global Object getActionParameter(String name) {
        return null;
    }
    global String getActionParameterAsString(String paramName) {
        return null;
    }
    global String getActionParameterAsString(String paramName, Boolean optional) {
        return null;
    }
    global Boolean getBooleanActionParameter(String paramName) {
        return null;
    }
    global Boolean getBooleanActionParameter(String paramName, Boolean defaultVal) {
        return null;
    }
    global DecsOnD.PolicyActionContext getContext() {
        return null;
    }
    global SObject getMainTargetRecord() {
        return null;
    }
    @Deprecated
    global SObject getTargetObject() {
        return null;
    }
    global void prependMessage(String msg) {

    }
    global void setMainTargetRecord(SObject rec) {

    }
    @Deprecated
    global void setTargetObject(SObject obj) {

    }
}
