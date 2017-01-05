trigger lineItemPrimary on Line_Item__c (after insert) {
  
    List<Line_Item__c> newLineItemList = new List<Line_Item__c>();
    Set<Id> IN_Stat_Set = new Set<Id>();
    for (Line_Item__c LI : trigger.new) {
                IN_Stat_Set.add(LI.Invoice_Statement__c);
        }
                lineItemPrimaryClass.primaryLineItemAssignment(Trigger.New ,IN_Stat_Set);
}