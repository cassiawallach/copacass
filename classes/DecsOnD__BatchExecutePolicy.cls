/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class BatchExecutePolicy implements Database.AllowsCallouts, Database.Batchable<SObject>, Database.RaisesPlatformEvents, Database.Stateful {
    global Boolean auditTrail {
        get;
        set;
    }
    global Boolean createExecutionRecord {
        get;
        set;
    }
    global List<DecsOnD.ApplyPolicyHelper> helpersLastBatch {
        get;
    }
    global DecsOnD.PolicyInvocationContext invocationContext {
        get;
    }
    global String query {
        get;
    }
    global String sessionId {
        get;
        set;
    }
    global BatchExecutePolicy(DecsOnD.PolicyInvocationContext context) {

    }
    global BatchExecutePolicy(DecsOnD.PolicyInvocationContext context, List<SObject> scope) {

    }
    global BatchExecutePolicy(DecsOnD.PolicyInvocationContext context, Map<String,Object> whereConditions) {

    }
    global BatchExecutePolicy(DecsOnD.PolicyInvocationContext context, Set<Id> scopeIds) {

    }
    global BatchExecutePolicy(DecsOnD.PolicyInvocationContext context, Boolean doInitQuery) {

    }
    global BatchExecutePolicy(DecsOnD.PolicyInvocationContext context, String whereClause) {

    }
    global virtual void execute(Database.BatchableContext BC, List<SObject> scope) {

    }
    global virtual void finish(Database.BatchableContext BC) {

    }
    global virtual Database.QueryLocator start(Database.BatchableContext BC) {
        return null;
    }
}
