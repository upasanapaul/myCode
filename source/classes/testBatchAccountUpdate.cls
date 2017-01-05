@istest
public class testBatchAccountUpdate {
    static testmethod void batchClass() {
        // The query used by the batch job.
        String query = 'SELECT Id,Name FROM Account';
        // Create some test merchandise items to be deleted
        // by the batch job.
        account[] ml = new List<account>();
        for (Integer i=0;i<10;i++) {
            account m = new account(Name='Merchandise ' + i);
            ml.add(m);
        }
        insert ml;
        Test.startTest();
        batchAccountUpdate b = new batchAccountUpdate();
        Database.executeBatch(b);
        Test.stopTest();
        // Verify merchandise items got deleted
        //Integer i = [SELECT COUNT() FROM Merchandise__c];
        //System.assertEquals(i, 0);
    }
    
    
}