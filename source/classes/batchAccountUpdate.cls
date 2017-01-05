global class batchAccountUpdate implements Database.Batchable<sObject> {
    global final String query;
    global batchAccountUpdate() 
    {
        query ='SELECT Id,Name FROM Account';
    }
    
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        return Database.getQueryLocator(query);
    }
    
    
    global void execute(Database.BatchableContext BC, List<Account> scope) {
        for(Account a : scope)
        {
            a.Name = a.Name + 'Updated';            
        }
        update scope;
    }   
    
    global void finish(Database.BatchableContext BC) {
    }
}