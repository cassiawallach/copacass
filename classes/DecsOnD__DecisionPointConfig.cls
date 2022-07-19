/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class DecisionPointConfig {
    @AuraEnabled
    global String description;
    @AuraEnabled
    global List<DecsOnD.DecisionPointConfig.Parameter> input_parameters;
    global String label {
        get;
        set;
    }
    @AuraEnabled
    global List<String> models;
    @AuraEnabled
    global String policy_name;
    @AuraEnabled
    global List<String> rules;
    @AuraEnabled
    global List<String> tables;
    global DecisionPointConfig() {

    }
    global static DecsOnD.DecisionPointConfig fromJSON(String dpConfigJSON) {
        return null;
    }
    global DecsOnD.DecisionPointConfig.Parameter getInputParameter(String paramFQN) {
        return null;
    }
    global Schema.SObjectType getInputParameterSObjectType(String paramName) {
        return null;
    }
    global DecsOnD.DecisionPointConfig.Parameter getParentParameter(String paramFQN) {
        return null;
    }
    global Boolean isTopLevelParameter(String paramName) {
        return null;
    }
    global static Map<String,DecsOnD.DecisionPointConfig> mapFromJSON(String dpConfigsJSON) {
        return null;
    }
    global virtual String toJSON(Boolean pretty) {
        return null;
    }
global class Parameter {
    @AuraEnabled
    global Map<String,String> custom_fields;
    @AuraEnabled
    global List<String> fields_to_exclude;
    @AuraEnabled
    global List<String> fields_to_load;
    global String label {
        get;
        set;
    }
    @AuraEnabled
    global String load_condition;
    global String name {
        get;
        set;
    }
    @AuraEnabled
    global String parent_id;
    @AuraEnabled
    global List<DecsOnD.DecisionPointConfig.Parameter> relations;
    @AuraEnabled
    global Boolean required;
    global String source {
        get;
        set;
    }
    @AuraEnabled
    global DecsOnD.DecisionParameter.ValueType value_type;
    global Parameter() {

    }
    global Set<String> getFieldNames() {
        return null;
    }
    global DecsOnD.DecisionPointConfig.Parameter getRelation(String relName) {
        return null;
    }
    global Schema.SObjectType getSObjectType() {
        return null;
    }
    global Boolean hasCollectionValueType() {
        return null;
    }
    global Boolean isListType() {
        return null;
    }
    global Boolean isSObjectListType() {
        return null;
    }
}
}
