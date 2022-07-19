//This class is called from SetContractToExpiredReplacement trigger
public class ContractHelper {
private static list<Contract> updateContractList = new list<Contract>();
private static Set<string> accountIdSet = new set<string>();
private static Map<string,string> accountNameMap = new map<string,string>();
     //This method updates Renewal Quote and Renewal opportunity's Renewal ACV field from Contract's Order ACV field.
    public static void UpdateRenewalQuote(set<Id> contractIds) { 
        Id recordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Renewal').getRecordTypeId();
        List<SBQQ__Quote__c> updateList = new List<SBQQ__Quote__c>();
        List<Opportunity> updateOpptyList = new List<Opportunity>();
        
        for(Contract con : [Select Id, Order_ACV__c, kuga_sub__RenewalOpportunity__c, kuga_sub__RenewalOpportunity__r.SBQQ__PrimaryQuote__c, 
                                    kuga_sub__RenewalOpportunity__r.SBQQ__PrimaryQuote__r.Renewal_ACV__c, kuga_sub__RenewalOpportunity__r.isClosed,
                                    kuga_sub__RenewalOpportunity__r.SBQQ__PrimaryQuote__r.ACV__c,
                                    kuga_sub__RenewalOpportunity__r.Renewal_ACV__c, 
                                    kuga_sub__RenewalOpportunity__r.SBQQ__PrimaryQuote__r.SBQQ__Status__c
                                    from Contract where Id IN: contractIds AND
                                    kuga_sub__RenewalOpportunity__r.RecordTypeId=:recordTypeId AND
                                    kuga_sub__RenewalOpportunity__r.SBQQ__PrimaryQuote__c != null]) {            
          
              if(con.Order_ACV__c != null) {                   
                  if(con.kuga_sub__RenewalOpportunity__r.SBQQ__PrimaryQuote__r.SBQQ__Status__c == 'Draft') {
                      SBQQ__Quote__c quote = new SBQQ__Quote__c(Id=con.kuga_sub__RenewalOpportunity__r.SBQQ__PrimaryQuote__c);                 
                      quote.Renewal_ACV__c = con.Order_ACV__c;      
                      updateList.add(quote);  
                      if(con.kuga_sub__RenewalOpportunity__r.isClosed == false) {                  
                          Opportunity opp = new Opportunity(Id=con.kuga_sub__RenewalOpportunity__c);
                          opp.Renewal_ACV__c = con.Order_ACV__c; 
                          //system.debug('****************'+opp.SBQQ__PrimaryQuote__r.ACV__c+opp.Renewal_ACV__c+opp.Quote_ACV__c);
                          /*if(opp.SBQQ__PrimaryQuote__r.ACV__c != null) {
                              opp.Incremental_ACV__c = opp.SBQQ__PrimaryQuote__r.ACV__c - opp.Renewal_ACV__c; 
                          } else {
                              opp.Incremental_ACV__c = 0 - opp.Renewal_ACV__c; 
                          }  */                           
                          updateOpptyList.add(opp);
                      } 
                  }              
              }                         
        }        
        if(updateList.size()>0 && !updateList.isEmpty()) {
             try {           
                update updateList;                    
             } catch(Exception e) {
                    System.debug(e);
             }               
        }  
        
        if(updateOpptyList.size()>0 && !updateOpptyList.isEmpty()) {
             try {           
                update updateOpptyList;                    
             } catch(Exception e) {
                    System.debug(e);
             }               
        }      
    }
    //This method used for insert operations
    public static void populateFieldsOnInsert (list<Contract> newContractList){
        for(Contract cont : newContractList){
            accountIdSet.add(cont.AccountId);
        }
        for(Account acc : [Select Id,Name FROM Account Where Id =:accountIdSet]){
            if(acc != Null){
            	accountNameMap.put(acc.Id,acc.Name);   
            }
        }        
        //Update Contract End Date with latest Subscription End Date and Contract Name
		for(Contract cont : newContractList){
            if(cont.kuga_sub__SubscriptionEndDate__c != Null ){
                cont.EndDate = cont.kuga_sub__SubscriptionEndDate__c; 
            }
            if(cont.kuga_sub__SubscriptionStartDate__c != Null ){
               cont.StartDate = cont.kuga_sub__SubscriptionStartDate__c; 
            }
            if(cont.AccountId != Null && accountNameMap.containsKey(cont.AccountId)){
               cont.Name =  accountNameMap.get(cont.AccountId) +'-'+ cont.ContractNumber;
            }
            
        }
                
    }
     //This method used for update operations
    public static void populateFieldsOnUpdate (map<Id,Contract> oldMap, map<Id,Contract> newMap){
        for(Contract cont :  newMap.values()){
            accountIdSet.add(cont.AccountId);
        }
        for(Account acc : [Select Id,Name FROM Account Where Id =:accountIdSet]){
            if(acc != Null){
            	accountNameMap.put(acc.Id,acc.Name);   
            }
        }       
       //Update Contract End Date with latest Subscription End Date and Contract Name
        for(Contract cont : newMap.values()){
            if(oldMap.get(cont.Id).kuga_sub__SubscriptionEndDate__c  != cont.kuga_sub__SubscriptionEndDate__c && cont.kuga_sub__SubscriptionEndDate__c != Null ){
                cont.EndDate = cont.kuga_sub__SubscriptionEndDate__c;   
            }
            if((oldMap.get(cont.Id).kuga_sub__SubscriptionStartDate__c   !=  cont.kuga_sub__SubscriptionStartDate__c || oldMap.get(cont.Id).kuga_sub__SubscriptionStartDate__c != cont.StartDate) && cont.kuga_sub__SubscriptionStartDate__c  != Null){
                cont.StartDate = cont.kuga_sub__SubscriptionStartDate__c;
            }
            if(oldMap.get(cont.Id).AccountId  != cont.AccountId && cont.AccountId != Null && accountNameMap.containsKey(cont.AccountId) ){
                cont.Name =  accountNameMap.get(cont.AccountId) +'-'+ cont.ContractNumber;
                
            }
        }
        
    }
     
}