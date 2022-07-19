public class CPQQuoteLineTriggerHandler implements ITrigger {

    public CPQQuoteLineTriggerHandler(){}
    
    public void bulkBefore(){  
        if(Trigger.isBefore && Trigger.isInsert){
            CPQQuoteLineTriggerHelper.prepareDataBefore(Trigger.New);
        }   
    }
    
    public void bulkAfter(){      
    }
        
    public void beforeInsert(SObject so){ 
        SBQQ__QuoteLine__c newQuoteLine = (SBQQ__QuoteLine__c) so;       
        CPQQuoteLineTriggerHelper.setIsLicense(newQuoteLine,null);
        CPQQuoteLineTriggerHelper.calcaluteNetUnitPrice(newQuoteLine,null);   
        CPQQuoteLineTriggerHelper.setUpliftfromOpportunity(newQuoteLine);   
    }
    
    public void beforeUpdate(SObject oldSo, SObject so){  
        SBQQ__QuoteLine__c oldQuoteLine = (SBQQ__QuoteLine__c) oldSo;
        SBQQ__QuoteLine__c newQuoteLine = (SBQQ__QuoteLine__c) so;       
        CPQQuoteLineTriggerHelper.setIsLicense(newQuoteLine,oldQuoteLine);
        CPQQuoteLineTriggerHelper.calcaluteNetUnitPrice(newQuoteLine,oldQuoteLine);      
    }
    
    public void beforeDelete(SObject so){}
    
    public void afterInsert(SObject so){}
    
    public void afterUpdate(SObject oldSo, SObject so){}
    
    public void afterDelete(SObject so){}
    
    public void andFinally(){            
    }
}