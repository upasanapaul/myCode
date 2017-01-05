public class saveAttendanceEmailContoller {
    public List<Attendance_Reporting__c> attenList{get; set;}

    public saveAttendanceEmailContoller() {
            // 
        attenList = [SELECT Date__c,Employees__c,Id,Leave_Type__c,mergeall__c,Name,Reporting_Time__c,Reporting_Type__c FROM Attendance_Reporting__c];
    }

    public List<Attendance_Reporting__c> getAccounts() {
        system.debug('All attendeance reporting records >>>'+ attenList );
        return attenList;
    }
}