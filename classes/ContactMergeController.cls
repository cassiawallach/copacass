public without sharing class ContactMergeController {
    @AuraEnabled
    public static void mergeContactData(String oldContactId, String oldUserId, String newContactId, String newUserId) {
        try{
            migrateLearningTracAssignments(oldContactId, oldUserId, newContactId, newUserId);
            migrateLearningPlanAssignments(oldContactId, oldUserId, newContactId, newUserId);
            migrateLearningPlanSectionAssignments(oldContactId, oldUserId, newContactId, newUserId);
            migrateLearningAssignments(oldContactId, oldUserId, newContactId, newUserId);
            migrateSharedLearningAssignments(oldContactId, oldUserId, newContactId, newUserId);
            migrateAchievementAssignments(oldContactId, oldUserId, newContactId, newUserId);
            migrateAcademyCertification(oldContactId, oldUserId, newContactId, newUserId);
            migrateAcademyCertificationStudent(oldContactId, oldUserId, newContactId, newUserId);
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    private static void migrateLearningTracAssignments(String oldContactId, String oldUserId, String newContactId, String newUserId){
        try{
            List<redwing__Training_Track_Assignment__c> recordToBeUpdate = [select id, redwing__Contact__c, redwing__User__c, OwnerId from redwing__Training_Track_Assignment__c where redwing__User__c = :oldUserId];
            for(redwing__Training_Track_Assignment__c rec : recordToBeUpdate){
                rec.redwing__Contact__c = newContactId;
                rec.redwing__User__c = newUserId;
            }
            update recordToBeUpdate;
        }catch(Exception e){
            throw new AuraHandledException('Failing Migration of Learning Trac Assignments : '+e.getMessage());
        }
    }

    private static void migrateLearningPlanAssignments(String oldContactId, String oldUserId, String newContactId, String newUserId){
        try{
            List<redwing__Training_Plan_Assignment__c> recordToBeUpdate = [select id, redwing__Contact__c, redwing__User__c, OwnerId from redwing__Training_Plan_Assignment__c where redwing__User__c = :oldUserId];
            for(redwing__Training_Plan_Assignment__c rec : recordToBeUpdate){
                rec.redwing__Contact__c = newContactId;
                rec.redwing__User__c = newUserId;
            }
            update recordToBeUpdate;
        }catch(Exception e){
            throw new AuraHandledException('Failing Migration of Learning Plan Assignments : '+e.getMessage());
        }
    }

    private static void migrateLearningPlanSectionAssignments(String oldContactId, String oldUserId, String newContactId, String newUserId){
        try{
            List<redwing__Training_Plan_Section_Assignment__c> recordToBeUpdate = [select id, redwing__User__c, OwnerId from redwing__Training_Plan_Section_Assignment__c  where redwing__User__c = :oldUserId];
            for(redwing__Training_Plan_Section_Assignment__c rec : recordToBeUpdate){
                rec.redwing__User__c = newUserId;
            }
            update recordToBeUpdate;
        }catch(Exception e){
            throw new AuraHandledException('Failing Migration of Learning Plan Section Assignments : '+e.getMessage());
        }
    }

    private static void migrateLearningAssignments(String oldContactId, String oldUserId, String newContactId, String newUserId){
        try{
            List<redwing__Learning_Assignment__c> recordToBeUpdate = [select id, redwing__Contact__c, redwing__User__c, OwnerId from redwing__Learning_Assignment__c where redwing__User__c = :oldUserId];
            for(redwing__Learning_Assignment__c rec : recordToBeUpdate){
                rec.redwing__Contact__c = newContactId;
                rec.redwing__User__c = newUserId;
            }
            update recordToBeUpdate;
        }catch(Exception e){
            throw new AuraHandledException('Failing Migration of Learning Assignments : '+e.getMessage());
        }
    }

    private static void migrateSharedLearningAssignments(String oldContactId, String oldUserId, String newContactId, String newUserId){
        try{
            List<redwing__Shared_Learning_Assignment__c> recordToBeUpdate = [select id, redwing__Contact__c, redwing__User__c, OwnerId from redwing__Shared_Learning_Assignment__c where redwing__User__c = :oldUserId];
            for(redwing__Shared_Learning_Assignment__c rec : recordToBeUpdate){
                rec.redwing__Contact__c = newContactId;
                rec.redwing__User__c = newUserId;
            }
            update recordToBeUpdate;
        }catch(Exception e){
            throw new AuraHandledException('Failing Migration of Shared Learning Assignments : '+e.getMessage());
        }
    }

    private static void migrateAchievementAssignments(String oldContactId, String oldUserId, String newContactId, String newUserId){
        try{
            List<redwing__Achievement_Assignment__c> recordToBeUpdate = [select id, redwing__Contact__c, redwing__User__c, OwnerId from redwing__Achievement_Assignment__c where redwing__User__c = :oldUserId];
            for(redwing__Achievement_Assignment__c rec : recordToBeUpdate){
                rec.redwing__Contact__c = newContactId;
                rec.redwing__User__c = newUserId;
            }
            update recordToBeUpdate;
        }catch(Exception e){
            throw new AuraHandledException('Failing Migration of Achievement Assignments : '+e.getMessage());
        }
    }

    private static void migrateAcademyCertification(String oldContactId, String oldUserId, String newContactId, String newUserId){
        try{
            List<Academy_Certification__c> recordToBeUpdate = [select id, OwnerId from Academy_Certification__c where Certification_Student__r.Contact__c = :oldContactId];
            for(Academy_Certification__c rec : recordToBeUpdate){
                rec.OwnerId = newUserId;
            }
            update recordToBeUpdate;
        }catch(Exception e){
            throw new AuraHandledException('Failing Migration of Academy Certification : '+e.getMessage());
        }
    }

    private static void migrateAcademyCertificationStudent(String oldContactId, String oldUserId, String newContactId, String newUserId){
        try{
            List<Academy_Certification_Student__c> recordToBeUpdate = [select id, Contact__c from Academy_Certification_Student__c where Contact__c = :oldContactId];
            for(Academy_Certification_Student__c rec : recordToBeUpdate){
                rec.Contact__c = newContactId;
            }
            update recordToBeUpdate;
        }catch(Exception e){
            throw new AuraHandledException('Failing Migration of Academy Certification Student : '+e.getMessage());
        }
    }
}