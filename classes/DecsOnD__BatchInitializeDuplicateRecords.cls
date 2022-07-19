/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class BatchInitializeDuplicateRecords implements Database.Batchable<SObject>, Database.Stateful {
    global Boolean doFullRefresh;
    global DuplicateRule duplicateRule {
        get;
    }
    global String query {
        get;
    }
    global BatchInitializeDuplicateRecords(DuplicateRule duplicateRule, List<SObject> mainRecords) {

    }
    global BatchInitializeDuplicateRecords(DuplicateRule duplicateRule, String whereClause) {

    }
    global virtual void execute(Database.BatchableContext BC, List<SObject> scope) {

    }
    global virtual void finish(Database.BatchableContext BC) {

    }
    global virtual Integer getRecordCount() {
        return null;
    }
    global virtual Database.QueryLocator start(Database.BatchableContext BC) {
        return null;
    }
    global virtual void validateQuery() {

    }
}
