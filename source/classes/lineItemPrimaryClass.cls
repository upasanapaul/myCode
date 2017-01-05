public class lineItemPrimaryClass {

    Public Static void primaryLineItemAssignment(List<line_item__c> liNew, Set<Id> Inv){
        List<Line_Item__c> liInv = new List<Line_Item__c>([Select Total_Cost__c, Invoice_Statement__c From Line_Item__c Where Invoice_Statement__c IN :Inv ]);
           Line_Item__c temp=liInv[0];
        temp.Primary__c=true;
        Decimal max=temp.Total_cost__c;
        for(integer i=1;i<liInv.size();i++)
        {
            liInv[i].Primary__c=False;
            if(liInv[i].Total_cost__c >max)
            {
                liInv[i].Primary__c=true;
                temp.Primary__c=False;
                max=liInv[i].Total_cost__c;
                temp=liInv[i];
            }
        }
        update liInv;


    }
}