/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class VersionDescriptor {
    global Boolean active {
        get;
        set;
    }
    global String createdBy {
        get;
        set;
    }
    global Long creationTime {
        get;
        set;
    }
    global String label {
        get;
        set;
    }
    global String notes {
        get;
        set;
    }
    global Long sequenceNum {
        get;
        set;
    }
    global String status {
        get;
        set;
    }
    global String updatedBy {
        get;
        set;
    }
    global Long updateTime {
        get;
        set;
    }
    global VersionDescriptor() {

    }
    global VersionDescriptor(Integer sequenceNum) {

    }
    global VersionDescriptor(Long sequenceNum) {

    }
    global VersionDescriptor(Long sequenceNum, String label) {

    }
    global static DecsOnD.VersionDescriptor fromJSON(String jsonStr) {
        return null;
    }
    global virtual String toJSON(Boolean pretty) {
        return null;
    }
}
