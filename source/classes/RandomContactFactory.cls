public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(integer noc, string lname){
        list<Contact> c=new list<contact>();
     //String FirstNameStr = 'Test';
      for(integer i=0;i<noc;i++ ){
      //  for(Contact con:noc){
       Contact con=new Contact(Firstname='test'+i,LastName=lname);
            //con.FirstName='Test'+i;
            c.add(con);
        }
        return c;
    }
}