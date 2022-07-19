/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class UserAvailabilityFilter {
    global static Schema.SObjectField doNotAssignField {
        get;
        set;
    }
    global String explanation;
    global UserAvailabilityFilter() {

    }
    global virtual List<User> filterAvailableUsers(List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<User> filterPresentUsers(List<User> users, Datetime gmtTime, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<User> filterUsers(List<User> users, Datetime gmtTime, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<User> filterWorkingUsers(List<User> users, Datetime gmtTime, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<Event> getAbsences(List<User> users, Datetime gmtStartTime, Datetime gmtEndTime, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<Event> getAbsences(List<User> users, Datetime gmtTime, Map<String,Object> parameters) {
        return null;
    }
    global virtual Map<Id,Id> getBusinessHours(List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global static DecsOnD.UserAvailabilityFilter getSingleton() {
        return null;
    }
    global virtual List<Event> queryAbsences(List<User> users, Datetime gmtStartTime, Datetime gmtEndTime, Map<String,Object> parameters) {
        return null;
    }
    global virtual List<Event> queryAbsences(List<User> users, Datetime gmtTime, Map<String,Object> parameters) {
        return null;
    }
    global virtual Map<Id,Id> queryBusinessHours(List<User> users, Map<String,Object> parameters) {
        return null;
    }
    global static void setSingleton(DecsOnD.UserAvailabilityFilter filter) {

    }
}
