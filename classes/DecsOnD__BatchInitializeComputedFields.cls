/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class BatchInitializeComputedFields implements Database.Batchable<SObject>, Database.Stateful {
    global String additionalConditions {
        get;
    }
    global Schema.SObjectType objType {
        get;
    }
    global String query {
        get;
    }
    global Boolean refreshAll {
        get;
    }
    global Integer totalRecordsProcessed {
        get;
    }
    global Integer totalRecordsUpdated {
        get;
    }
    global BatchInitializeComputedFields(Schema.SObjectType objType) {

    }
    global BatchInitializeComputedFields(Schema.SObjectType objType, String additionalConditions) {

    }
    global BatchInitializeComputedFields(Schema.SObjectType objType, Boolean refreshAll, String additionalConditions) {

    }
    global virtual Integer countMatchingRecords() {
        return null;
    }
    global virtual String createQuery() {
        return null;
    }
    global virtual void execute(Database.BatchableContext BC, List<SObject> scope) {

    }
    global virtual void finish(Database.BatchableContext BC) {

    }
    global virtual Database.QueryLocator start(Database.BatchableContext BC) {
        return null;
    }
    global void updateCounts(Integer recordsProcessed, Integer recordsUpdated) {

    }
}
