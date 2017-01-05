public class addEmployeeController {
    
    public Employee__c employee{get; set;}
    public addEmployeeController(ApexPages.StandardController controller){
        employee = new Employee__c();
        employee = (Employee__c)controller.getRecord();
        String id = ApexPages.currentPage().getParameters().get('id');
        System.debug('****Id***'+id);
        if(id != null){
            employee = [Select Id, Name, Email__c, EmployeeId__c, Role__c FROM Employee__c WHERE Id=: id];
        }
    }
    
    public PageReference saveRecord(){
        System.debug('****employee***'+employee);
        upsert employee;
        PageReference pg = new PageReference('/apex/EmplControllerPage');
        pg.setRedirect(true);
        return pg;
    }

}