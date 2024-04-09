trigger TotalJobApplication on Job_Application__c (after insert,after update,after undelete,after delete) {
    
    Set<Id> posiSet= new Set<Id>();
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete && Trigger.isAfter){
       
        for(Job_Application__c objJob : trigger.new){
            if(objJob.Position__c != null){
                posiSet.add(objJob.Position__c);
            }
        }
    }
    if(Trigger.isUpdate || Trigger.isdelete && Trigger.isAfter){
        for(Job_Application__c objJob : trigger.old){
            if(objJob.Position__c != null){
                posiSet.add(objJob.Position__c);
            }
        }
    }
    Map<Id, Position__c> posMap= new Map<Id, Position__c>();
    if(!posiSet.isEmpty()){
        for(Position__c objPos: [Select Id, Total_Job_Application__c, (Select Id from Job_Applications__r) from Position__c where Id IN: posiSet]){
            objPos.Total_Job_Application__c= String.valueOf(objPos.Job_Applications__r.Size());
            posMap.put(objPos.Id, objPos);
            
        }
    }
    if(!posMap.isEmpty()){
        Database.update(posMap.values(),false);
    }
}