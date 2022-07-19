/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class ScheduledExecutePolicy implements System.Schedulable {
    global Integer batchSize;
    global DecsOnD.PolicyInvocationContext invocationContext {
        get;
    }
    global Integer scopeSize {
        get;
        set;
    }
    global String whereClause {
        get;
    }
    global ScheduledExecutePolicy(DecsOnD.PolicyInvocationContext ctxt) {

    }
    global ScheduledExecutePolicy(DecsOnD.PolicyInvocationContext ctxt, String whereClause) {

    }
    global void execute(System.SchedulableContext sc) {

    }
}
