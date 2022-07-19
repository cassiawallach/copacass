/**
 * Created by Anjali Chaudhary on 25/03/2022.
 */

trigger CPQ_QuoteLineTrigger on SBQQ__QuoteLine__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    System.debug('@@@ Entering Quote Trigger @@@');
    TriggerFactory.createHandler(SBQQ__QuoteLine__c.sObjectType);
}