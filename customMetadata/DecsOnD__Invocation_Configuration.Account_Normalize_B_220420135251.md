<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>Account_Normalize_B_220420135251</label>
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
        <value xsi:type="xsd:string">{&quot;whereClause&quot;:&quot;Type = &apos;ClickDeploy&apos; and DecsOnD__Assignment_Status__c in (null, &apos;Failed&apos;, &apos;Unknown&apos;) and ParentId = null and (not Name like &apos;%(CD PARENT)&apos; ) and chargebeeapps__CB_Id__c = null order by Owner.Alias&quot;,&quot;batchSize&quot;:&quot;10&quot;}</value>
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
