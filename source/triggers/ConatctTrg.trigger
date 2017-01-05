trigger ConatctTrg on Contact (after insert) 
{
    Map<ID,Contact> contactUpdatedMap =new Map<ID,Contact>();
    for(Contact c: [Select Id,Phone,AccountId from Contact where Id IN: Trigger.New])
    {
        contactUpdatedMap.put(c.Id, c);
    }
   
    Map<ID,Account> accountMap =new Map<ID,Account>();
    for(Account a:[Select Id,Phone from Account])
    {
        accountMap.put(a.id, a);
    }
    
  for(Contact c1:contactUpdatedMap.values())
  {
       if(accountMap.containsKey(c1.AccountId ))
      c1.Phone=accountMap.get(c1.AccountId).Phone;
  }
    update contactUpdatedMap.values();
    System.debug(contactUpdatedMap.values());
}