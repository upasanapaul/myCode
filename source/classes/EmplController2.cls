public  with sharing class EmplController2
{    
    public integer counter=0; 
    public integer list_size=10;
    public integer total_size;
    Public Boolean ShowpageBlockFlag{get;set;}
    public Boolean disabl {get;set;}
    public boolean show {get;set;}
    public boolean hide{get;set;}
    public List<Employee__C> employeeRecords{get;set;}
    public list<Assignment_Detail__c> proj{get;set;}
    public String id1{get; set;}
    public String releaseID{get; set;}
    public String currentRecordId {get;set;}
    public String parameterValue {get;set;}
    public Account acc{get;set;}
    Public Boolean  showLeaves{get;set;}
    Public Boolean  showSelected{get;set;}
    public List<TableRow> RowList {get; set;}
    public list<dates> LeaveList{get;set;}
    public string name{get; set;}
    public string type{get; set;}
    public string eId{get; set;}
    public EmplController2(){
        ShowpageBlockFlag = false;
        employeeRecords = new List<Employee__c>();
        LoadData();
        total_size = [select count() from Employee__c];
        
        PageReference myPage = new PageReference('/apex/leavesPage?name= '+name);
        system.debug('name>>>>'+name);
        PageReference yourPage = new PageReference('/apex/ProjectsPage?eId='+Id1);
        proj=new list<Assignment_Detail__c>();  
    }
    
    public List<Employee__C> LoadData() {
        employeeRecords = [select Name,EmployeeId__c,Role__c from Employee__c ORDER BY Name,EmployeeId__c,Role__c limit :list_size offset :counter]; 
        ShowpageBlockFlag = false;
        return employeeRecords;
    }
    public PageReference doReport(){

        system.debug('test');

        PageReference pr = new PageReference('/apex/saveAttendanceVf'); 
        pr.setRedirect(true);
        return pr;
    }
    
    public PageReference deleteEmpRecord(){
        eId = Apexpages.currentPage().getParameters().get('eId');
        System.debug('***eId***'+eId);
        Employee__c emp = [SELECT Id FROM Employee__c WHERE Id=: eId];
        delete emp;
        LoadData();
       return null;
    }

    Public PageReference newAttendance()
    {        
        
        PageReference pg=New PageReference('https://ap2.salesforce.com/a0P/e?&saveURL=/apex/EmplControllerPage&retURL=apex/EmplControllerPage');
        return pg;    
    } 
    
    Public PageReference newEmployee()
    {        
        
      	PageReference pg=New PageReference('/apex/addEmployeeVf?retURL=%2Fapex%2FEmplControllerPage');
        return pg;    
    } 
    
    public void getproj(String Id){
        
        proj=[select Name, Project_Accounts__r.name,Project_Accounts__r.id, Project_Accounts__r.Project_Code__c, Employees__c from Assignment_Detail__c WHERE (Project_Accounts__r.Active__c =: 'Active' and Employees__c =:Id) ];
    }
    
    public void getatndnce(String Id){
        integer leave=[select count() from Attendance_Reporting__c WHERE (Reporting_Type__c =: 'L' and Employees__c =:Id)];
        system.debug('leave'+leave);
        integer nrl=[select count() from Attendance_Reporting__c WHERE (Reporting_Type__c =: 'NRL' and Employees__c =:Id)];
        system.debug('nrleave'+nrl);
        integer rl=[select count() from Attendance_Reporting__c WHERE (Reporting_Type__c =: 'RL' and Employees__c =:Id)];
        system.debug('rleave'+rl);
        rowlist=new list<tablerow>();
        TableRow tr=new tablerow(leave, nrl, rl);
        system.debug('tablerow++++'+tr);
        rowlist.add(tr);
        LeaveList=new list<dates>();
        dates dt;
       // dates dt2;
        for(Attendance_Reporting__c att:[select Date__c,Adjust_Date__c,Leave_Type__c, name,id,Employees__r.name from  Attendance_Reporting__c WHERE (Reporting_Type__c =: 'L' and Employees__c =:Id)]){
            dt= new dates();
            dt.dateList=att.date__c;
            
            
            LeaveList.add(dt);
          //  dt2= new dates();
            
           // dt2.adjustList=att.Adjust_Date__c;
           // LeaveList.add(dt2);
            
            
            system.debug('Leave_Type__c'+att.Leave_Type__c);
            type=att.Leave_Type__c;
            system.debug('Employees__r.name'+att.Employees__r.name);
            name=att.Employees__r.name;
        }
        ShowpageBlockFlag = false;
        system.debug('name inside show leaves method'+name);
        system.debug('type inside show leaves method'+type);
    }
    
    Public pagereference showLeavesMethod(){
        getatndnce(Id1);
        system.debug('name inside show leaves method'+name);
        system.debug('type inside show leaves method'+type);
        ShowpageBlockFlag = true;
        showLeaves = true;
        PageReference myPage = new PageReference('/apex/leavesPage?name= '+name);
        return myPage ;
    }
    
    Public PageReference showSelectedMethod(){
        ShowpageBlockFlag = true;
        showSelected = true;
        PageReference yourPage = new PageReference('/apex/ProjectsPage?eId='+Id1);
        return yourPage ;
    }
    
    public class dates{
        public date dateList{get;set;}
       // public date adjustList{get;set;}
    }
    public class TableRow{
        public integer leave{get;set;}
        public integer nrl{get;set;}
        public integer rl{get;set;}
        
        public TableRow(Integer leave, Integer nrl, Integer rl){
            this.leave = leave;
            this.nrl = nrl;
            this.rl = rl;
        }
    }
    
    public void ShowBlockMethod(){
        getproj(Id1);
        getatndnce(Id1);
        ShowpageBlockFlag = true;
    }
    
    Public pagereference leavePageReturnButton(){
        PageReference yourPage = new PageReference('/apex/EmplControllerPage');
        return yourPage ;
    }
    Public void releaseButton(){
        system.debug('releaseID'+releaseID);
        List<Assignment_Detail__c> listAd = [Select Id From Assignment_Detail__c Where Project_Accounts__r.id=:releaseID];
        delete listAd;
        getproj(id1);
    }
    
    
    public PageReference Beginning() { 
        ShowpageBlockFlag = false;
        counter = 0;
        system.debug('Inside beggining');
        system.debug('counter'+counter);
        system.debug('list_size'+list_size);
        LoadData();
        return null;
    }
    
    public PageReference Previous() { 
        ShowpageBlockFlag = false;
        counter -= list_size;
        system.debug('Inside previous');
        system.debug('counter'+counter);
        system.debug('list_size'+list_size);
        LoadData();
        return null;
    }
    
    public PageReference Next() { 
        ShowpageBlockFlag = false;
        counter += list_size;
        system.debug('Inside next');
        system.debug('counter'+counter);
        system.debug('list_size'+list_size);
        LoadData();
        return null;
    }
    
    public PageReference End() { 
        ShowpageBlockFlag = false;
        counter = total_size - math.mod(total_size, list_size);
        system.debug('Inside end');
        system.debug('counter'+counter);
        system.debug('list_size'+list_size);
        LoadData();
        return null;
    }
    
    public Boolean getDisablePrevious() { 
        if (counter>0) return false; else return true;
    }
    
    public Boolean getDisableNext() {
        if (counter + list_size < total_size) return false; else return true;
    }
    
    public Integer getTotal_size() {
        return total_size;
    }
    
    public Integer getPageNumber() {
        return counter/list_size + 1;
    }
    
    public Integer getTotalPages() {
        if (math.mod(total_size, list_size) > 0) {
            return total_size/list_size + 1;
        } else {
            return (total_size/list_size);
        }
    }
}