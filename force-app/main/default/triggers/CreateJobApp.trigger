trigger CreateJobApp on Position__c (After insert) {
    
    List<Job_Application__c> lobappList= new List<Job_Application__c>();
    
    for(Position__c objPost: trigger.new){
        if(objPost.Create_Job_Application__c){
            Job_Application__c objJob= new Job_Application__c();
            objJob.Position__c= objPost.Id;
            objJob.Status__c= 'New';
            lobappList.add(objJob);
            
        }
    }
    if(!lobappList.isEmpty()){
        Database.insert(lobappList);
    }
}