trigger AccountTrg on Account (after update)
{
  /*  Account a=[Select a.Phone, a.Id, a.AccountNumber, (Select AccountId, Phone From Contacts) From Account a 
               where a.Id=:trigger.newMap.keySet()];
       Contact[] c=a.Contacts;
      for(Contact cn:c)
    {
          cn.Phone=a.Phone;
    }
    update c;
   //AccountTrgClass.accountUpdate(Trigger.New, Trigger.Old);*/
   Map<id,Account> accountUpdateMap = new Map<id,Account>();
   Map<id,Contact> contactUpdateMap = new Map<id,Contact>();
   // Contact[] c;
    for(Account acc : [Select a.Phone, a.Id, a.AccountNumber From Account a 
               where a.Id=:trigger.newMap.keySet()])
    {
       accountUpdateMap.put(acc.id,acc);
     //  c=acc.Contacts;
       //  contactUpdateMap.put(acc.id, c);
    }
   List<Contact> cl=new List<Contact>();
     for(Contact c:[Select AccountId, Phone From Contact where AccountId=:Trigger.new])
     {
        // contactUpdateMap.put(c.AccountId,c);
         if(accountUpdateMap.containsKey(c.AccountId))
         {
             c.Phone=accountUpdateMap.get(c.AccountId).Phone;
             cl.add(c);
         }
     }
    
   
    
    update cl;
    
    
    
    
}