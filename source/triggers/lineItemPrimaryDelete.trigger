trigger lineItemPrimaryDelete on Line_Item__c (after delete) {

                List<Line_Item__c> newLineItemList = new List<Line_Item__c>();
    Set<Id> IN_Stat_Set = new Set<Id>();
    for (Line_Item__c LI : trigger.old) 
    {
       IN_Stat_Set.add(LI.Invoice_Statement__c);
    }
    system.debug('inv'+IN_Stat_Set);
    newLineItemList = [select id,Total_Cost__c,Primary__c,Invoice_Statement__c from Line_Item__c 
                       where Invoice_Statement__c in : IN_Stat_Set];
    system.debug('lineitem'+newLineItemList);
    Line_Item__c temp = newLineItemList[0];
                decimal max = temp.Total_Cost__c;
    temp.Primary__c=true;
    lineItemPrimaryClassAfterDelete.isPrimary(newLineItemList,temp,max);
    
}