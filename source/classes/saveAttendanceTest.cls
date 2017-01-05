@isTest
public class saveAttendanceTest {
    //create Employee Data to see if it is selected?
    public static testMethod void testMyController(){
        PageReference pageRef = Page.saveAttendanceVf;
        Test.setCurrentPage(pageRef);
        Employee__c employeeObj = new Employee__c();
        //All fields
        employeeObj.Email__c='gc@gc.com';
        employeeObj.Name='Sangam Choudhari';
        employeeObj.Role__c='p1';
        employeeObj.EmployeeId__c=82104;
        insert employeeObj;
        
    }
}