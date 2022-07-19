<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>TopBoxWG__TopBox_PreNote</fullName>
        <description>TopBox - PreNote</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TopBoxWG__TopBox_Emails/TopBoxWG__TopBox_PreNote</template>
    </alerts>
    <fieldUpdates>
        <fullName>Correct_Sandbox_email_format</fullName>
        <field>Email</field>
        <formula>SUBSTITUTE(SUBSTITUTE(Email, &quot;@example.com&quot;, &quot;&quot;), &quot;=&quot;, &quot;@&quot;)</formula>
        <name>Correct Sandbox email format</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DecsOnD__Set_Email_Domain</fullName>
        <description>Set the Decisions on Demand Email Domain field from the Email</description>
        <field>DecsOnD__Email_Domain_DecsOnD__c</field>
        <formula>SUBSTITUTE(Email, LEFT(Email, FIND(&quot;@&quot;, Email)), NULL)</formula>
        <name>Set Email Domain</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>true</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Outreach_Engagement_Score_Field_Update</fullName>
        <description>Rule: If “Email Opt Out” field equals True, then Engagement Score field should be set to “Do Not Contact”</description>
        <field>Engagement_Score__c</field>
        <literalValue>Do Not Contact</literalValue>
        <name>Outreach Engagement Score Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <outboundMessages>
        <fullName>Copado_Outbound_Message</fullName>
        <apiVersion>52.0</apiVersion>
        <endpointUrl>https://INVALIDhttps://clients.topboxtech.com/api/contact/add/?QuestionnaireId=025c21d7-55c0-9049-5af3-b34f6bb4f39e</endpointUrl>
        <fields>AccountId</fields>
        <fields>Email</fields>
        <fields>Id</fields>
        <fields>TopBoxWG__Contact_Questionnaire_Type__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>topbox.integration@copado.com</integrationUser>
        <name>Copado Outbound Message</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>TopBoxWG__Relationship_Outbound_Message</fullName>
        <apiVersion>45.0</apiVersion>
        <endpointUrl>https://clients.topboxtech.com/api/contact/add/?QuestionnaireId=5a75ad23-f9a0-42bb-e246-8e09fdda0247</endpointUrl>
        <fields>AccountId</fields>
        <fields>Email</fields>
        <fields>Id</fields>
        <fields>TopBoxWG__Contact_Questionnaire_Type__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>pfernandez@copa.do</integrationUser>
        <name>Relationship Outbound Message</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>DecsOnD__Set Email Domain</fullName>
        <actions>
            <name>DecsOnD__Set_Email_Domain</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Set the Decisions on Demand Email Domain field from the Email</description>
        <formula>ISNEW() || ISCHANGED( Email )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Outreach Engagement Score Field Update</fullName>
        <actions>
            <name>Outreach_Engagement_Score_Field_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.HasOptedOutOfEmail</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>***DEACTIVATED April 2022 per User Story US-0029564 - Scott M***

Rule: If “Email Opt Out” field equals True, then Engagement Score field should be set to “Do Not Contact”</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Sandbox Email</fullName>
        <actions>
            <name>Correct_Sandbox_email_format</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Email</field>
            <operation>contains</operation>
            <value>@example.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Email</field>
            <operation>contains</operation>
            <value>=</value>
        </criteriaItems>
        <description>***DEACTIVATED March 2022 per User Story US-0029563 - Scott M***

This should be an explicit update in a sandbox for a specific test otherwise we risk notifications going to customers or partners.

