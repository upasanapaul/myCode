public class repeaterCon {
    public List<String> collection {
        get {
            if (collection == null) {
                collection = new List<String>();
                for (Attendance_Reporting__c  a : [SELECT mergeall__c FROM Attendance_Reporting__c]) {
                    collection.add(a.mergeall__c);
                }
            }
            return collection;
        }
        private set;
    }
}