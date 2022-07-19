public without sharing class CommunityFloatingBannerController {
    @AuraEnabled(cacheable=true)
    public static List<Community_Announcement__c> fetchFloatingBanner(){
        return [SELECT Id, Message__c FROM Community_Announcement__c WHERE RecordType.DeveloperName = 'Marquee' AND Start_Date__c <= TODAY AND End_Date__c >= TODAY ORDER BY Start_Date__c];
    }
}