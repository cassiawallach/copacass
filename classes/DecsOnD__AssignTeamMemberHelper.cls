/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class AssignTeamMemberHelper extends DecsOnD.AssignmentHelper {
    global Boolean loadShares {
        get;
    }
    global AssignTeamMemberHelper() {

    }
    global override virtual void addScopeToBatch(DecsOnD.PolicyActionRecord actionRec, Boolean loadShares) {

    }
    global override virtual void loadScope(DecsOnD.PolicyActionBatch batch) {

    }
    global virtual List<SObject> queryShares(Schema.SObjectType objType, Set<SObject> mainRecords) {
        return null;
    }
    global virtual List<SObject> queryTeamMembers(Schema.SObjectType objType, Set<SObject> mainRecords) {
        return null;
    }
    global override virtual void setAssignmentStatus(DecsOnD.PolicyActionRecord actionRec, String status, Boolean doUpdate) {

    }
}
