@istest
public class testMultiselect {
    static testmethod void lefttest()
    {
        Test.startTest();
        
        
        //List<SelectOption> selOpts1=ec.availableProjects;
        
        //list<Employee__c> empList =new list<Employee__c>();
        Employee__c emp=new Employee__c(name='test name');
        
        insert emp;
        
        //list<Project_Account__c> pc=new list<Project_Account__c>() ;
        Project_Account__c prr=new Project_Account__c(name='test', project_code__c='275362783' , active__C='Active');
       
        insert prr;
        
        
        
        
        
        //list<Assignment_Detail__c> addList=new list<Assignment_Detail__c>();
        Assignment_Detail__c asign=new Assignment_Detail__c(Employees__c= emp.Id , Project_Accounts__c=prr.Id);
        //addList.add(asign);
        insert asign;
        
        PageReference pageRef = Page.EmplControllerPage;
        Test.setCurrentPage(pageRef);
        
        multiselect ec = new multiselect();
        
        ec.leftToRightArrow.add(prr.Id);
        ec.LeftSideList();
        ec.rightToLeftArrow.add(prr.Id);
        ec.RightSideList();
        //ec.availableProjects.add(new SelectOption(prr.Id, prr.Name));
        //ec.assignedProjects.add(new SelectOption(prr.Id, prr.Name));
        ec.cancelButton();
        ec.saveButton();
        
        
        Test.stopTest();
    }
    
   
}