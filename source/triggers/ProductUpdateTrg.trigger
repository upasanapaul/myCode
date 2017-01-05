Trigger ProductUpdateTrg on Product2 (after update) 
{
        list<Product2> p=trigger.new;
    set<decimal> productNumber = new set<decimal>() ;
    for(Product2 p2 : trigger.old)
    {
        //system.debug('p.ProductNumber : '+p2.ProductNumber);
        //String str = p.ProductNumber;
        productNumber.add(p2.ProductNumber__c);
    }
    
    
      //Custom_Product__c cp=new Custom_Product__c();
     List<Custom_Product__c> toBeUpdatedProducts = [select id,ProductNumber__c from Custom_Product__c 
                                                    where ProductNumber__c IN : productNumber]; 
  system.debug('toBeUpdatedProducts :'+toBeUpdatedProducts);
        String[] types = new String[]{'Product2'};
        Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
    Schema.DescribeSobjectResult res = results[0];
  //Map<String,Schema.SObjectField> CustomProductfieldsMap = res.fields.getMap(); 
    set<String> fields=res.fields.getMap().keySet();
   for(Integer i=0;i<toBeUpdatedProducts.size();i++)
   {
        for(String s:fields)
        {
            if(s.endsWith('__c'))
            {
                toBeUpdatedProducts[i].put(s, p[i].get(s)); 
                system.debug('fields'+s);
              
            }else if(s.equals('name')
                    ||s.equals('productcode')||s.equals('description'))
            {
               system.debug('id :'+s);
                 toBeUpdatedProducts[i].put('Name',p[i].get('name'));
                 toBeUpdatedProducts[i].put('ProductNumber__c',p[i].get('productcode'));
                 //toBeUpdatedProducts[i].put('Description__c',p[i].get('description'));
               
            }
        }
    }
    update toBeUpdatedProducts;
    
}