trigger ProductDeleteTrg on Product2 (after delete) 
{
  /*  String[] types = new String[]{'Product2','Custom_Product__c'};
    Schema.DescribeSObjectResult[] results = Schema.DescribeSObjects(types);
        Schema.DescribeSObjectResult res = results[0];
    List<Product2> deletedProducts = trigger.old;*/
    set<decimal> productNumber = new set<decimal>() ;
    for(Product2 p : trigger.old)
    {
        system.debug('p.ProductNumber : '+p.ProductNumber__c);
        //String str = p.ProductNumber;
        productNumber.add(p.ProductNumber__c);
    }
    List<Custom_Product__c> toBeDeletedProducts = [select id,ProductNumber__c from Custom_Product__c
                                                   where ProductNumber__c IN : productNumber]; 
         Database.DeleteResult[] dt= Database.delete(toBeDeletedProducts);
    for(Database.DeleteResult d:dt)
    {
     if (d.isSuccess()) {
        // Operation was successful, so get the ID of the record that was processed
        System.debug('Successfully deleted.  ID: ' + d.getId());
                                         } else {
        // Operation failed, so get all errors
        for(Database.Error err : d.getErrors()) {
            System.debug('The following error has occurred.');
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Contact fields that affected this error: ' + err.getFields());
                                                                                                 }
            }
    }
    
}