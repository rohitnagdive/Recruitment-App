trigger PositionTrigger on Position__c (before insert) {

    if(Trigger.isInsert){
        if(Trigger.isBefore){
            PositionTriggerHandler.populateDateAndPay(trigger.new);
        }
        if(Trigger.isAfter){
            
        }
    }
}