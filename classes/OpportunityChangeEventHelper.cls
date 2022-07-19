/*This class will run in asynchronous mode and creates Opportunity Loss Product records 
when an Opportunity is Closed Won/Lost. It is called from OpportunityChangeTrigger*/

public class OpportunityChangeEventHelper {

    public void createOppLossProduct(set<Id> oppIds) {
       
        Map<Id,Opportunity> oppIdAndOpp = new Map<Id,Opportunity>([Select Id, IsWon, StageName, CurrencyIsoCode from Opportunity where 
                                                                   Id IN: oppIds AND IsClosed = true]);
        
        Map<Id,Map<Id,Decimal>> oppIdAndProductIdAndNetTotal = new Map<Id,Map<Id,Decimal>>();
        if(oppIdAndOpp != null && !oppIdAndOpp.IsEmpty()) {
            List<Opportunity_Loss_Product__c> oppLossProductList = [Select Id from Opportunity_Loss_Product__c where
                                                                        Opportunity__c IN:oppIds];
            if(oppLossProductList != null && !oppLossProductList.IsEmpty()) {
                 try {           
                        delete oppLossProductList;
                    
                 } catch(Exception e) {
                     System.debug(e);
                 }              
            }
            Set<Id> productIds = new set<Id>();
            List<SBQQ__QuoteLine__c> quoteList = [select Id, SBQQ__Product__c, SBQQ__Quote__c, SBQQ__NetTotal__c, SBQQ__Quote__r.SBQQ__Primary__c,SBQQ__Quote__r.SBQQ__Opportunity2__c  
                                                    from SBQQ__QuoteLine__c where SBQQ__Quote__r.SBQQ__Opportunity2__c IN: oppIds ORDER BY SBQQ__NetTotal__c];
            if(quoteList.size() >0 && !quoteList.isEmpty()) {
                for(SBQQ__QuoteLine__c quoteLine : quoteList) {
                    if(quoteLine.SBQQ__Quote__r.SBQQ__Primary__c == true) {
                        productIds.add(quoteLine.SBQQ__Product__c);            
                    } 
                }
            }
            
            for(Opportunity opp : oppIdAndOpp.values()) {             
                if(opp.IsWon == true) {                                     
                    if(quoteList.size() >0 && !quoteList.isEmpty()) {
                        for(SBQQ__QuoteLine__c quoteLine : quoteList) {                             
                                      
                            if(quoteLine.SBQQ__Quote__r.SBQQ__Primary__c == false && !productIds.contains(quoteLine.SBQQ__Product__c)) {                                                                                    
                                if(oppIdAndProductIdAndNetTotal.containsKey(opp.id)){
                                    Map<Id,decimal> productIdAndNetTotal = oppIdAndProductIdAndNetTotal.get(opp.id) ;                    
                                    productIdAndNetTotal.put(quoteLine.SBQQ__Product__c,quoteLine.SBQQ__NetTotal__c);
                                    oppIdAndProductIdAndNetTotal.put(opp.Id, productIdAndNetTotal);
                                }else{
                                    Map<Id,decimal> productIdAndNetTotal = new Map<Id,decimal>() ;                    
                                    productIdAndNetTotal.put(quoteLine.SBQQ__Product__c,quoteLine.SBQQ__NetTotal__c);
                                    oppIdAndProductIdAndNetTotal.put(opp.Id, productIdAndNetTotal); 
                                }                                
                            }
                        }   
                    }                  
                }
                else if(opp.StageName == 'Closed Suspend' || opp.StageName == 'Closed Lost' ||opp.StageName == 'Closed Duplicate') {
               
                    if(quoteList.size() >0 && !quoteList.isEmpty()) {                    
                        for(SBQQ__QuoteLine__c quoteLine : quoteList) {                        
                            if(oppIdAndProductIdAndNetTotal.containsKey(opp.id)){                                
                                Map<Id,decimal> productIdAndNetTotal = oppIdAndProductIdAndNetTotal.get(opp.id) ;                    
                                productIdAndNetTotal.put(quoteLine.SBQQ__Product__c,quoteLine.SBQQ__NetTotal__c);
                                oppIdAndProductIdAndNetTotal.put(opp.Id, productIdAndNetTotal);                                
                            }else{                               
                                Map<Id,decimal> productIdAndNetTotal = new Map<Id,decimal>() ;                    
                                productIdAndNetTotal.put(quoteLine.SBQQ__Product__c,quoteLine.SBQQ__NetTotal__c);
                                oppIdAndProductIdAndNetTotal.put(opp.Id, productIdAndNetTotal);                                
                            }
                        }                           
                    }
                }
            }
        }
        system.debug('oppIdAndProductIdAndNetTotal---------->>'+oppIdAndProductIdAndNetTotal);
        List<Opportunity_Loss_Product__c> insertOppLossProduct = new List<Opportunity_Loss_Product__c>();
        if(oppIdAndOpp != null && !oppIdAndOpp.IsEmpty()) {
            for(Id i : oppIdAndOpp.keyset()) {
                Map<Id,decimal> productIdAndAmount = oppIdAndProductIdAndNetTotal.get(i);
                for(Id productId : productIdAndAmount.keyset()){                    
                    Opportunity_Loss_Product__c oppLossProd = new Opportunity_Loss_Product__c(); 
                    oppLossProd.Opportunity__c = i;
                    oppLossProd.Product__c = productId;
                    oppLossProd.Net_Total__c = productIdAndAmount.get(productId);
                    oppLossProd.CurrencyISOCode = oppIdAndOpp.get(i).CurrencyIsoCode;
                    insertOppLossProduct.add(oppLossProd);                    
                }
            }
        }
        
        if(insertOppLossProduct != null && !insertOppLossProduct.IsEmpty()) {
            try {           
                   insert insertOppLossProduct;
                    
             } catch(Exception e) {
                 System.debug(e);
             }             
        }
    }
}