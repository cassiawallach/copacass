/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class InvocationFacade {
    global InvocationFacade() {

    }
    global static Id executeBatchOnce(DecsOnD.BatchExecutePolicy batch) {
        return null;
    }
    global static Id executeBatchOnce(DecsOnD.BatchExecutePolicy batch, Integer batchSize) {
        return null;
    }
    global static Id executeBatchPeriodic(DecsOnD.PeriodicExecutePolicy batch) {
        return null;
    }
    @Deprecated
    global static Id executeBatchPeriodic(DecsOnD.PeriodicExecutePolicy batch, Integer batchSize) {
        return null;
    }
    global static List<DecsOnD.ApplyPolicyHelper> executeBatchSynchronous(DecsOnD.PolicyInvocationContext invocationContext, List<SObject> parentRecs) {
        return null;
    }
    global static List<DecsOnD.ApplyPolicyHelper> executeBatchSynchronous(DecsOnD.PolicyInvocationContext invocationContext, Set<Id> parentRecs) {
        return null;
    }
    global static Id executeBatchWithDelay(DecsOnD.BatchExecutePolicy batch, Integer minutesDelay) {
        return null;
    }
    global static Id executeBatchWithDelay(DecsOnD.BatchExecutePolicy batch, Integer minutesDelay, Integer batchSize) {
        return null;
    }
    global static Map<String,String> executeFromTriggerAll() {
        return null;
    }
    global static Map<String,String> executeFromTriggerAll(Integer batchSize) {
        return null;
    }
    global static Map<String,String> executeFromTrigger(DecsOnD.PolicyInvocationContext invocationContext) {
        return null;
    }
    global static Map<String,String> executeFromTrigger(DecsOnD.PolicyInvocationContext invocationContext, DecsOnD.IScopeFilter filter) {
        return null;
    }
    global static Map<String,String> executeFromTrigger(DecsOnD.PolicyInvocationContext invocationContext, DecsOnD.IScopeFilter filter, Integer batchSize) {
        return null;
    }
    global static Id executeScheduled(DecsOnD.ScheduledExecutePolicy sched, String cronExpression, Integer batchSize) {
        return null;
    }
    global static List<Id> executeScheduled(DecsOnD.ScheduledExecutePolicy sched, Integer jobsPerHour, Integer firstStartMinute, Integer batchSize) {
        return null;
    }
}
