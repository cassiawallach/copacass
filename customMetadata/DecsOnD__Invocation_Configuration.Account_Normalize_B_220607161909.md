<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>Account_Normalize_B_220607161909</label>
    <protected>false</protected>
    <values>
        <field>DecsOnD__Create_Log__c</field>
        <value xsi:type="xsd:string">Yes</value>
    </values>
    <values>
        <field>DecsOnD__Event__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>DecsOnD__Is_Test__c</field>
        <value xsi:type="xsd:boolean">false</value>
    </values>
    <values>
        <field>DecsOnD__Params__c</field>
        <value xsi:type="xsd:string">{&quot;whereClause&quot;:&quot;(name like &apos;coastal%&apos; OR name like &apos;Aethereus%&apos; OR name like &apos;Apple%&apos;) AND (not name like &apos;%(CD PARENT)&apos;) AND Type = &apos;ClickDeploy&apos; and ((not parent.Name like &apos;%(CD PARENT)&apos;) or parent.Name = &apos;Unknown (CD PARENT)&apos;) order by createddate&quot;,&quot;batchSize&quot;:&quot;10&quot;}</value>
    </values>
    <values>
        <field>DecsOnD__Policy_Name__c</field>
        <value xsi:type="xsd:string">Normalize</value>
    </values>
    <values>
        <field>DecsOnD__Policy_SObject__c</field>
        <value xsi:type="xsd:string">Account</value>
    </values>
    <values>
        <field>DecsOnD__Policy_UUID__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>DecsOnD__Send_Email__c</field>
        <value xsi:type="xsd:string">On Failure</value>
    </values>
    <values>
        <field>DecsOnD__Status__c</field>
        <value xsi:type="xsd:string">Active</value>
    </values>
    <values>
        <field>DecsOnD__Trigger_SObject_Name__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>DecsOnD__Trigger_SObject__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>DecsOnD__Type__c</field>
        <value xsi:type="xsd:string">Batch</value>
    </values>
</CustomMetadata>
