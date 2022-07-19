/****************
 * 
 * 
 * 2022-03-10   Mayank Mishra   US-0029093 - Updated to reference new method for updateOrderFields
 */

public class KugamonOrderTriggerHandler implements ITrigger {
    public KugamonOrderTriggerHandler(){ 
    }
    
    public void bulkBefore(){
        if(Trigger.isBefore && Trigger.isInsert){
            KugamonOrderTriggerHelper.prepareDataForOrderFields(Trigger.new);  
        }       
    }
    
    public void bulkAfter(){ 
        if(Trigger.isAfter && Trigger.isUpdate){
            KugamonOrderTriggerHelper.createQuoteLineOnRenewalOpportuntiy(Trigger.New);
            //KugamonOrderTriggerHelper.updateContract(Trigger.New[0].Id);
        }        
    }
    
    public void beforeInsert(SObject so){
        kugo2p__SalesOrder__c newOrder = (kugo2p__SalesOrder__c)so;
        system.debug('beforeInsert-newOrder: ' + newOrder);
        KugamonOrderTriggerHelper.updateOrderFields(newOrder); 
        
    }
    
    public void beforeUpdate(SObject oldSo, SObject so){
        kugo2p__SalesOrder__c newOrder = (kugo2p__SalesOrder__c)so;
        system.debug('beforeUpdate-newOrder: ' + newOrder);                           
        system.debug('beforeUpdate-newOrder.kugo2p__CustomerPONumber__c' + newOrder.kugo2p__CustomerPONumber__c);   
        KugamonOrderTriggerHelper.updateContractNumber(newOrder);     
    }
    
    public void beforeDelete(SObject so){
    }
    
    public void afterInsert(SObject so){  
        kugo2p__SalesOrder__c newOrder = (kugo2p__SalesOrder__c)so;
        system.debug('afterInsert-newOrder: '+newOrder);                           
        system.debug('afterInsert-newOrder.kugo2p__CustomerPONumber__c: ' + newOrder.kugo2p__CustomerPONumber__c); 
    }
    
    public void afterUpdate(SObject oldSo, SObject so){     
        kugo2p__SalesOrder__c NewOrderValue = (kugo2p__SalesOrder__c) so;
        kugo2p__SalesOrder__c OldOrderValue =  (kugo2p__SalesOrder__c) oldSo;
        system.debug('afterUpdate-OldOrderValue: ' + OldOrderValue);                           
        system.debug('afterUpdate-OldOrderValue.kugo2p__CustomerPONumber__c: ' + OldOrderValue.kugo2p__CustomerPONumber__c);         
        system.debug('afterUpdate-NewOrderValue: ' + NewOrderValue);                           
        system.debug('afterUpdate-NewOrderValue.kugo2p__CustomerPONumber__c: ' + NewOrderValue.kugo2p__CustomerPONumber__c);         
        
        if(!test.isRunningTest()) {
            if(NewOrderValue.kugo2p__RecordStatus__c != OldOrderValue.kugo2p__RecordStatus__c && NewOrderValue.kugo2p__RecordStatus__c == 'Released') {            
                KugamonOrderTriggerHelper.updateContract(NewOrderValue.Id);
            }    
        } else{
            KugamonOrderTriggerHelper.updateContract(NewOrderValue.Id);
        }
    }
    
    public void afterDelete(SObject so){
    }
    
    public void andFinally(){
      //  KugamonOrderTriggerHelper.createQuoteLineOnRenewal();        
    }
}