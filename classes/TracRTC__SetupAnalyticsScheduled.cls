/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SetupAnalyticsScheduled implements Database.Stateful, System.Schedulable {
    global String mapAsString;
    global Map<String,Object> reportInstanceIdsByName {
        get;
        set;
    }
    global Set<String> reportNames;
    global Boolean runReport;
    global void execute(System.SchedulableContext sc) {

    }
    global static void scheduleAnalyticsReports() {

    }
    @TestVisible
    global static Id scheduleCollectResults(Map<String,Object> reportInstanceIdsByName) {
        return null;
    }
    @TestVisible
    global static Id scheduleCollectResults(String schedule, Map<String,Object> reportInstanceIdsByName) {
        return null;
    }
    global static Id scheduleRun() {
        return null;
    }
    @TestVisible
    global static Id scheduleRun(String schedule) {
        return null;
    }
}
