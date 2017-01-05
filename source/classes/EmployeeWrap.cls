public class  EmployeeWrap {  
    public  List <Attendance_Reporting__c> selectedEmployee {get ; set;}
    Public List <wrapEmployee> employeelist{get ; set;}
    //public Messaging.SingleEmailMessage message{get ; set;}
    public EmployeeWrap(){
        selectedEmployee = new List<Attendance_Reporting__c> ();
        getEmployee();
    }
    public List <wrapEmployee>  getEmployee(){
        if(employeelist == null) {
            employeelist =new List<wrapEmployee>();
            for(Attendance_Reporting__c a : [SELECT Date__c,Attendance_Reporting__c.Employees__r.Name,Id,Leave_Type__c,Name,Reporting_Time__c,Reporting_Type__c FROM Attendance_Reporting__c]) {
                employeelist.add(new wrapEmployee (a));
            }
    }
        // system.debug('Employee list>>>>'+employeelist);
        return employeelist;
    }
    public PageReference processSelected() {
        System.debug('checked selected'+employeelist);
        for(wrapEmployee w : employeelist) {
            if(w.selected) {
                selectedEmployee.add(w.emp);   
                system.debug('selected employee>>>>'+selectedEmployee);
            }
        }
        if (selectedEmployee.size() > 0) {
            return Page.EmployeeWrapNextVf;
        } else {
            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select at least one Category.'));
            return null;
        }  
        System.debug('These are the selected Employee name...');
        for(Attendance_Reporting__c emp : selectedEmployee) {
            system.debug(emp);
        }
        employeelist=null;  
        return null;
    }	
    public void sendEmail(){
        String Body='';
        for(wrapEmployee a:employeelist){
            Body = Body+'Name ID:'+ a.emp.Name+' Date:'+a.emp.Date__c + ' Leave Type:' +a.emp.Leave_Type__c+ ' Reporting Type:'+a.emp.Reporting_Time__c+' Name:'+a.emp.Employees__r.Name+'\n'; 
        }
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { 'ghanshyam.choudhari@capgemini.com' };
        //message.optOutPolicy = 'FILTER';
        message.subject = 'Employee attendence reporting';
        message.plainTextBody = 'This is the message body.'+Body;
        Messaging.SingleEmailMessage[] messages = 
            new List<Messaging.SingleEmailMessage> {message};
                 Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '
                  + results[0].errors[0].message);
        }
    }
    public PageReference save()
    {	System.debug('>>>>Selected Employees<<<<<'+selectedEmployee);
        insert selectedEmployee;
     return null;
    }
    public PageReference cancel()
    {
        return null;
    }
    public PageReference back() {
        selectedEmployee.clear();
        return Page.EmployeeWrapvf;
    }
    public class  wrapEmployee {
        public  Attendance_Reporting__c emp{get; set;}
        public Boolean selected {get; set;}
        public wrapEmployee () {
            emp =new Attendance_Reporting__c();
            selected = false;
        }
        public wrapEmployee ( Attendance_Reporting__c a) {
            emp =a;
            selected = false;
        }
    }
}