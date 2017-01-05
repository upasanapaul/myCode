/*trigger AccountAddressTrigger on Account (before insert, before update) {
 // Account acc=new Account();
    for(List<Account> acc:trigger.new)
    {
   
    if(acc.Match_Billing_Address__c ==true){
        acc.BillingPostalCode =acc.ShippingPostalCode; 
    }
    }
}*/

trigger AccountAddressTrigger on Account (before insert,before update) 
{
     for(Account acct : Trigger.new)
    {
        if(acct.Match_Billing_Address__c == true)
        {
            acct.ShippingPostalCode =   acct.BillingPostalCode;
           // System.debug('ShippingPostalCode should be equal to BillingPostalCode');
        }
    }
}