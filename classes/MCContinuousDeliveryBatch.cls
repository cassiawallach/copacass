public class MCContinuousDeliveryBatch implements Database.Batchable<SObject>, Database.AllowsCallouts, Database.Stateful {
    private List<copado__Promotion__c> promotions;

    public MCContinuousDeliveryBatch(List<copado__Promotion__c> promotions) {
        this.promotions = promotions;
    }

    public Database.QueryLocator start(Database.BatchableContext batchContext) {
        String query = 'SELECT Id, copado__Back_Promotion__c, copado__Destination_Environment__c, copado__Source_Environment__c, copado__Release__c, copado__Release__r.copado__Project__c, copado__Release__r.copado__Project__r.copado__Deployment_Flow__c, copado__Project__c, copado__Project__r.copado__Deployment_Flow__c FROM copado__Promotion__c WHERE Id IN: promotions';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext batchContext, List<copado__Promotion__c> promotions) {
        for (copado__Promotion__c promotion : promotions) {
            List<copado.PromoteAction.Request> requests = new List<copado.PromoteAction.Request>();
            copado.PromoteAction.Request request = new copado.PromoteAction.Request();
            request.promotionId = promotion.Id;
            request.executePromotion = true;
            request.executeDeployment = true;
            request.deploymentDryRun = false;
            requests.add(request);
            copado.PromoteAction.promote(requests);
        }
    }

    public void finish(Database.BatchableContext batchContext) {
        // empty
    }
}