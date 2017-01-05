public class  saveAttendance {
    //Empty list of attendance reporting
    public  List<Attendance_Reporting__c> allEmployee;
    public static List<Attendance_Reporting__c> allEmployeeMail;
    public List<String> EmployeeNames{get; set;} 
    //Empty list of Wrapper class
    public list <wrapEmployee> employeenewlist {get ; set;}
    //Empty list of string for strong Ids of Employee
    public map <ID,String> selectedIds {get ; set;}
    //Attendance reporting object referance
    public Attendance_Reporting__c atRe{get ; set;}
    //construstor of controller
    public  saveAttendance (){
        //assigning string list
        selectedIds = new Map<ID,String >();
        //calling get Employee for getting all Employee
        getEmployee();
        System.debug('iiiii>>>>' + allEmployee);
       
    }
    public void updateSelected(){
//call the thisContact field in here...
    System.debug('hi>>>');
}
    public List<Attendance_Reporting__c> getAllEmployee(){
        System.debug('****allEmployee***'+allEmployee);
        return allEmployee;
    }
    public List<Attendance_Reporting__c> getallEmployeeMail(){
        system.debug('allEmployeeMail>>>>'+allEmployeeMail);
        return allEmployeeMail;
    }
    //====================================================================================
    //Wrapper List method bcz we want employee with heckbox
    public List <wrapEmployee>  getEmployee(){
        //check wrapper listis empty  or not
        if( employeenewlist==null) {
            //assign the wrapper list 
            employeenewlist=new List<wrapEmployee>();
            //took all employee from query and add each employee and chekbox to the list
            for(Employee__c a : [SELECT ID , Name from Employee__c]) {
                employeenewlist.add(new wrapEmployee (a));
            }
    }
        System.debug('Employee list+++++++++++++++++++++>>>>'+employeenewlist);
        //return the employeenewlist with employee and checkbox
        return  employeenewlist;
    }
    //===========================================================================
    public PageReference processSelected() {
        System.debug('checked selected'+ employeenewlist );
        //when next button click this function will call
        //check the all employee list
        //assigning attadence reporting list
        allEmployee = new List<Attendance_Reporting__c>();
        for(wrapEmployee w :  employeenewlist) {
            //if employee contains checkbox true 
            if(w.selected) {
                //add employee's Id to the selectedIds list
               selectedIds.put(w.empl.Id , w.empl.Name);
                System.debug('*****w****'+w);
                //attendane reporting list add karel before that it will create new obj with parameter emp Id and date today
                allEmployee.add
                    (new Attendance_Reporting__c(Employees__c = w.empl.ID, Employee_Name__c = w.empl.Name, Date__c = Date.today()) ); 
            
            }
        }
        System.debug('****allEmployee***'+allEmployee);
        if (selectedIds.size() > 0 ) {
            PageReference p =new PageReference('/apex/saveAttendanceNextVf');
            p.setRedirect(false);
            return p;
        } else {
            return null;
        }  
        return null;
    }	
    public list<string> employeeNameString(){
       
    	set<id> keys = selectedIds.keySet();
   			 for (id k:keys) {
                 	EmployeeNames.add(selectedIds.get(k));
        			system.debug('Employee Name>>>> : '+ selectedIds.get(k));
    				}
        return EmployeeNames;
    }
    public PageReference save()
    {	atRe =new Attendance_Reporting__c();
     	system.debug('allEmployeelist>>>>'+allEmployee);
     	insert allEmployee ;    
     	allEmployeeMail = new List<Attendance_Reporting__c>();
     	allEmployeeMail = [SELECT Date__c,Employees__c,Id,Leave_Type__c,Employees__r.Name,Employees__r.Email__c,mergeall__c,Name,Reporting_Time__c,Reporting_Type__c FROM Attendance_Reporting__c where id IN: allEmployee];
     	//allEmployeeMail = allEmployee;
     	list<string> emailList= new list<string>();
     for(Attendance_Reporting__c aRep:allEmployeeMail){
         if(aRep.Reporting_Type__c=='NRL'){
             emailList.add(aRep.Employees__r.Email__c);
         }
     }
     OrgWideEmailAddress owa = [select id, Address,DisplayName from OrgWideEmailAddress where DisplayName = :'TDC Attendance'];    
     EmailTemplate e=[SELECT Name,Description,Subject,FolderId,IsActive FROM EmailTemplate WHERE Id = '00X28000001Fien'];
		String d = e.Description;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(userInfo.getUserId());
        mail.setTemplateId(e.id);
        mail.setToAddresses(new List<String>{'tdcleads.in@capgemini.com'});
     	mail.setBccAddresses(new List<String>{'shikhar.yadav@capgemini.com'});
     	mail.setTreatTargetObjectAsRecipient(false);
     	if(owa != null)
             mail.setOrgWideEmailAddressId(owa.Id);
     	if(!emailList.isEmpty())   
     		mail.setCcAddresses(emailList);
     	mail.setSaveAsActivity(false);
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new list<Messaging.SingleEmailMessage>{mail});
     System.debug('*****results****'+results);
 		    
     return Page.EmplControllerPage;
    }
    public PageReference cancel()
    {
        return null;
    }
    public PageReference backProcessSelected(){
        return Page.EmplControllerPage;
    }
    public PageReference back() {
        
        return Page.saveAttendanceVf;
    } 
    public class wrapAllEmployee {
        public Employee__c empl ; 
        public string empName;
    }
    public class  wrapEmployee {
       
        public Employee__c empl {get ; set;}
        public Boolean selected {get; set;}
        public Attendance_Reporting__c attreport {get ; set;}
        public wrapEmployee () {
            empl=new Employee__c();
            attreport = new Attendance_Reporting__c();
            selected = false;
        }
        public wrapEmployee (  Employee__c a ) {  
            empl=a;
            selected = false;
        }
        public wrapEmployee (Attendance_Reporting__c b){
            attreport=b;
            selected = false;
            
        }
    }
}