public class AccountHandler {
    public static account insertNewAccount(string accName){
        if(accName!='')
        {
            try{
                Account acc=new Account(Name=accName);
                insert acc;
                system.debug('Record Inserted');
                return acc;   
            }
            catch(exception e)
            {
               return null;
            }
        }
        else
            return null;
    }

}