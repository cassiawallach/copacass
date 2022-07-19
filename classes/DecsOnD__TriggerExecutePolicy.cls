/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class TriggerExecutePolicy {
    global Integer batchSize;
    global Boolean createAuditTrail {
        get;
        set;
    }
    global Boolean createExecutionRecord {
        get;
        set;
    }
    global static Boolean deactivateTriggers;
    global Boolean emailSupportOnFailure;
    global DecsOnD.PolicyInvocationContext invocationContext {
        get;
    }
    global List<DecsOnD.PolicyInvocationContext> invocationContexts;
    @Deprecated
    global static Boolean isExecutingPolicy;
    global Set<Id> scopeIDs;
    global static String sourceSessionId;
    global static String sourceTriggerId;
    global String triggerId {
        get;
    }
    global String whereClause;
    global TriggerExecutePolicy() {

    }
    global TriggerExecutePolicy(DecsOnD.PolicyInvocationContext invocationContext, List<SObject> scope, Boolean createExecutionRecord) {

    }
    global TriggerExecutePolicy(DecsOnD.PolicyInvocationContext invocationContext, Set<Id> scope, Boolean createExecutionRecord) {

    }
    global TriggerExecutePolicy(String triggerId, DecsOnD.PolicyInvocationContext invocationContext, List<SObject> scope, Boolean createExecutionRecord) {

    }
    global TriggerExecutePolicy(String triggerId, DecsOnD.PolicyInvocationContext invocationContext, Set<Id> scope, Boolean createExecutionRecord) {

    }
    global virtual void execute() {

    }
    global static String getTriggerNotOKReason() {
        return null;
    }
    global virtual void initialize(String triggerId, List<DecsOnD.PolicyInvocationContext> invocationContexts, Set<Id> scopeIds, Boolean skipRecursiveInvocationCheck) {

    }
    global static Boolean isOkToRunTrigger() {
        return null;
    }
}
