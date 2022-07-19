/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class ApplyPolicyToListController extends DecsOnD.ApplyPolicyControllerBase {
    global Map<Id,List<DecsOnD.PolicyActionRecord>> actionsMap {
        get;
    }
    global Map<Id,List<SObject>> detailObjectsMap {
        get;
    }
    global String redirectUrl {
        get;
        set;
    }
    global List<SObject> selectedObjects {
        get;
    }
    global ApplyPolicyToListController() {

    }
    global override virtual System.PageReference acceptChanges() {
        return null;
    }
    global virtual System.PageReference applyPolicyToList() {
        return null;
    }
    global System.PageReference cancel() {
        return null;
    }
    global override virtual System.PageReference cancelChanges() {
        return null;
    }
    global virtual List<SObject> getDetailRecords(Id parentID, String relKey) {
        return null;
    }
    global override virtual SObject getMainRecord() {
        return null;
    }
    global override virtual void loadMainRecord() {

    }
    global System.PageReference save() {
        return null;
    }
}
