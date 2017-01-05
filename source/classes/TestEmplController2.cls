@istest
public class TestEmplController2 {
    
    static testmethod void LoadData(){
        test.startTest();
        Employee__c emp = new Employee__c();
        emp.Name='test';
        emp.Email__c='test@gmail.com';
        emp.EmployeeId__c=6567;
        emp.Role__c='M2';
        insert emp;
        //system.debug(b);
        PageReference pageRef =page.EmplControllerPage; 
        test.setcurrentpage(pageRef);
        EmplController2 ec = new  EmplController2();
        ec.id1='a0I28000009CfX0';
        string id=ec.id1;
        ec.getproj(id);
        List<Employee__c> testsearchResults=new List<Employee__c>();
        Employee__c testopp;
        testsearchResults.add(testopp);
        test.stopTest();
    }
    static testmethod void cancel()
    {
        
        PageReference pageRef =page.EmplControllerPage; 
        test.setcurrentpage(pageRef);
        EmplController2 ec = new EmplController2();
        String cancel=ec.leavePageReturnButton().getUrl();
        //System.assertEquals('http://developer.salesforce.com/',cancel);
        //
    }
    
    static testmethod void Beginning()
    {
        Test.startTest();
        Employee__c testBox = new Employee__c(name = 'Test',Email__c = 'test@gmail.com',Role__c='M2');
        insert testBox;
        PageReference pageRef = Page.EmplControllerPage;
        Test.setCurrentPage(pageRef);
        EmplController2 ec = new EmplController2();
        ec.Beginning();
        ec.list_size=5;
        ec.counter=5;
        ec.id1='a0I28000009CfX0';
        ec.Previous();
        ec.next();
        ec.End();
        ec.getDisablePrevious();
        ec.getDisableNext();
        ec.getTotal_size();
        ec.getPageNumber();
         ec.getTotalPages();
        ec.getproj(ec.id1);
        ec.getatndnce(ec.id1);
         ec.releaseButton();
        ec.ShowBlockMethod();
        Test.stopTest();
    }
    

}