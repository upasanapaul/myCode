@istest
public class ConnectionControllerTestClass {
    private Connection_request__c conn;  
    
    static testmethod void testSearch(){
        test.startTest();
        //Connection_request__c b =[select Request_Type__c , LEW_Name__c  from Connection_request__c where request_id__c = 'CN-0001'];
        //   Create dummy data for test purposes.
        Connection_request__c b = new Connection_request__c();
        b.Request_Type__c = 'Alteration';
        b.LEW_Name__c = 'dgf';
        b.NMI__c = '53';
        b.Meter_Number__c = '525';
        b.REC_No__c = '5';
        b.Work_Site_Address__c = 'mumbai';
        b.Progress__c = 'Draft';
        b.Retailer__c = 'wsdd';
        insert b;
        system.debug(b);
        PageReference pageRef =page.convpf; 
        test.setcurrentpage(pageRef);
        ConnectionController crExt = new  ConnectionController();
        PageReference Pref = crExt.search();
        List<Connection_request__c> testsearchResults=new List<Connection_request__c>();
        Connection_request__c testopp;
        testsearchResults.add(testopp);
        test.stopTest();
    }
    
    static testmethod void cancel()
    {
        Connection_request__c b = new Connection_request__c();
        b.Request_Type__c = 'Alteration';
        b.LEW_Name__c = 'dgf';
        b.NMI__c = '53';
        b.Meter_Number__c = '525';
        b.REC_No__c = '5';
        b.Work_Site_Address__c = 'mumbai';
        b.Progress__c = 'Draft';
        b.Retailer__c = 'wsdd';
        insert b;
        system.debug(b);
        PageReference pageRef =page.convpf; 
        test.setcurrentpage(pageRef);
        ConnectionController cr = new ConnectionController();
        String cancel=cr.cancel().getUrl();
        System.assertEquals('http://developer.salesforce.com/',cancel);
    }
    
    static testmethod void next()
    {
        Connection_request__c testBox = new Connection_request__c(NMI__c = 'Test',Work_Site_Address__c = 'NA13',Meter_Number__c='60', Retailer__c='Something');
        insert testBox;
        PageReference pageRef = Page.convpf;
        Test.setCurrentPage(pageRef);
        Test.startTest();
        ConnectionController controller = new ConnectionController();
        controller.pagesize=2;
        controller.offsetsize=0;
        controller.next();
        Test.stopTest();
        system.assertEquals(2, controller.OffsetSize);
    }
    
    static testmethod void previous()
    {
        Connection_request__c testBox = new Connection_request__c(NMI__c = 'Test',Work_Site_Address__c = 'NA13',Meter_Number__c='60', Retailer__c='Something');
        insert testBox;
        PageReference pageRef = Page.convpf;
        Test.setCurrentPage(pageRef);
        Test.startTest();
        ConnectionController controller = new ConnectionController();
        controller.pagesize=2;
        controller.offsetsize=4;
        controller.previous();
        Test.stopTest();
        system.assertEquals(2, controller.OffsetSize);
    }
    
    static testmethod void firstpage()
    {
        Connection_request__c testBox = new Connection_request__c(NMI__c = 'Test',Work_Site_Address__c = 'NA13',Meter_Number__c='60', Retailer__c='Something');
        insert testBox;
        PageReference pageRef = Page.convpf;
        Test.setCurrentPage(pageRef);
        Test.startTest();
        ConnectionController controller = new ConnectionController();
        controller.pagesize=2;
        controller.offsetsize=4;
        controller.firstpage();
        Test.stopTest();
        system.assertEquals(0, controller.OffsetSize);
    }
    
    static testmethod void lastpage()
    {
        Connection_request__c testBox = new Connection_request__c(NMI__c = 'Test',Work_Site_Address__c = 'NA13',Meter_Number__c='60', Retailer__c='Something');
        insert testBox;
        PageReference pageRef = Page.convpf;
        Test.setCurrentPage(pageRef);
        Test.startTest();
        ConnectionController controller = new ConnectionController();
        controller.pagesize=2;
        controller.offsetsize=4;
        controller.lastpage();
        Test.stopTest();
        system.assertEquals(0, controller.OffsetSize);
    }
    
    static testmethod void getDisablePrevious1()
    {
        Test.StartTest(); 
        PageReference pageRef = Page.convpf;  
        Test.setCurrentPage(pageRef);
        // Instantiate a new controller with all parameters in the page
        ConnectionController  p=new ConnectionController ();
        p.pagesize=40;
        p.getDisablePrevious();
        Test.StopTest();
    }
    
