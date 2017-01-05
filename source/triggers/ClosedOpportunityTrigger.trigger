trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    list<Task> taskList=new list<Task>();
    for(Opportunity opp:[select Id,StageName from Opportunity where id=:trigger.new and StageName= 'Closed Won' ]){
        
       taskList.add(new Task( Subject ='Follow Up Test Task',whatId=opp.Id));
        
    }
    if(taskList.size()>0)
    {
        insert taskList;
    }

}