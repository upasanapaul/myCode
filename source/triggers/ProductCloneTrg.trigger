trigger ProductCloneTrg on Product2 (after insert) {
        Map<id,Product2> InsertedProductsMap = trigger.newMap;
    set<id> record=trigger.newMap.keySet();
    list<Product2> p=trigger.new;
    String[] types = new String[]{'Product2','Custom_Product__c'};
        Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
   
    List<Custom_Product__c> customProductList = new List<Custom_Product__c>();
 //    Set<String> fields = Custom_Product__c.getDescribe().fields.getMap().keySet();
  //  for(Schema.DescribeSobjectResult res : results) 
  // for(Integer i=0;i<1;i++) 
   // {
        Schema.DescribeSobjectResult res = results[0];
        Map<String,Schema.SObjectField> ProductfieldsMap = res.fields.getMap(); 
    
      
        Schema.DescribeSobjectResult res1 = results[1];
        Map<String,Schema.SObjectField> CustomProductfieldsMap = res1.fields.getMap(); 
         //system.debug(CustomProductfieldsMap.get(res1).getName());
      system.debug('res : '+res);
         set<String> fields=res.fields.getMap().keySet();
    system.debug('fields : '+fields);
    String s1;
    for(Integer i=0;i<p.size();i++)
    { 
        Custom_Product__c cp=new Custom_Product__c();
         for(String s:fields)
        {
            if(s.endsWith('__c'))
            {
                cp.put(s, p[i].get(s)); 
                system.debug('fields'+s);
              
            }
            else if(s.equals('name')
                    ||s.equals('productcode')||s.equals('description'))
            {
               system.debug('id :'+s);
                 cp.put('Name',p[i].get('name'));
                 cp.put('ProductCode__c',p[i].get('productcode'));
                 //cp.put('ProductNumber__c',p[i].get(''));
               
            }
            else 
            {
                /*s1=s;
                s=s+'__c';
                  //do nothing
                cp.put(s,p[0].get(s1));*/
            }
        }
        customProductList.add(cp);
    }
     /*    system.debug('Customfields*******');
     set<String> fields1=res1.fields.getMap().keySet();
     for(String s:fields1)
        {
            if(s.endsWith('__c'))
            {
                  
                system.debug('fields'+s);
             // cp.put(, account.get(accountfieldName)); 
            }
        }*/
    //cp.put('Price__c', p[0].get('Price__c')); 
    system.debug('CP:'+customProductList);
    insert customProductList;
    
   // Database.SaveResult sr = Database.insert(customProductList, false);
    
  /*  if (sr.isSuccess()) {
        // Operation was successful, so get the ID of the record that was processed
        System.debug('Successfully inserted contact. Contact ID: ' + sr.getId());
    } else {
        // Operation failed, so get all errors
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Contact fields that affected this error: ' + err.getFields());
         }
    }

      //  record.getSObject('Custom_Product__c').get('Price__c');
    
        
      /*  for(Schema.SObjectField s:fieldsMap.values())
        {
            system.debug('fields'+s);
        }*/
        
   // }
}