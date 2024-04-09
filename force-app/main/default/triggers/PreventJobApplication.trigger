trigger PreventJobApplication on Job_Application__c (before insert) {
    
    Set<Id> posiSet= new Set<Id>();
    for(Job_Application__c objJob: trigger.new){
        if(objJob.Position__c != null){
            posiSet.add(objJob.Position__c);
        }
    }
    Map<Id, Position__c> posMap= new Map<Id, Position__c>();
    if(!posiSet.isEmpty()){
        for(Position__c objPos : [Select Id,(Select Id from Job_Applications__r) from Position__c where Id IN : posiSet]){
            posMap.put(objPos.Id, objPos);
        }
    }
    if(!posMap.isEmpty()){
        for(Job_Application__c objJob: trigger.new){
            if(posMap.containsKey(objJob.Position__c)){
                if(posMap.get(objJob.Position__c).Job_Applications__r.size()>=1){
                    objJob.addError('Only one Job Application is required...!!');
                }
                
            }
        }
    }
}