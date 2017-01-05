@isTest
public class testLineItemPrimary 
{ 
    @isTest static Invoice_Statement__c createInvoice()
    {
       Invoice_Statement__c is1=new Invoice_Statement__c(Status__c='open');
      
        Database.SaveResult invoice1=Database.insert(is1,false);
        return is1;
    }


    @isTest static void testFirstLineItemInsert()
    {
        
       Test.startTest();
        Invoice_Statement__c invoice = createInvoice();
        
        Line_Item__c li1=new Line_Item__c(Name='544', Unit_Price__c=10.50, Units_Sold__c=2, Merchandise__c='a0M28000001KVSp', Invoice_Statement__c=invoice.Id );
        Database.SaveResult sav1=Database.insert(li1,false);
       system.debug(sav1);
    //    System.debug('Primary status:++++++++++++++++++++++++++++++' + li1.Primary__c);
      
     //   System.assert(sav1.isSuccess());
        if (li1.Primary__c==true)
        {
            system.assert(li1.Primary__c, true);
        }
        test.stopTest();
        
        
        Line_Item__c li2=new Line_Item__c(Name='546', Unit_Price__c=56600.50, Units_Sold__c=22, Merchandise__c='a0M28000001KVSp', Invoice_Statement__c=invoice.Id);
        Database.SaveResult sav2=Database.insert(li2,false);
        System.assert(sav2.isSuccess());
        if (li2.Primary__c==true)
        {
            system.assert(li2.Primary__c, true);
        }
        
    }
    
    
      @isTest static void testLineItemDelete()
    {
        
       Test.startTest();
        Invoice_Statement__c invoice = createInvoice();
        Line_Item__c li1=new Line_Item__c(Name='544', Unit_Price__c=10.50, Units_Sold__c=2, Merchandise__c='a0M28000001KVSp', Invoice_Statement__c=invoice.Id );
       Database.SaveResult sav1=Database.insert(li1,false);
        Line_Item__c li2=new Line_Item__c(Name='546', Unit_Price__c=56600.50, Units_Sold__c=22, Merchandise__c='a0M28000001KVSp', Invoice_Statement__c=invoice.Id);
        Database.SaveResult sav2=Database.insert(li2,false);
         Line_Item__c li3=new Line_Item__c(Name='549', Unit_Price__c=56660.50, Units_Sold__c=24, Merchandise__c='a0M28000001KVSp', Invoice_Statement__c=invoice.Id);
        Database.SaveResult sav3=Database.insert(li3,false);
        Database.DeleteResult result = Database.delete(li2, false);
        System.assert(result.isSuccess());
         for(Line_Item__c line:[select Primary__c From Line_Item__c])
         {
        if (line.Primary__c==true)
        {
            system.assert(line.Primary__c, true);
        }
         }
        
    }


}