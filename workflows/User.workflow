<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Partner_User_Corporate_Email_Verification</fullName>
        <description>Partner User Corporate Email Verification</description>
        <protected>false</protected>
        <recipients>
            <field>Corporate_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>cs@copado.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Community/Partner_User_Corporate_Email_Verification</template>
    </alerts>
    <alerts>
        <fullName>modigie__Modigie_Support_Mail_on_Inactive_Modigie_Admin</fullName>
        <ccEmails>testmail_4Oct@yopmail.com</ccEmails>
        <description>Modigie Support Mail on Inactive Modigie Admin</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>modigie__Modigie_Templates/modigie__Modigie_Support_Mail_on_Inactive_Modigie_Admin</template>
    </alerts>
</Workflow>
