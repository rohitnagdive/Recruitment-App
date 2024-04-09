public class PositionTriggerHandler {

    public static void populateDateAndPay(List<Position__c> posList){
        for(Position__c objPos: posList){
            if(objPos.Status__c== 'New Position' && objPos.Open_Date__c== null && objPos.Max_Pay__c== null && objPos.Min_Pay__c== null){
                objPos.Open_Date__c= system.today();
                objPos.Min_Pay__c= 10000;
                objPos.Max_Pay__c= 15000;
            }
        }
    }
}