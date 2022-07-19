/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class DecisionTableConfig {
    global DecisionTableConfig() {

    }
    global static DecsOnD.DecisionTableConfig fromJSON(String dtConfigJSON) {
        return null;
    }
    global DecsOnD.DecisionTableConfig.ColumnConfig getColumn(String columnName) {
        return null;
    }
    global Map<String,DecsOnD.DecisionTableConfig.ColumnConfig> getColumnsAsMap() {
        return null;
    }
    global List<DecsOnD.DecisionTableConfig.ColumnConfig> getColumns() {
        return null;
    }
    global Map<String,DecsOnD.DecisionTableConfig.SectionConfig> getSectionsAsMap() {
        return null;
    }
    global static Map<String,DecsOnD.DecisionTableConfig> mapFromJSON(String dtConfigsJSON) {
        return null;
    }
    global static String mapToJSON(Map<String,DecsOnD.DecisionTableConfig> dtConfigs, Boolean pretty) {
        return null;
    }
    global String toJSON(Boolean pretty) {
        return null;
    }
global class ColumnConfig {
    @AuraEnabled
    global String data_type;
    @AuraEnabled
    global String format;
    @AuraEnabled
    global Boolean hidden;
    @AuraEnabled
    global String label;
    @AuraEnabled
    global String name;
    @AuraEnabled
    global String required;
    @AuraEnabled
    global String width;
}
global class PicklistValue {
}
global class SectionConfig {
    @AuraEnabled
    global Boolean action;
    @AuraEnabled
    global List<DecsOnD.DecisionTableConfig.ColumnConfig> columns;
    @AuraEnabled
    global String description;
    @AuraEnabled
    global Boolean hidden;
    @AuraEnabled
    global String label;
    @AuraEnabled
    global String name;
    global SectionConfig() {

    }
}
}
