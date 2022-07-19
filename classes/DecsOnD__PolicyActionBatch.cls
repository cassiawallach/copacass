/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class PolicyActionBatch {
    global Map<String,String> errors {
        get;
    }
    global PolicyActionBatch() {

    }
    global virtual void addError(String executionID, String actionName, String message) {

    }
    global void addError(String executionID, String actionName, String message, Exception e) {

    }
    global virtual void addToScope(DecsOnD.IPolicyAction action, Id objId) {

    }
    @Deprecated
    global void addToScope(DecsOnD.IPolicyAction action, Schema.SObjectType objType, Set<String> subScopeStrings) {

    }
    global virtual void apply() {

    }
    global SObject getScopeObject(String actionName, Id recId) {
        return null;
    }
    global virtual void loadScope() {

    }
global interface CustomScopeLoader {
    void loadScope(DecsOnD.PolicyActionBatch param0);
}
}
