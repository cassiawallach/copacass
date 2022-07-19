public class OpportunityLineItemTriggerHelper { 

     private static Map<Id, Product2> prodIdAndProduct = new Map<Id, Product2>();
     
     public static void prepareDataBefore(List<SObject> records) {
         set<Id> prodIds = new set<Id>();
         for (SObject so : records) {
             OpportunityLineItem oli = (OpportunityLineItem)so;
             if(oli.Product2Id != Null){
                 prodIds.add(oli.Product2Id);
             }            
         }
         if(prodIds != null && prodIds.size()>0) {
             for(Product2 prodObj : [select Id, Engagement_Type__c, Family from Product2 where Id IN:prodIds]) {
                  if(prodObj != Null){
                      prodIdAndProduct.put(prodObj.id, prodObj);
                  }
             }
         }
     }
     //This method will update Engagement Type and Family field from Product's Engagement Type and Family
     public static void updateOlifromProduct(OpportunityLineItem newOli){
         if(newOli.Product2Id != null && prodIdAndProduct.containsKey(newOli.Product2Id)) {
             newOli.Engagement_Type__c = prodIdAndProduct.get(newOli.Product2Id).Engagement_Type__c != null ? prodIdAndProduct.get(newOli.Product2Id).Engagement_Type__c : null ;
             newOli.Product_Family__c = prodIdAndProduct.get(newOli.Product2Id).Family != null ? prodIdAndProduct.get(newOli.Product2Id).Family : null;
         }
     }
}