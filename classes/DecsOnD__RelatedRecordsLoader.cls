/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class RelatedRecordsLoader {
    global RelatedRecordsLoader() {

    }
    global virtual void addDefaultRelatedRecordsLoadRequests(Id mainRecId, Map<String,Object> parameters) {

    }
    global void addRelatedRecordToCache(Id parentId, String relName, SObject relatedRec) {

    }
    global void addRelatedRecordsLoadRequest(Id parentId, String relName, Map<String,Object> parameters) {

    }
    global virtual void addRelatedRecordsLoadRequest(Id parentId, String relName, String mode, Map<String,Object> parameters) {

    }
    global virtual void addRelatedRecordsToCache(Id parentId, String relName, Map<Id,SObject> newRelatedRecs) {

    }
    global virtual Set<Id> executeLoadRequests() {
        return null;
    }
    global static String getCustomWhereClauseParameterName(Schema.SObjectType mainRecordType, String relName) {
        return null;
    }
    @Deprecated
    global static String getCustomWhereClausePropertyKey(Schema.SObjectType mainRecordType, String relName) {
        return null;
    }
    global static String getReassignmentMode(String relName, Map<String,Object> parameters) {
        return null;
    }
    global virtual Map<Id,SObject> getRelatedRecordsFromCache(Id parentId, String relName) {
        return null;
    }
    global static DecsOnD.RelatedRecordsLoader getSingleton() {
        return null;
    }
    global virtual Map<Id,Map<Id,SObject>> loadRelatedRecords(Set<Id> parentIDs, String relName, Schema.SObjectType targetType, Set<String> parentFields, Set<String> fieldNames, String customWhereClause) {
        return null;
    }
    global virtual void registerRelationInfo(Schema.SObjectType parentType, String relName, Set<String> parentFieldNames, Set<String> fieldNames, String customWhereClause) {

    }
}
