/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class DecisionRequest {
    global String application {
        get;
    }
    global String decisionPoint {
        get;
    }
    global List<DecsOnD.DecisionParameter> inputParameters {
        get;
        set;
    }
    global String mode {
        get;
        set;
    }
    global static String MODE_CONCISE;
    global static String MODE_DEBUG;
    global static String MODE_PRODUCTION;
    global static String MODE_TRACE;
    global Map<String,Map<Integer,String>> rowLogLevels {
        get;
        set;
    }
    global String service {
        get;
    }
    global Map<String,String> tableLogLevels {
        get;
        set;
    }
    global Set<String> triggerEvents {
        get;
        set;
    }
    global DecsOnD.VersionDescriptor version {
        get;
        set;
    }
    global DecisionRequest(Schema.SObjectType mainRecordType, String policyName) {

    }
    global DecisionRequest(SObject mainRecord, String policyName) {

    }
    global DecisionRequest(Schema.SObjectType mainRecordType, String policyName, Map<String,Object> inputParameterMap) {

    }
    global DecisionRequest(SObject mainRecord, String policyName, Map<String,Object> inputParameterMap) {

    }
    global void addInputParameter(DecsOnD.DecisionParameter param) {

    }
    global void addInputParameter(String name, Object value) {

    }
    global static DecsOnD.DecisionRequest fromJSON(String jsonStr) {
        return null;
    }
    global DecsOnD.DecisionParameter getInputParameter(String paramName) {
        return null;
    }
    global Map<String,Object> getInputParameterMap() {
        return null;
    }
    global void removeInputParameter(String name) {

    }
    global void setInputParameterMap(Map<String,Object> inputParameterMap) {

    }
    global void setRowLogLevels(Map<String,Map<Integer,String>> rowsLogLevel, String policyLogLevel) {

    }
    global void setTableLogLevels(Map<String,String> tablesLogLevel, String policyLogLevel) {

    }
    global String toJSON(Boolean pretty) {
        return null;
    }
}
