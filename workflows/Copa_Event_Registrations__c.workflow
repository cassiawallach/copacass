<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Copa_Event_Successful_Registration_Email</fullName>
        <description>Copa Event Successful Registration Email</description>
        <protected>false</protected>
        <recipients>
            <field>User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>cs@copado.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Community/Copa_Event_Successful_Registration_Email</template>
    </alerts>
</Workflow>
