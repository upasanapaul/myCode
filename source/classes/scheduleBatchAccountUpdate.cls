global with sharing class scheduleBatchAccountUpdate implements Schedulable 
{
    public static String CRON_EXP = '0 05 2 26 2 ?';
    global void execute(SchedulableContext ctx)
    {
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :ctx.getTriggerId()];
        
        System.assertEquals(CRON_EXP, ct.CronExpression);
        //System.assertEquals(1, ct.TimesTriggered);
        System.assertEquals('2017-02-26 02:05:00', String.valueOf(ct.NextFireTime));
        
        // The query used by the batch job.
        //String query = 'SELECT Id,Name FROM Account';
        //ID BatchId = Database.executeBatch(new RunBatchApex (), 200);
        batchAccountUpdate c = new batchAccountUpdate();
        Database.executeBatch(c);
    } 
}