/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class CandidateAssignment implements System.Comparable {
    global String assignee {
        get;
    }
    global String assigneeLabel {
        get;
    }
    global SObject assigneeRec {
        get;
    }
    global Boolean considered;
    global Double creditAfter;
    global Double creditBefore;
    global String explanation;
    global String groupName {
        get;
    }
    global Datetime lastAssignment;
    global Datetime lastConsidered;
    global Schema.SObjectType mainRecordType {
        get;
    }
    global DecsOnD.CandidateAssignment parent;
    global String reasonSkipped;
    global Integer roundRobinPosition;
    global Boolean selected;
    global DecsOnD.CandidateAssignment selectedAssignment;
    global Datetime timestamp;
    global Double weight;
    global CandidateAssignment(String groupName, Schema.SObjectType mainRecType, SObject assigneeRec) {

    }
    global CandidateAssignment(String groupName, Schema.SObjectType mainRecType, String assignee, String assigneeLabel) {

    }
    global virtual Integer compareTo(Object obj) {
        return null;
    }
    global static List<DecsOnD.CandidateAssignment> createCandidates(String groupName, Schema.SObjectType mainRecType, List<SObject> assignees) {
        return null;
    }
    global static List<DecsOnD.CandidateAssignment> createCandidates(String groupName, Schema.SObjectType mainRecType, List<String> assignees) {
        return null;
    }
}
