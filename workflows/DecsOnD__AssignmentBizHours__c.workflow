<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>DecsOnD__Set_User_Hidden_Field</fullName>
        <description>Update User_Unique_Hiddn field, used to ensure we only have one record per user</description>
        <field>DecsOnD__User_Unique_Hidden__c</field>
        <formula>DecsOnD__User__c</formula>
        <name>Set User Hidden Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>true</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DecsOnD__Set_User_Unique_Hidden_Field</fullName>
        <description>Update User Unique Hidden field, used to ensure we only have one record per user</description>
        <field>DecsOnD__User_Unique_Hidden__c</field>
        <formula>DecsOnD__User__c</formula>
        <name>Set User Unique Hidden Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>true</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>DecsOnD__Set User Unique Hidden field</fullName>
        <actions>
            <name>DecsOnD__Set_User_Unique_Hidden_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>DecsOnD__Set unique user field</fullName>
        <actions>
            <name>DecsOnD__Set_User_Hidden_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
