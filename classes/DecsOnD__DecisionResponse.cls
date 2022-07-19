/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class DecisionResponse {
    global List<DecsOnD.DecisionResponse.Action> actions {
        get;
    }
    global List<DecsOnD.DecisionResponse.AuditLogEntry> auditLog {
        get;
    }
    global String executionID {
        get;
    }
    global Integer executionTime {
        get;
    }
    global static String FAIL;
    global List<String> messages {
        get;
        set;
    }
    global Map<String,List<String>> messagesMap {
        get;
    }
    global static String OK;
    global String status {
        get;
    }
    global DecsOnD.VersionDescriptor version {
        get;
    }
    global static String WARNING;
    global DecisionResponse() {

    }
    global DecisionResponse(String status, String executionID, DecsOnD.VersionDescriptor version, Integer executionTime) {

    }
    global DecisionResponse(String status, String executionID, DecsOnD.VersionDescriptor version, Integer executionTime, List<DecsOnD.DecisionParameter> outputParameters) {

    }
    global DecisionResponse(String status, String executionID, DecsOnD.VersionDescriptor version, Integer executionTime, List<DecsOnD.DecisionParameter> outputParameters, Map<String,List<String>> messages) {

    }
    global static DecsOnD.DecisionResponse fromJSON(String jsonStr) {
        return null;
    }
    global List<String> getErrorMessages() {
        return null;
    }
    global Map<String,Object> getOutputParameterMap() {
        return null;
    }
    global List<String> getRulesFired() {
        return null;
    }
    global List<String> getWarningMessages() {
        return null;
    }
    global Boolean hasErrors() {
        return null;
    }
    global Boolean hasWarnings() {
        return null;
    }
    global String toJSON(Boolean pretty) {
        return null;
    }
global class Action {
    global String message;
    global Map<String,Object> messageParameters;
    global String name;
    global Map<String,Object> parameters;
    global Action() {

    }
}
global virtual class AuditLogEntry {
    global String getCategory() {
        return null;
    }
    global Object getDataItem(String itemName) {
        return null;
    }
}
}
