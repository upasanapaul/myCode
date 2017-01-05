public class OppoCntrlr {
    public List<Position__c> getData()
    {
         List <Position__c> al= [select name,CreatedDate from Position__c order by CreatedDate desc];
         return al;
    }
  
}