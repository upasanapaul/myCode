public class lineItemPrimaryClassAfterDelete {
    public static void isPrimary(list<Line_Item__c> lia,Line_Item__c temp,Decimal max)
    {
        for(integer i=1;i<lia.size();i++)
        {
            lia[i].Primary__c=False;
            if(lia[i].Total_Cost__c >max)
            {
                lia[i].Primary__c=true;
                temp.Primary__c=False;
                max=lia[i].Total_Cost__c;
                temp=lia[i];
            }
        }
        update lia;
    }


}