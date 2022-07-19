trigger DownTimeTrigger on Down_Time__c (before insert, before update) {
    List<Down_Time__c> downTimeStartDateToBeProcess = new List<Down_Time__c>();
    List<Down_Time__c> downTimeEndDateToBeProcess = new List<Down_Time__c>();
    if(Trigger.isInsert){
        downTimeStartDateToBeProcess.addAll(Trigger.New);
        downTimeEndDateToBeProcess.addAll(Trigger.New);
    }
    
    if(Trigger.isUpdate){
        for(Down_Time__c dt : Trigger.New){
            if(Trigger.oldMap.get(dt.Id).Start_Date__c != dt.Start_Date__c){
                downTimeStartDateToBeProcess.add(dt);
            }
            
            if(Trigger.oldMap.get(dt.Id).End_Date__c != dt.End_Date__c){
                downTimeEndDateToBeProcess.add(dt);
            }
        }
    }
    
    for(Down_Time__c dt : downTimeStartDateToBeProcess){
        Integer offset = UserInfo.getTimezone().getOffset(dt.Start_Date__c);
        dt.Start_Date__c = dt.Start_Date__c.addSeconds(offset/1000);
    }
    
    for(Down_Time__c dt : downTimeEndDateToBeProcess){
        Integer offset = UserInfo.getTimezone().getOffset(dt.Start_Date__c);
        dt.End_Date__c = dt.End_Date__c.addSeconds(offset/1000);
    }
}