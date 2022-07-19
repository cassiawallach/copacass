/*
2022-03-21  Scott M.    Updating to comment out dead method US-0029612


*/

trigger CopadoUserStoryTrigger on copado__User_Story__c (after insert, after update, before delete, after undelete,before update) {
    
    if(Trigger.isBefore){
        /* US-0018634 fnunez Development team needs to stop updating the parent user story points based on children user story points
        if(Trigger.isDelete){
            CopadoUserStoryTriggerHandler.prepareDataForEstimationRollup(Trigger.old);
            CopadoUserStoryTriggerHandler.removeUserStoryPoints(Trigger.old);
        }
        else*/
        if(Trigger.isUpdate){
            //CopadoUserStoryTriggerHandler.PrepareData(Trigger.New); Commenting out line per US-0029612
            // US-0020289 Removed method since this email alert is no longer required. 
            //CopadoUserStoryTriggerHandler.OnUserStoryStatusChangeNotifyByEmail(Trigger.oldMap,Trigger.NewMap);
            
        }
    } 
    /*else if (Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
            CopadoUserStoryTriggerHandler.prepareDataForEstimationRollup(Trigger.new);
            CopadoUserStoryTriggerHandler.rollupUserStoryPoints();
        }
    }*/
}