public class Checkbox_Class
{
  	//list of Employee
    List<AttendanceReportingWrapper> accountList = new List<AttendanceReportingWrapper>();
    //list of selected Employee
    List<Attendance_Reporting__c> selectedAccounts = new List<Attendance_Reporting__c>();
	//return total Employee list
    public List<AttendanceReportingWrapper> getAccounts()
    {
        if(accountList.isEmpty())
        {
            for(Attendance_Reporting__c a : [select Id, Name,Date__c,Leave_Type__c,Reporting_Time__c , mergeall__c from Attendance_Reporting__c limit 5])
        	accountList.add(new AttendanceReportingWrapper(a));
        
            
        }
        System.debug('account list>>>'+accountList);
        return accountList;
    }
    public void sendingEmail()
    {
        
        String Body='';
        for(AttendanceReportingWrapper a:accountList){
            Body = Body+'Name ID:'+ a.acc.Name+' Date:'+a.acc.Date__c + ' Leave Type:' +a.acc.Leave_Type__c+ ' Reporting Type:'+a.acc.Reporting_Time__c+' Name:'+a.acc.mergeall__c +'\n';
            
        }
        System.debug('*****accountList>>>+'+accountList+'accountlist>>>');
    	 Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
       	 message.toAddresses = new String[] {'ghanshyam.choudhari@capgemini.com'};
      //  message.optOutPolicy = 'FILTER';
        message.subject = 'Attendence Report';
        message.plainTextBody = 'This is the message body.'+Body;
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '
                  + results[0].errors[0].message);
        }
    }
    // checked Employee list and add to the list of selected Employee Account
    public PageReference getSelected()
    {
        selectedAccounts.clear();
        for(AttendanceReportingWrapper accwrapper : accountList)
        if(accwrapper.selected == true)
        selectedAccounts.add(accwrapper.acc);
        return null;
    }
	//recive the selcted account
    public List<Attendance_Reporting__c> GetSelectedAccounts()
    {
        if(selectedAccounts.size()>0)
        return selectedAccounts;
        else
        return null;
    }    
	//wrapper class have object get set and boolean get set
    public class AttendanceReportingWrapper
    {
       
        Public Attendance_Reporting__c acc{get;set;}
        public Boolean selected {get; set;}
        public AttendanceReportingWrapper(Attendance_Reporting__c a)
        {

            acc = a;
            selected = false;
        }
    }
}