public class ContactAndLeadSearch {
    public static List<List< SObject>> searchContactsAndLeads(string name){
        List<List< SObject>> searchList= [FIND :name IN Name FIELDS RETURNING Contact(Name),Lead(Name)];
        Contact[] searchContact =(Contact[])searchList[0];
        Lead[] searchLead =(Lead[])searchList[1];
        System.debug('Contacts');
        for(Contact c : searchContact)
        {
            system.debug(c.Name);
        }
        system.debug('Leads');     
        for(Lead l : searchLead)
        {
            system.debug(l.Name);
        }
        return searchList;
    }
}