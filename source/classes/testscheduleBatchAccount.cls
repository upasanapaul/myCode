@istest
class testscheduleBatchAccount {
    static testmethod void test() {
        Test.startTest();
        //String CRON_EXP = '14 30 0 24 2 ? 2016';  
        Account a = new Account();
        a.Name = 'testScheduledApexFromTest';
        insert a;
        
        // Schedule the test job
        
        String jobId = System.schedule('testBasicScheduledApex',scheduleBatchAccountUpdate.CRON_EXP,new scheduleBatchAccountUpdate());
        system.debug('scheduleBatchAccountUpdate.CRON_EXP++++++++'+scheduleBatchAccountUpdate.CRON_EXP);
        // Get the information from the CronTrigger API object
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered,NextFireTime FROM CronTrigger WHERE id = :jobId];
        
        // Verify the expressions are the same
        System.assertEquals(scheduleBatchAccountUpdate.CRON_EXP, ct.CronExpression);
        
        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered);
        
        // Verify the next time the job will run
        System.assertEquals('2017-02-23 02:05:00', String.valueOf(ct.NextFireTime));
        System.assertNotEquals('testScheduledApexFromTestMethodUpdated',[SELECT id, name FROM account WHERE id = :a.id].name);
        system.debug('[SELECT id, name FROM account WHERE id = :a.id].name++++'+[SELECT id, name FROM account WHERE id = :a.id].name);
        Test.stopTest();
        
        System.assertEquals('testScheduledApexFromTest',[SELECT Id, Name FROM Account WHERE Id = :a.Id].Name);
        
    }
}