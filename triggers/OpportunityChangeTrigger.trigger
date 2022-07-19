trigger OpportunityChangeTrigger on OpportunityChangeEvent (after insert) {
    
    Set<Id> oppIds = new Set<Id>();
    for(OpportunityChangeEvent event : trigger.new) {
        EventBus.ChangeEventHeader header = event.ChangeEventHeader;      
        if(header.changeType == 'UPDATE' && event.IsClosed == true) { 
            List<Id> recordIds = event.ChangeEventHeader.getRecordIds();
            oppIds.addAll(recordIds);
        } 
    }
    if(oppIds != null && !oppIds.isEmpty()) {
        OpportunityChangeEventHelper helper = new OpportunityChangeEventHelper();
        helper.createOppLossProduct(oppIds);
    }
}