Replace email string of sandbox with real email</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>TopBox - Scheduler - InitialPROD</fullName>
        <active>false</active>
        <formula>AND( TopBoxWG__TopBox_Initial_Send_Date__c &gt;= NOW(), TopBoxWG__TopBox_Send_Survey__c, OR( ISPICKVAL(Account.Type,&apos;Customer&apos;), NOT(ISBLANK(Account.Customer_Success_Manager__c)) ), NOT(ISBLANK(TEXT(Copado_Role__c))) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Copado_Outbound_Message</name>
                <type>OutboundMessage</type>
            </actions>
            <offsetFromField>Contact.TopBoxWG__TopBox_Initial_Send_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>TopBox - Scheduler - OnboardingPROD</fullName>
        <active>false</active>
        <formula>AND( TopBoxWG__TopBox_Onboarding_Send_Date__c &gt;= NOW(), TopBoxWG__TopBox_Send_Survey__c, OR( ISPICKVAL(Account.Type,&apos;Customer&apos;), NOT(ISBLANK(Account.Customer_Success_Manager__c))  ), NOT(ISBLANK(TEXT(Copado_Role__c)))   )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Copado_Outbound_Message</name>
                <type>OutboundMessage</type>
            </actions>
            <offsetFromField>Contact.TopBoxWG__TopBox_Onboarding_Send_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>TopBox - Scheduler - OngoingPROD</fullName>
        <active>false</active>
        <formula>AND( TopBoxWG__TopBox_Ongoing_Relationship_Send_Date__c &gt;= NOW(), TopBoxWG__TopBox_Send_Survey__c, OR( ISPICKVAL(Account.Type,&apos;Customer&apos;), NOT(ISBLANK(Account.Customer_Success_Manager__c)) ), NOT(ISBLANK(TEXT(Copado_Role__c))) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Copado_Outbound_Message</name>
                <type>OutboundMessage</type>
            </actions>
            <offsetFromField>Contact.TopBoxWG__TopBox_Ongoing_Relationship_Send_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>TopBox - Scheduler - RenewalPROD</fullName>
        <active>false</active>
        <formula>AND( TopBoxWG__TopBox_Next_Renewal_Send_Date__c &gt;= NOW(), TopBoxWG__TopBox_Send_Survey__c, OR( ISPICKVAL(Account.Type,&apos;Customer&apos;), NOT(ISBLANK(Account.Customer_Success_Manager__c)) ), NOT(ISBLANK(TEXT(Copado_Role__c))) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Copado_Outbound_Message</name>
                <type>OutboundMessage</type>
            </actions>
            <offsetFromField>Contact.TopBoxWG__TopBox_Next_Renewal_Send_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>TopBoxWG__TopBox - PreNote - Initial</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Contact.TopBoxWG__TopBox_Initial_PreNote_OK__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TopBoxWG__TopBox - PreNote - Onboarding</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Contact.TopBoxWG__TopBox_Onboarding_PreNote_OK__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TopBoxWG__TopBox - PreNote - Ongoing</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Contact.TopBoxWG__TopBox_Ongoing_PreNote_OK__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TopBoxWG__TopBox - PreNote - Renewal</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Contact.TopBoxWG__TopBox_Renewal_PreNote_OK__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TopBoxWG__TopBox - Scheduler - Initial</fullName>
        <active>false</active>
        <formula>AND( TopBoxWG__TopBox_Initial_Send_Date__c &gt;= NOW(), TopBoxWG__TopBox_Send_Survey__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TopBoxWG__TopBox - Scheduler - Onboarding</fullName>
        <active>false</active>
        <formula>AND( TopBoxWG__TopBox_Onboarding_Send_Date__c &gt;= NOW(), TopBoxWG__TopBox_Send_Survey__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TopBoxWG__TopBox - Scheduler - Ongoing</fullName>
        <active>false</active>
        <formula>AND( TopBoxWG__TopBox_Ongoing_Relationship_Send_Date__c &gt;= NOW(), TopBoxWG__TopBox_Send_Survey__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TopBoxWG__TopBox - Scheduler - Renewal</fullName>
        <active>false</active>
        <formula>AND( TopBoxWG__TopBox_Next_Renewal_Send_Date__c &gt;= NOW(), TopBoxWG__TopBox_Send_Survey__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
