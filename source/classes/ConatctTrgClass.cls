public class ConatctTrgClass 
{
  public static void contactCreated(List<Contact> newT)
    {
       // set<id> AccountID = trigger.newMap.keySet();
     List<Contact> cl=new List<Contact>();  
    List<String> sendTo = new List<String>();
     
     for(Contact c:[Select c.Phone, c.AccountId,c.Email From Contact c where Id IN :newT])
    {
        
        sendTo.add(c.Email);
      
         for(Account acc : [Select a.Phone, a.Id From Account a where Id =:c.AccountId ])
           {               
               c.Phone=acc.Phone;                          
               cl.add(c);
           }  
    }
     update cl;
      SendEmail.send(sendTo);  
    
    }
}