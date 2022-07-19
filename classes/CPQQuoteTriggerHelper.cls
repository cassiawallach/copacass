public class CPQQuoteTriggerHelper {
    
    private static Boolean alreadyRunOnce = false;
    private static Set<Id> lstQuoteIds = new Set<Id>();
    private static Set<String> salesRepIdSet = new Set<String>();
    private static Map<String, String> userMap = new Map<String, String>();
    private static Map<Id, SBQQ__Quote__c> mapQuote = new Map<Id, SBQQ__Quote__c>();
    private static Map<Id, List<SBQQ__Subscription__c>> contractSubscriptionMap = new Map<Id, List<SBQQ__Subscription__c>>();
    private static Map<String,String> opportunityRecordtypeMap = new Map<String,String>();
    private static Map<String,Agreement__c> agreementMap = new Map<String,Agreement__c>();
    public static void prepareDataBefore(List<SObject> records) {
        Set<Id> contractIds = new Set<Id>();
        
        for (SObject so : records) {
            SBQQ__Quote__c q = (SBQQ__Quote__c)so;
            if(q.SBQQ__SalesRep__c != Null){
                salesRepIdSet.add(q.SBQQ__SalesRep__c);
            }
            contractIds.add(q.SBQQ__MasterContract__c);
            contractSubscriptionMap.put(q.SBQQ__MasterContract__c, new List<SBQQ__Subscription__c>());
        }
        for(SBQQ__Subscription__c s : getCPQSubscriptions(contractIds)){
            List<SBQQ__Subscription__c> tmp = contractSubscriptionMap.get(s.SBQQ__Contract__c);
            tmp.add(s);
            contractSubscriptionMap.put(s.SBQQ__Contract__c, tmp);
        }
        for(User userObj :[SELECT Id, Name, ManagerId FROM User where isactive = true AND Id IN:salesRepIdSet]){
            if(userObj!= Null){
                userMap.put(userObj.id, userObj.ManagerId);
            }
            
        }
        system.debug('userMap'+userMap);
        
    }
    public static void prepareDataAfter(List<SObject> records) {
        system.debug('Test 1 @');
        Set<Id> oppIds = new Set<Id>();
        for (SObject so : records) {
            SBQQ__Quote__c q = (SBQQ__Quote__c)so;
            oppIds.add(q.SBQQ__Opportunity2__c);
            system.debug('oppIds: '+oppIds);
            if (q.SBQQ__Primary__c && string.isNotEmpty(q.SBQQ__Opportunity2__c)) {
                lstQuoteIds.add(q.Id);
            }
            
        }
        system.debug('result size: '+lstQuoteIds.size());
        if(lstQuoteIds.size()>0){
            mapQuote = new CPQQuoteSelector().GetQuoteById(lstQuoteIds);
            system.debug('mapQuote size: '+mapQuote.keySet().size());
        }
        /*for(Opportunity opp :[Select Id,RecordTypeId From Opportunity Where Id IN:oppIds]){
            opportunityRecordtypeMap.put(opp.Id, opp.RecordTypeId);
        }*/
        for(Agreement__c agree :[Select Id,Opportunity__c  From Agreement__c Where Opportunity__c IN:oppIds]){
            system.debug('Agreement: '+agree);
            if(agree!= Null){
                agreementMap.put(agree.Opportunity__c, agree);
            }
            
        }
        system.debug('agreementMap'+ agreementMap);
        
    }
    
    public static void updateQuoteOwnerId(SBQQ__Quote__c quote){         
        if(!alreadyRunOnce) {
            alreadyRunOnce = true;           
            if(quote.SBQQ__SalesRep__c != null && quote.OwnerId != Null && quote.SBQQ__SalesRep__c != quote.OwnerId){                
                quote.OwnerId = quote.SBQQ__SalesRep__c;
            }                        
        }
    }
    //update opportunity related agreement on the basis of quote status
    public static void updateAgreementStatus(){
        list<Agreement__c> agrrementList = new List<Agreement__c>();
        for (SBQQ__Quote__c q : mapQuote.values()) {
            Agreement__c  agreObj = new Agreement__c ();
            if(q.SBQQ__Status__c == 'Presented' && q.Agreement_Sent_with_Quote__c == true && agreementMap.containsKey(q.SBQQ__Opportunity2__c)){
                agreObj.Status__c = 'Pending Signature';
                agreObj.Opportunity__c = agreementMap.get(q.SBQQ__Opportunity2__c).Opportunity__c;
                agreObj.Id = agreementMap.get(q.SBQQ__Opportunity2__c).Id;
                agrrementList.add(agreObj);
            }else if(q.SBQQ__Status__c == 'Accepted' && agreementMap.containsKey(q.SBQQ__Opportunity2__c)){
                agreObj.Status__c = 'Executed';
                agreObj.Opportunity__c = agreementMap.get(q.SBQQ__Opportunity2__c).Opportunity__c;
                agreObj.Id = agreementMap.get(q.SBQQ__Opportunity2__c).Id;
                agrrementList.add(agreObj);
            }else if(q.SBQQ__Status__c == 'Approved' && q.Agreement_Sent_with_Quote__c == true && agreementMap.containsKey(q.SBQQ__Opportunity2__c)){
                agreObj.Status__c = 'Approved';
                agreObj.Opportunity__c = agreementMap.get(q.SBQQ__Opportunity2__c).Opportunity__c;
                agreObj.Id = agreementMap.get(q.SBQQ__Opportunity2__c).Id;
                agrrementList.add(agreObj);
            }
        }
        if(!agrrementList.isEmpty()){
            Update agrrementList;
        }
        
    }
    
    //2022-04-08    Scott M.    Updated to map quote ACV(vs. 1st yr ACV) to oppty ACV and enhanced logic to not update if values are equal
    public static void setAcvTcvOnOpportunities(){
        
        List<Opportunity> oppList = new List<opportunity>(); 
        Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>();
        for (SBQQ__Quote__c q : mapQuote.values()) {
            Boolean hasUpdates = false;
            Opportunity opp = new Opportunity();
            opp.id = q.SBQQ__Opportunity2__c;
            if (q.SBQQ__Primary__c == true){
                if (q.SBQQ__Opportunity2__c != null && q.ACV__c != null && q.SBQQ__Opportunity2__r.ACV__c != q.ACV__c){
                    opp.ACV__c = q.ACV__c;
                    hasUpdates = true;
                }
                if (q.SBQQ__Opportunity2__c != null && q.TCV__c != null && q.SBQQ__Opportunity2__r.TCV__c != q.TCV__c){
                    opp.TCV__c = q.TCV__c;
                    hasUpdates = true;
                }
                //This will update Renewal opportunity Expansion ACV from Primary Quote for US-0029392.
                if (q.SBQQ__Type__c == 'Renewal' && q.Add_On_ACV__c != null && q.SBQQ__Opportunity2__c != null && q.SBQQ__Opportunity2__r.Expansion_ACV__c != q.Add_On_ACV__c) {                
                    opp.Expansion_ACV__c = q.Add_On_ACV__c;
                    hasUpdates = true;         
                }   
            }
            //only add opp to oppList if there is at least 1 update
            if (hasUpdates = true){
                oppMap.put(opp.id,opp);
            }
        }
        if (!oppMap.isEmpty()){
            Update oppMap.values();
            system.debug('oppMap Values: ' + oppMap.values());
        }
        /* for (SBQQ__Quote__c q : mapQuote.values()) {
            
            Decimal dTotalACV = 0;
            Decimal dTotalTCV = 0;
            Decimal dTotalMRR = 0;
            for (SBQQ__QuoteLine__c ql : q.SBQQ__LineItems__r) {
            if((ql.SBQQ__ProductFamily__c=='Licenses' || ql.SBQQ__ProductFamily__c=='Premier Support') && ql.SBQQ__ProrateMultiplier__c!=null && ql.SBQQ__DefaultSubscriptionTerm__c!=null){
            dTotalTCV += ql.SBQQ__PackageTotal__c;
            dTotalMRR += (ql.SBQQ__PackageTotal__c/q.Number_of_Months__c);
            if ((ql.SBQQ__DefaultSubscriptionTerm__c * ql.SBQQ__ProrateMultiplier__c) < 12) {
            dTotalACV += ql.SBQQ__PackageTotal__c;
            }
            else {
            dTotalACV += ql.SBQQ__PackageTotal__c * (12 / (ql.SBQQ__DefaultSubscriptionTerm__c * ql.SBQQ__ProrateMultiplier__c));
            }    
            }
            }
            
            // Add the opp to the list to update
            lstOpps.add(new Opportunity(Id=q.SBQQ__Opportunity2__c, TCV__c=dTotalTCV, ACV__c=dTotalACV, MRR__c=dTotalMRR));
            }
            // Update the opps
            if (lstOpps.size() > 0) {
            system.debug(' Updating opportunities: '+lstOpps.size());
            // SG 2019-12-23: Deprecating code tranistining logic to price rules - need the above code for code coverage
            //update lstOpps;
            }*/
                    
    }
    
    public static void setNumberOfMonths(SBQQ__Quote__c quote){
        if(quote.SBQQ__StartDate__c!=null && quote.SBQQ__EndDate__c!=null){
            Decimal proration = CPQMigrationHelper.calculateProRate(quote.SBQQ__StartDate__c, quote.SBQQ__EndDate__c);
            quote.Number_of_Months__c = proration;
        }

    }
    /*public static void updateOpportunity(SBQQ__Quote__c quote){
        List<Opportunity> oppList = new List<Opportunity>();
        User us = [Select Id From User Where Name ='Rosie Milem' Limit 1];
        for(contract contObj : [Select Opportunity__c from Contract where AccountId =: quote.SBQQ__Account__c and Opportunity__r.owner.isactive = false AND Status ='Activated' AND Opportunity__c != Null]){
            Opportunity opp = new Opportunity();
            opp.ownerId = [Select Id From User Where Name ='Rosie Milem' Limit 1].id;
            opp.id = contObj.Opportunity__c;
            oppList.add(opp);
        }
        if(oppList.Size() > 0){
            Update oppList;
        }
        
    }*/
    public static void setRemainingLicenseTCV(SBQQ__Quote__c oldQuote, SBQQ__Quote__c newQuote){
        Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Renewal').getRecordTypeId();
        if(newQuote.SBQQ__Opportunity2__r.recordtypeId == devRecordTypeId ){
            newQuote.SBQQ__Type__c = 'Renewal';
        }
        if(newQuote.Approval_Manager__c == Null && userMap.containsKey(newQuote.SBQQ__SalesRep__c) && userMap.get(newQuote.SBQQ__SalesRep__c) != null){
            newQuote.Approval_Manager__c = userMap.get(newQuote.SBQQ__SalesRep__c);
        }
        
        // if is new quote and not been ammended, enter if statement.
        if(oldQuote!=null){
            system.debug('oldQuote: not null');
            if (!datesHaveChanged(oldQuote, newQuote)) return;
        }
        if (!isAmendmentQuote(newQuote)) return;
        Decimal proration = CPQMigrationHelper.calculateProRate(newQuote.SBQQ__StartDate__c, newQuote.SBQQ__EndDate__c);
        //get license subscription items
        List<SBQQ__Subscription__c> subscriptions = contractSubscriptionMap.get(newQuote.SBQQ__MasterContract__c);
        if(subscriptions == null)return;
        
        //calculate license value per month for subscriptions
        Decimal monthlyValue = 0;
        Decimal fullValue = 0;
        for(SBQQ__Subscription__c sub : subscriptions){
            fullValue += sub.SBQQ__NetPrice__c * sub.SBQQ__Quantity__c;
            monthlyValue += (sub.SBQQ__NetPrice__c * sub.SBQQ__Quantity__c)/sub.SBQQ__ProrateMultiplier__c;
        }
        
        //calculate remaining TCV
        Decimal remainingTCV = monthlyValue * proration;
        newQuote.Remaining_License_TCV__c = remainingTCV;
        newQuote.Current_License_TCV__c = fullValue;
        
    }
    
    private static List<SBQQ__Subscription__c> getCPQSubscriptions(Set<Id> cids){
        List<SBQQ__Subscription__c> subs = [SELECT Id, Name, SBQQ__ListPrice__c, SBQQ__NetPrice__c, SBQQ__Quantity__c, SBQQ__ProrateMultiplier__c, SBQQ__Contract__c
                                            FROM SBQQ__Subscription__c
                                            WHERE SBQQ__Contract__c IN :cids
                                            AND SBQQ__Product__r.Family = 'Licenses'];
        return subs;
    }
    private static Boolean isAmendmentQuote(SBQQ__Quote__c quote){
        system.debug('Entering isAmendmentQuote: quote = '+quote);
        if(quote.SBQQ__Type__c == 'Amendment' && quote.SBQQ__MasterContract__c != null){
            system.debug('isAmendmentQuote: return true;');
            return true;
        } else {
            system.debug('isAmendmentQuote: return false;');
            return false;
        }
    }
    private static Boolean datesHaveChanged(SBQQ__Quote__c oldQuote, SBQQ__Quote__c newQuote){
        system.debug('### Entering datesHaveChanged: oldQuote='+oldQuote+'; newQuote='+newQuote);
        if(newQuote.SBQQ__StartDate__c != oldQuote.SBQQ__StartDate__c || newQuote.SBQQ__EndDate__c != oldQuote.SBQQ__EndDate__c){
            system.debug('datesHaveChanged: return true;');
            return true;
        } else{
            system.debug('datesHaveChanged: return false;');
            return false;
        }
    }
    //This method will update "T&C'S is Blank" field to True if "T&Cs" is blank else False
    public static void setFlagTandCs(SBQQ__Quote__c quote){
      
        if(quote.T_Cs__c == null){     
            quote.T_C_S_is_Blank__c = 'True';
        } else {         
            quote.T_C_S_is_Blank__c = 'False';
        }
    }
}