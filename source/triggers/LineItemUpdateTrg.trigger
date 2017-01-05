trigger LineItemUpdateTrg on Line_Item__c (before update) {
        List<Line_Item__c> newLineItemList = new List<Line_Item__c>();
    Map<id,Line_Item__c> updatedLineItemMap = trigger.newMap;
    List<Line_Item__c> updateOldPrimaryLinItem = new List<Line_Item__c>();
    Set<Id> IN_Stat_Set = new Set<Id>();
    for (Line_Item__c LI : trigger.new)
    {
       IN_Stat_Set.add(LI.Invoice_Statement__c);
    }
    List<Line_Item__c> lineListSecondMax = [Select id, Total_Cost__C from Line_Item__c order by Total_Cost__C desc limit 2];

    newLineItemList = [select id,Total_Cost__C,Primary__c,Invoice_Statement__c from Line_Item__c
                       where Invoice_Statement__c in : IN_Stat_Set AND Primary__c=true];
    system.debug('lineitem'+newLineItemList);
    Map<id,Line_Item__c> existingPrimaryMap = new Map<id,Line_Item__c>();
    for(Line_Item__c line : newLineItemList)
    {
        existingPrimaryMap.put(line.Invoice_Statement__c,line);
    }

    for (Line_Item__c LI : trigger.new)
    {
          if(existingPrimaryMap.containsKey(LI.Invoice_Statement__c))
          {
                  Line_Item__c lineItemObj = existingPrimaryMap.get(LI.Invoice_Statement__c);
              if(existingPrimaryMap.get(LI.Invoice_Statement__c).id == li.id)
              {
                  if(li.Total_Cost__C < lineListSecondMax[1].Total_Cost__C)
                  { lineListSecondMax[1].Primary__C = true;
                  updateOldPrimaryLinItem.add(lineListSecondMax[1]);
                   li.Primary__c = false;}
                  break;
              }
              System.debug('**********lineItemObj'+lineItemObj.Total_Cost__C);
              System.debug('**********li.Total_Cost__C'+li.Total_Cost__C);

                if(lineItemObj.Total_Cost__C > LI.Total_Cost__C){

                                             //Do nothing
                              }else{
                                             LI.Primary__c = true;        //setting ne to true
                                         System.debug('We are here 3454545.#######');
                               //   if(li.id== lineItemObj.id)
                                  lineItemObj.Primary__c = false;
                                 //  System.debug('We are here.#######');
                                 updateOldPrimaryLinItem.add(lineItemObj );

                              }
          }
    }
   update updateOldPrimaryLinItem;



}