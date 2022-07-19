public without sharing class DownTimeController {
    @AuraEnabled(cacheable=true)
    public static ResponseWrapper fetchDownTime(){
        try {
            SObjectField picklistUsingGlobal = SObjectType.Down_Time__c.fields.Region__c.getSObjectField();
            List<String> regionList = new List<String>();
            for(PicklistEntry pl : picklistUsingGlobal.getDescribe().getPicklistValues()){
                regionList.add(pl.getLabel());
            }

            List<Down_Time__c> dtList = new List<Down_Time__c>();
            for(String region : regionList){
                List<Down_Time__c> dt = [SELECT Id, Start_Date__c, End_Date__c, Status__c, Downtime_Status_Notes__c, Region__c, Planned_Impact__c FROM Down_Time__c WHERE Region__c = :region AND End_Date__c >= :DateTime.now() ORDER BY End_Date__c LIMIT 1 ];
                dtList.add(dt.size() > 0 ? dt[0] : new Down_Time__c());
            }

            Map<String, String> valTypeMap = new Map<String, String>{
                'UTC ST' => 'Start_Date__c',
                'Pacific Time' => 'Start_Date__c',
                'Status' => 'Status__c',
                'Planned Impact' => 'Planned_Impact__c',
                'Status Notes' => 'Downtime_Status_Notes__c'
            };
            List<DownTimeWrapper> downTimeWrapList = new List<DownTimeWrapper>();
            for(String val : valTypeMap.keyset()){
                DownTimeWrapper wtWrap = new DownTimeWrapper();
                String fldAPI = valTypeMap.get(val);
                
                if(fldAPI == 'Start_Date__c'){
                    if(val == 'UTC ST'){ //GMT & UTC both are same time
                        wtWrap.region1 = dtList[0].Id == null ? '-' : dtList[0].Start_Date__c.format('MMM dd, yyyy kk:mm', 'GMT') +' <br/> '+ dtList[0].End_Date__c.format('MMM dd, yyyy kk:mm', 'GMT');
                        wtWrap.region2 = dtList[1].Id == null ? '-' : dtList[1].Start_Date__c.format('MMM dd, yyyy kk:mm', 'GMT') +' <br/> '+ dtList[1].End_Date__c.format('MMM dd, yyyy kk:mm', 'GMT');
                        wtWrap.region3 = dtList[2].Id == null ? '-' : dtList[2].Start_Date__c.format('MMM dd, yyyy kk:mm', 'GMT') +' <br/> '+ dtList[2].End_Date__c.format('MMM dd, yyyy kk:mm', 'GMT');
                    }else if(val == 'Pacific Time'){
                        wtWrap.region1 = dtList[0].Id == null ? '-' : dtList[0].Start_Date__c.format('MMM dd, yyyy kk:mm', 'America/Los_Angeles') +' <br/> '+ dtList[0].End_Date__c.format('MMM dd, yyyy kk:mm', 'America/Los_Angeles');
                        wtWrap.region2 = dtList[1].Id == null ? '-' : dtList[1].Start_Date__c.format('MMM dd, yyyy kk:mm', 'America/Los_Angeles') +' <br/> '+ dtList[1].End_Date__c.format('MMM dd, yyyy kk:mm', 'America/Los_Angeles');
                        wtWrap.region3 = dtList[2].Id == null ? '-' : dtList[2].Start_Date__c.format('MMM dd, yyyy kk:mm', 'America/Los_Angeles') +' <br/> '+ dtList[2].End_Date__c.format('MMM dd, yyyy kk:mm', 'America/Los_Angeles');
                    }
                }else{
                    wtWrap.region1 = dtList[0].Id == null ? '-' : ( String.valueOf(dtList[0].get(fldAPI)) == null ? '-' : String.valueOf(dtList[0].get(fldAPI)) );
                    wtWrap.region2 = dtList[1].Id == null ? '-' : ( String.valueOf(dtList[1].get(fldAPI)) == null ? '-' : String.valueOf(dtList[1].get(fldAPI)) );
                    wtWrap.region3 = dtList[2].Id == null ? '-' : ( String.valueOf(dtList[2].get(fldAPI)) == null ? '-' : String.valueOf(dtList[2].get(fldAPI)) );
                }
                wtWrap.valType = val;
                downTimeWrapList.add(wtWrap);
            }

            ResponseWrapper wrap = new ResponseWrapper();
            wrap.downTimeRegions = regionList;
            wrap.downTimeData = downTimeWrapList;
            return wrap;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class ResponseWrapper{
        @AuraEnabled public List<String> downTimeRegions;
        @AuraEnabled public List<DownTimeWrapper> downTimeData;
    }

    public class DownTimeWrapper{
        @AuraEnabled public String valType;
        @AuraEnabled public String region1;
        @AuraEnabled public String region2;
        @AuraEnabled public String region3;
    }
}