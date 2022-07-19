/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class Config {
    global static System.Version API_VERSION;
    global static System.Version CLIENT_VERSION;
    global static String CUSTOMIZATION_FEATURE_APEX_TYPE;
    @Deprecated
    global static String CUSTOMIZATION_FEATURE_FIELDS_TO_LOAD;
    global static Boolean debugMode {
        get;
        set;
    }
    global static Boolean interactiveMode {
        get;
        set;
    }
    global Config() {

    }
    global static void addFieldToLoad(Schema.SObjectType objType, Schema.SObjectField newField) {

    }
    global static void addFieldToLoad(Schema.SObjectType objType, String fieldName) {

    }
    global static void addFieldsToLoad(Schema.SObjectType objType, Set<Schema.SObjectField> newFields) {

    }
    global static String getApplication() {
        return null;
    }
    global static Object getCustomApexInstance(System.Type baseType, Map<String,Object> params) {
        return null;
    }
    global static System.Type getCustomApexType(System.Type baseType) {
        return null;
    }
    global static System.Type getCustomApexType(String baseTypeName, Map<String,Object> params) {
        return null;
    }
    global static DecsOnD.ICustomizationManager getCustomizationManager() {
        return null;
    }
    global static String getCustomizationValueAsString(String featureName, String settingName, Map<String,Object> params) {
        return null;
    }
    global static Object getCustomizationValue(String featureName, String settingName, Map<String,Object> params) {
        return null;
    }
    global static Map<String,Object> getCustomizations(String featureName, Map<String,Object> params) {
        return null;
    }
    global static String getDecisionServerURL() {
        return null;
    }
    global static Set<Schema.SObjectField> getFieldsToLoad(Schema.SObjectType objType) {
        return null;
    }
    global static String getPolicyManagementServerURL() {
        return null;
    }
    global static void registerCustomApexType(System.Type baseType, System.Type customType) {

    }
    global static void setCustomizationManager(DecsOnD.ICustomizationManager mgr) {

    }
}
