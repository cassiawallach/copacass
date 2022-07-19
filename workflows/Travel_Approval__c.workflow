<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notify_owner_of_approval</fullName>
        <description>Notify owner of approval</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Emails/Travel_Approval_Request_Approved</template>
    </alerts>
    <alerts>
        <fullName>Notify_owner_of_rejection</fullName>
        <description>Notify owner of rejection</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Emails/Travel_Approval_Request_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Approved_Status</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Approved Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_New_Request_Status</fullName>
        <field>Status__c</field>
        <literalValue>New Request</literalValue>
        <name>Update New Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Pending_Status</fullName>
        <field>Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Update Pending Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Rejected_Status</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Rejected Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
