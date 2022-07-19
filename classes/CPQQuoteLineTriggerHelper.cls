public class CPQQuoteLineTriggerHelper {
    
    private static Map<Id, Decimal> mapQuoteIdAndUplift = new Map<Id, Decimal>();

    public static void prepareDataBefore(List<SObject> records) {
        Set<Id> quoteIds = new Set<Id>();
        for (SObject so : records) {
            SBQQ__QuoteLine__c qLine = (SBQQ__QuoteLine__c)so;
            if(qLine.SBQQ__Quote__c != Null && qLine.SBQQ__SubscriptionPricing__c != null && qLine.PS_Uplift__c == null){
                quoteIds.add(qLine.SBQQ__Quote__c);
            }            
        }
        for(SBQQ__Quote__c quoteObj :[SELECT Id,SBQQ__Opportunity2__c, SBQQ__Opportunity2__r.PS_Uplift__c FROM SBQQ__Quote__c where Id IN:quoteIds AND SBQQ__Type__c = 'Renewal']){
            if(quoteObj != Null){                     
                mapQuoteIdAndUplift.put(quoteObj.id, quoteObj.SBQQ__Opportunity2__r.PS_Uplift__c);              
            }            
        }
    }
    //This method updates Is License field on QuoteLine.
    public static void setIsLicense(SBQQ__QuoteLine__c newQuoteLine,SBQQ__QuoteLine__c oldQuoteLine){        
        if(oldQuoteLine != null && newQuoteLine.SBQQ__ProductFamily__c !=null && (newQuoteLine.SBQQ__ProductFamily__c == 'Licenses' || newQuoteLine.SBQQ__ProductFamily__c == 'Premier Support') && newQuoteLine.SBQQ__ProductFamily__c != oldQuoteLine.SBQQ__ProductFamily__c){
            newQuoteLine.PS_Is_Licence__c = true;     
        }
        else if(oldQuoteLine == null && newQuoteLine.SBQQ__ProductFamily__c !=null && (newQuoteLine.SBQQ__ProductFamily__c == 'Licenses' || newQuoteLine.SBQQ__ProductFamily__c == 'Premier Support')) {
            newQuoteLine.PS_Is_Licence__c = true;             
        }
    }
    //This method updates Net Unit Price field on QuoteLine.
    public static void calcaluteNetUnitPrice(SBQQ__QuoteLine__c newQuoteLine,SBQQ__QuoteLine__c oldQuoteLine){
        if(oldQuoteLine != null && newQuoteLine.SBQQ__NetPrice__c !=null && newQuoteLine.SBQQ__ProrateMultiplier__c != null && (oldQuoteLine.SBQQ__NetPrice__c != newQuoteLine.SBQQ__NetPrice__c || oldQuoteLine.SBQQ__ProrateMultiplier__c != newQuoteLine.SBQQ__ProrateMultiplier__c)) {         
            newQuoteLine.Net_Unit_Price__c = newQuoteLine.SBQQ__NetPrice__c / newQuoteLine.SBQQ__ProrateMultiplier__c;          
        }
        else if(oldQuoteLine == null && newQuoteLine.SBQQ__NetPrice__c !=null && newQuoteLine.SBQQ__ProrateMultiplier__c != null ) {           
            newQuoteLine.Net_Unit_Price__c = newQuoteLine.SBQQ__NetPrice__c / newQuoteLine.SBQQ__ProrateMultiplier__c;            
        }
    }
    //This method updates Uplift field on QuoteLine.
    public static void setUpliftfromOpportunity(SBQQ__QuoteLine__c newQuoteLine){      
        if(!mapQuoteIdAndUplift.IsEmpty() && mapQuoteIdAndUplift != null && mapQuoteIdAndUplift.containsKey(newQuoteLine.SBQQ__Quote__c)) {         
            newQuoteLine.PS_Uplift__c =  mapQuoteIdAndUplift.get(newQuoteLine.SBQQ__Quote__c);               
        }  
    }
}