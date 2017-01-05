public class CategoryWrapper {

    public Boolean checked{ get; set; }
    
    //> public Cat3__c cat { get; set;}
    public Attendance_Reporting__c attReport {get;set;}

    public CategoryWrapper(){
       //> cat = new Cat3__c();
      attReport = new Attendance_Reporting__c();
        checked = false;
    }

    public CategoryWrapper(/*>Cat3__c c*/ Attendance_Reporting__c at ){
      //>  cat = c;
    	attReport = at;
        checked = false;
    }

/**    public static testMethod void testMe() {

        CategoryWrapper cw = new CategoryWrapper();
        System.assertEquals(cw.checked,false);      

        CategoryWrapper cw2 = new CategoryWrapper(new Cat3__c(name='Test1'));
        System.assertEquals(cw2.cat.name,'Test1');
        System.assertEquals(cw2.checked,false);       

    } **/

}