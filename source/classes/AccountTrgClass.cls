public with sharing class AccountTrgClass {
  static public void accountUpdate(List<Account> newt, List<Account> oldt)
  {
     List<Contact> cl=new List<Contact>();
     List<String> sendTo = new List<String>();
    
    for(Account acc : [Select a.Phone, a.Id From Account a where Id IN : newt ])
    {
        
         for(Account con : oldt)
               {
                   if(con.Phone != acc.Phone)
                   {
            
           for(Contact c:[Select c.Phone, c.AccountId ,c.Email From Contact c where c.AccountId=:acc.Id])
           {
               
              sendTo.add(c.Email);
              c.Phone=acc.Phone;                                       
              cl.add(c);
           }
     }
        
    }
      
}
    if(cl.size()>0)
    {
    update cl;
    SendEmail.send(sendTo);
   
    }
  }
    
}