    static testmethod void getDisablePrevious2()
    {
        Test.StartTest(); 
        PageReference pageRef = Page.convpf;  
        Test.setCurrentPage(pageRef);
        // Instantiate a new controller with all parameters in the page
        ConnectionController  p=new ConnectionController ();
        p.pagesize=40;
        p.OffsetSize=2;
        p.getDisablePrevious();
        Test.StopTest();
    }
    
    static testmethod void getDisableNext1()
    {
        Test.StartTest(); 
        PageReference pageRef = Page.convpf;  
        Test.setCurrentPage(pageRef);
        // Instantiate a new controller with all parameters in the page
        ConnectionController  p=new ConnectionController ();
        p.pagesize=40;
        p.getDisableNext();
        Test.StopTest();
    }
    
    static testmethod void getDisableNext2()
    {
        Test.startTest();
        PageReference pageRef = Page.convpf;
        Test.setCurrentPage(pageRef);
        ConnectionController controller = new ConnectionController();
        controller.totalRecords=3;
        controller.pagesize=2;
        controller.offsetsize=0;
        controller.getDisableNext();
        system.assertEquals(0, controller.OffsetSize);
        system.assertEquals(3, controller.totalRecords );
        Test.stopTest();
    }
    
    static testmethod void getTotal_size()
    {
        test.startTest();
        PageReference pageRef = Page.convpf;
        Test.setCurrentPage(pageRef);
        Connection_request__c testBox = new Connection_request__c(NMI__c = 'Test',Work_Site_Address__c = 'NA13',Meter_Number__c='60', Retailer__c='Something');
        insert testBox;
        system.debug('++++++++'+testBox);
        ConnectionController controller = new ConnectionController();
        controller.pagesize=2;
        controller.offsetsize=4;
        controller.getTotal_size();
        test.stopTest();
    }
    
    static testmethod void getPageNumber()
    {
        Test.StartTest(); 
        PageReference pageRef = Page.convpf;  
        Test.setCurrentPage(pageRef);
        // Instantiate a new controller with all parameters in the page
        ConnectionController  p=new ConnectionController ();
        p.pagesize=40;
        p.getPageNumber();
        Test.StopTest();
    }
    
    static testmethod void getTotalPages1()
    {
        Test.StartTest(); 
        PageReference pageRef = Page.convpf; 
        Test.setCurrentPage(pageRef);
        // Instantiate a new controller with all parameters in the page
        ConnectionController  p=new ConnectionController ();
        p.pagesize=40;
        p.getTotalPages();
        Test.StopTest();
    }
    
    static testmethod void getTotalPages2()
    {
        Test.StartTest(); 
        PageReference pageRef = Page.convpf; 
        Test.setCurrentPage(pageRef);
        // Instantiate a new controller with all parameters in the page
        ConnectionController  p=new ConnectionController ();
        p.totalRecords=20;
        p.pagesize=3;
        p.getTotalPages();
        Test.StopTest();
    }
    
    static testmethod void getdataWithEntry()
    {
        Connection_request__c testBox = new Connection_request__c(NMI__c = 'Test',Work_Site_Address__c = 'NA13',Meter_Number__c='60', Retailer__c='Something');
        insert testBox;
        PageReference pageRef = Page.convpf;
        Test.setCurrentPage(pageRef);
        Test.startTest();
        ConnectionController controller = new ConnectionController();
        List<Connection_Request__c> results=controller.getdata();
        Test.stopTest();
        system.assertEquals(1, results.size());
        system.assertEquals(testBox.Work_Site_Address__c, results[0].Work_Site_Address__c);
    }
    
    static testmethod void getdataWithoutEntry()
    {
        //Connection_request__c testBox = new Connection_request__c(NMI__c = 'Test',Work_Site_Address__c = 'NA13',Meter_Number__c='60', Retailer__c='Something');
        //insert testBox;
        PageReference pageRef = Page.convpf;
        Test.setCurrentPage(pageRef);
        Test.startTest();
        ConnectionController controller = new ConnectionController();
        List<Connection_Request__c> results=controller.getdata();
        Test.stopTest();
        system.assertEquals(0, results.size());
        //system.assertEquals(testBox.Work_Site_Address__c, results[0].Work_Site_Address__c);
    }
    
    static testmethod void testreset()
    {
        Connection_request__c b = new Connection_request__c();
        b.Request_Type__c = 'Alteration';
        b.LEW_Name__c = 'dgf';
        b.NMI__c = '53';
        b.Meter_Number__c = '525';
        b.REC_No__c = '5';
        b.Work_Site_Address__c = 'mumbai';
        b.Progress__c = 'Draft';
        b.Retailer__c = 'wsdd';
        insert b;
        system.debug(b);
        PageReference pageRef =page.convpf; 
        test.setcurrentpage(pageRef);
        ConnectionController cr = new ConnectionController();
        String nextPage=cr.reset().getUrl();
        System.assertEquals('/apex/convpf',nextPage);
    } 
}