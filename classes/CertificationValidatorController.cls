public without sharing class CertificationValidatorController {
    @AuraEnabled
    public static List<Academy_Certification_Student__c> fetchAllStudents(String searchKey){
        try {
            return [SELECT Id, Name, Student_Id__c, Contact__c, Contact__r.Name, Contact__r.Email,
                    Contact__r.MailingCity, Contact__r.MailingCountry 
                    FROM Academy_Certification_Student__c
                    WHERE Contact__r.Name = :searchKey OR Contact__r.Email = :searchKey];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Academy_Certification__c> fetchAllCertifications(String stdId){
        try {
            List<Academy_Certification__c> academyCertifications =  [SELECT Id,Certification_Id__c,Certification_Examination__r.Date__c,Expiration_Date__c,Earned_Date__c,
                    Certification_Program__r.Name, Certification_Student__c,Certification_Student__r.Contact__r.EMAIL,
                    Status__c, Student_Name__c FROM Academy_Certification__c
                    WHERE Certification_Student__c = :stdId ORDER BY Expiration_Date__c];

        List<Academy_Certification__c> allCertifications = new List<Academy_Certification__c>();
        Map<String,Academy_Certification__c> contactCertificationProgramKeyWithValidCertificateMap = new Map<String,Academy_Certification__c>();
        Map<String,Academy_Certification__c> contactCertificationProgramKeyWithExpiredCertificateMap = new Map<String,Academy_Certification__c>();
        for(Academy_Certification__c AC : academyCertifications){
            String mapKey = String.valueOf(AC.Certification_Student__r.Contact__c) + String.valueof(AC.Certification_Program__c);
            if(AC.Status__c == 'Valid') {
                contactCertificationProgramKeyWithValidCertificateMap.put(mapKey, AC);
            }
            else if(AC.Status__c == 'Expired' && !contactCertificationProgramKeyWithValidCertificateMap.containsKey(mapKey)) {
                contactCertificationProgramKeyWithExpiredCertificateMap.put(mapKey, AC);
            }
            if(contactCertificationProgramKeyWithValidCertificateMap.containsKey(mapKey) && contactCertificationProgramKeyWithExpiredCertificateMap.containsKey(mapKey)) {
                contactCertificationProgramKeyWithExpiredCertificateMap.remove(mapKey);
            }
        }
        allCertifications.addAll(contactCertificationProgramKeyWithValidCertificateMap.values());
        //allCertifications.addAll(contactCertificationProgramKeyWithExpiredCertificateMap.values());

        return allCertifications;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}