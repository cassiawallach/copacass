@isTest
public class TestOpportunityChangeTrigger {
    @isTest static void testCreateOppLossProduct(){
        Test.enableChangeDataCapture();
        List<BusinessHours> bhs = [select id from BusinessHours where IsDefault=true];
        Account acc = TestDataFactory.createAccount('My Account', 'EUR');
        acc.Working_Business_Hours__c = bhs[0].Id;
        insert acc;    
        Contact con = TestDataFactory.createContact(acc.Id, 'MyTestContact');
        insert con;             
        Id RecdTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('New').getRecordTypeId(); 
        Opportunity o = TestDataFactory.createOpportunity(acc, 'My Opp', 'New Customer');
        o.StageName = 'Marketing Qualification';
        o.Main_Problems__c = 'Problem';
        o.closeDate = Date.today();
        o.AccountId=acc.Id;
        o.RecordTypeId = RecdTypeId;
        insert o; 
        Id usrId = userinfo.getUserId();
        test.starttest();        
        
        SBQQ__Quote__c quote = TestDataFactory.createCPQuote(o);
        quote.SBQQ__SalesRep__c = usrId;
        quote.SBQQ__PrimaryContact__c=con.Id;
        
        quote.SBQQ__Primary__c = false;
        insert quote;
        
        SBQQ__Quote__c primaryQuote = TestDataFactory.createCPQuote(o);
        primaryQuote.SBQQ__SalesRep__c = usrId;
        primaryQuote.SBQQ__PrimaryContact__c=con.Id;
       
        insert primaryQuote;    
        
        Id pricebookId = Test.getStandardPricebookId();
        Pricebook2 p2 = TestDataFactory.createPricebook();
        insert p2;
       
        Product2 prod = TestDataFactory.createProduct('My Test','Licenses',null);
        insert prod;
        
        Product2 prod1 = TestDataFactory.createProduct('My Test1','Licenses',null);
        insert prod1;
        
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id=pricebookId, Product2Id=prod.Id, UnitPrice=5, IsActive=true,CurrencyIsoCode='EUR');
        insert standardPrice;
        
        SBQQ__QuoteLine__c qline = new SBQQ__QuoteLine__c();
                qline.SBQQ__Quote__c = primaryQuote.Id;
                qline.SBQQ__StartDate__c = system.today();
                qline.SBQQ__EndDate__c = system.today().addYears(1);
                qline.SBQQ__Product__c = prod.Id;                         
                qline.SBQQ__ListPrice__c = 5;
                qline.SBQQ__Quantity__c = 1;
                qline.SBQQ__OriginalPrice__c = 5;
                qline.SBQQ__ProrateMultiplier__c= 12;
                qline.SBQQ__SegmentIndex__c= 1;
                qline.SBQQ__Description__c= 'test';
                qline.SBQQ__SubscriptionPricing__c = 'Fixed Price';
                qline.SBQQ__DefaultSubscriptionTerm__c = 1;                
                qline.Proposal_Segment_Index__c = 'Year  1';
                qline.Proposal_Segment_Label__c = 'Year  1 - Licenses & Support';
                qline.SBQQ__PricebookEntryId__c = standardPrice.Id;
                qline.SBQQ__ProductSubscriptionType__c = 'Renewable';
                qline.SBQQ__SegmentKey__c = '1602758020922';
                qline.SBQQ__SegmentLabel__c = 'Year  1';
                qline.SBQQ__SubscriptionBase__c = 'List';
                qline.SBQQ__SubscriptionCategory__c = 'Licenses';
                qline.SBQQ__SubscriptionType__c = 'Renewable';
                qline.SBQQ__Uplift__c = 0;
                qline.SBQQ__PricingMethod__c = 'List';
                qline.SBQQ__NetPrice__c = 5;
                qline.SBQQ__Discount__c = 0;               
         insert qline;
         
         SBQQ__QuoteLine__c qline1 = new SBQQ__QuoteLine__c();
                qline1.SBQQ__Quote__c = quote.Id;
                qline1.SBQQ__StartDate__c = system.today();
                qline1.SBQQ__EndDate__c = system.today().addYears(1);
                qline1.SBQQ__Product__c = prod1.Id;                         
                qline1.SBQQ__ListPrice__c = 5;
                qline1.SBQQ__Quantity__c = 1;
                qline1.SBQQ__OriginalPrice__c = 5;
                qline1.SBQQ__ProrateMultiplier__c= 12;
                qline1.SBQQ__SegmentIndex__c= 1;
                qline1.SBQQ__Description__c= 'test';
                qline1.SBQQ__SubscriptionPricing__c = 'Fixed Price';
                qline1.SBQQ__DefaultSubscriptionTerm__c = 1;
                qline1.Proposal_Segment_Index__c = 'Year  1';
                qline1.Proposal_Segment_Label__c = 'Year  1 - Licenses & Support';
                qline1.SBQQ__PricebookEntryId__c = standardPrice.Id;
                qline1.SBQQ__ProductSubscriptionType__c = 'Renewable';
                qline1.SBQQ__SegmentKey__c = '1602758020922';
                qline1.SBQQ__SegmentLabel__c = 'Year  1';
                qline1.SBQQ__SubscriptionBase__c = 'List';
                qline1.SBQQ__SubscriptionCategory__c = 'Licenses';
                qline1.SBQQ__SubscriptionType__c = 'Renewable';
                qline1.SBQQ__Uplift__c = 0;
                qline1.SBQQ__PricingMethod__c = 'List';
                qline1.SBQQ__NetPrice__c = 5;
                qline1.SBQQ__Discount__c = 0;               
         insert qline1;         
        test.stoptest();
           
        Test.getEventBus().deliver();
        Opportunity[] oppList = [SELECT Id,StageName FROM Opportunity where Id=: o.Id];
        for (Opportunity opp : oppList){
            opp.StageName = 'Closed Won';          
            update opp;          
            Test.getEventBus().deliver();
        }
        o.StageName = 'Marketing Qualification';
        update o;
        Opportunity_Loss_Product__c[] OppLossProductList = [SELECT Id FROM Opportunity_Loss_Product__c];
        System.assertEquals(1, OppLossProductList.size(),'The change event trigger did not create the record.');
        for (Opportunity opp : oppList){
            opp.StageName = 'Closed Lost';  
            opp.Lost_Reason_Detail__c = 'Test';  
            opp.Lost_Reason_Detail_picklist__c = 'Budget' ;
            opp.Lost_Reason__c = 'Economical';      
            update opp;          
            Test.getEventBus().deliver();
        }
        Opportunity_Loss_Product__c[] OppLossProductList1 = [SELECT Id FROM Opportunity_Loss_Product__c];
        System.assertEquals(2, OppLossProductList1.size(),'The change event trigger did not create the record.');
    }
}