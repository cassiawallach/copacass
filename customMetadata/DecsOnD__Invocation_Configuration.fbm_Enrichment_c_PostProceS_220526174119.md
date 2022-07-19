<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>fbm_Enrichment_c_PostProceS_220526174119</label>
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
        <value xsi:type="xsd:string">{&quot;whereClause&quot;:&quot;fbm__Status__c = &apos;Completed&apos; AND fbm__Contact__r.Account.Type = &apos;ClickDeploy&apos; AND fbm__Contact__r.Account.FunnelBeam_Enrichment_Status__c != &apos;Requested&apos; AND fbm__Person_Company_Name__c != null AND (fbm__Contact__r.Account.Name like &apos;ClickDeploy - %&apos; OR fbm__Contact__r.Account.Name = &apos;Gmail&apos;)&quot;,&quot;batchSize&quot;:&quot;25&quot;,&quot;cronExp&quot;:&quot;0 45 * * * ?&quot;}</value>
    </values>
    <values>
        <field>DecsOnD__Policy_Name__c</field>
        <value xsi:type="xsd:string">PostProcessing</value>
    </values>
    <values>
        <field>DecsOnD__Policy_SObject__c</field>
        <value xsi:type="xsd:string">fbm__Enrichment__c</value>
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
        <value xsi:type="xsd:string">Scheduled</value>
    </values>
</CustomMetadata>
