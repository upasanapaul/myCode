public class ContactSearch {
    public static List<Contact> searchForContacts(String lname, String pcode){
        List<Contact> ctc = new List<Contact>();
        ctc = [SELECT FirstName FROM Contact WHERE LastName=:lname AND MailingPostalCode=:pcode];
        return ctc;
       }
}