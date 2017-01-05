@isTest
public class AccountTrgTestFactory {
  public static Account createAccount()
    {
        Account acc=new Account(Name='test',Phone='45445');
        //insert acc;
        Database.SaveResult db=database.insert(acc);
        if(db.isSuccess())
        {
            system.debug('acc'+acc);
            return acc;
        }
        else
            return null;
    }
    public static Contact createContact(Account acc)
    {
        Contact con=new Contact(AccountId=acc.Id,LastName='joko',MobilePhone='6656565');
        //insert con;
         Database.SaveResult db1=database.insert(con);
        if(db1.isSuccess())
             {
            system.debug('cona.phone'+con.Phone);
            return con;
        }
        else
            return null;
       // return con;
    }
    
}