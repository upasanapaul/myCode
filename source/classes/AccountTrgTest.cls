@isTest
public class AccountTrgTest {
  static testmethod void updateAccountTest()
    {  test.startTest();
        Account acc;
        Contact con;
        acc=AccountTrgTestFactory.createAccount();
    
        con=AccountTrgTestFactory.createContact(acc);
        system.debug('acc.id'+acc.Id);
         system.debug('contact.acc.id'+con.AccountId);
        acc.Phone='56589';
        update acc;
  
        system.debug('acc.phone'+acc.Phone);
     contact co=[select Phone from contact where AccountId=:acc.Id limit 1];
       system.debug('co.Id'+co.Id+' co.phone'+co.Phone);
     system.debug('con.Id'+con.Id+' con.phone'+con.Phone);
     if(co.Phone==acc.Phone)
     {
     
    system.assertEquals(co.Phone, acc.Phone);
     }
        test.stopTest();
    }
}