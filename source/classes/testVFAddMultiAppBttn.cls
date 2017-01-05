@isTest
public class testVFAddMultiAppBttn {
    
    static testmethod void selectJobApp()
   {
        test.startTest();
        Position__c pos = new Position__c(Name='upasana');
        insert pos;
        Job_Application__c job = new Job_Application__c();
        
        wrapperClassController controller = new wrapperClassController();
                List<Job_Application__c> jobapp1 = new List<Job_Application__c>();
        List<Job_Application__c> jobapp2 = new List<Job_Application__c>();
        for(Integer i=0;i<5;i++)
        {
            Job_Application__c job1 = new Job_Application__c();
            wrapperClassController.jJobApplication jJob1 = new wrapperClassController.jJobApplication(job1);
            
            jJob1.selected = true;
            job1.Position__c=pos.id;
            jobapp1.add(job1);
          
            system.debug('+++++++++++true items++++++++++++'+jJob1.selected);
            if(jJob1.selected == true && job1.Position__c != null)
                system.assert(jJob1.selected, true);
             system.debug('+++++++++++true items position++++++++++++'+job1.Position__c);
            
        }
        
         for(Integer i=0;i<5;i++)
                {
            Job_Application__c job2 = new Job_Application__c();
            wrapperClassController.jJobApplication jJob2 = new wrapperClassController.jJobApplication(job2);
            jJob2.selected = false;
            jobapp2.add(job2);
            system.debug('+++++++++++false items++++++++++++'+jJob2.selected );
            if(jJob2.selected == false && job2.Position__c == null)
               // system.assert(jJob2.selected, false);
            system.debug('+++++++++++false items position++++++++++++'+job2.Position__c);
                }
         
   
    
    insert jobapp1;
    insert jobapp2;
        
                controller.processSelected();
        
      list<Job_Application__c> jobAppList =[select Position__c from Job_Application__c where Position__c=:pos.Id];
        if(jobAppList.size()==5)
        {
            system.debug('5 rec');
        }
        
        
        
    test.stopTest();
    
    }
    
    static testmethod void selectAllButton()
    {
        test.startTest();
          wrapperClassController controller = new wrapperClassController();
        List<Job_Application__c> jobapp3 = new List<Job_Application__c>();
        for(Integer i=0;i<5;i++)
        {
            Job_Application__c job1 = new Job_Application__c();
            jobapp3.add(job1);
        }
        insert jobapp3;
        controller.selectAll();
        
        test.stopTest();
           
   }
    static testmethod void cancelButton()
    {
        test.startTest();
        
        wrapperClassController controller = new wrapperClassController();
        controller.Cancel();
        
        test.stopTest();
    }

}