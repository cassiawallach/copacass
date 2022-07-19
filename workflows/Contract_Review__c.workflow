<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Contract_Review_Closure_Alert</fullName>
        <description>Contract Review Closure Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_AE__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sales@copado.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Contract_Review_Closure_Template</template>
    </alerts>
    <alerts>
        <fullName>Contract_Review_submission_alert</fullName>
        <ccEmails>legal@copado.com</ccEmails>
        <description>Contract Review submission alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Contract_Review_Viewers</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <field>Assigned_AE__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sales@copado.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Contract_Review_Submission_Template</template>
    </alerts>
</Workflow>
