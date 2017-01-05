public class ConnectionController {
    public Connection_Request__c conn;
    
    public integer totalRecords = 0;
    public integer OffsetSize = 0;
    public integer LimitSize= 50;
    public integer pagesize{get;set;}
    
    //passing input text values from visualforcepage to the controller
    public String name{get;set;} // input RequestId value  from vf
    public String Request_Type{get;set;} // input RequestType value  from vf
    public String LEW_Name{get;set;} // input LEWName value  from vf
    public String NMI{get;set;} // input NMI value  from vf
    public String Meter_Number{get;set;} // MeterNumber text2 value  from vf
    public String REC_No{get;set;} // input RECNo value  from vf
    public String REC_Name{get;set;} 
    public String Work_Site_Address{get;set;} // input WorkSiteAddress value  from vf
    public String Progress{get;set;} // input Progress value  from vf
    public String Retailer{get;set;}// input Retailer value  from vf
    public String Date_Range{get;set;}// input DateRange value  from vf
    public static String qry='select name,NMI__c,Work_Site_Address__c,Request_Type__c,Date_Range__c,Meter_Number__c,REC_No__c,REC_Name__c,LEW_Name__C,Progress__c,Retailer__c from Connection_Request__c ';
    public string orderby='order by createdDate desc ';
    
    public ApexPages.StandardSetController stdCntrlr{get; set;}
    public ConnectionController(ApexPages.StandardSetController controller) {
        conn = (Connection_Request__c)controller.getRecord();
        this.stdCntrlr = controller;
        totalRecords = [select count() from Connection_Request__c];
        system.debug('inside const totalrecs'+totalRecords);
        pagesize=40;
    }
    
    public ConnectionController() {}
    
    public List<Connection_Request__c> getData()
    {
        system.debug('INSIDE GETDATA');
        List<Connection_Request__c> al = Database.Query(qry+' LIMIT :limitsize  OFFSET :OffsetSize ');
        system.debug('inside getData al.size()='+al.size());
        if(al.size() == 0)
        {
            system.debug('No data available in table');
            // OffsetSize=20;
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'No data available in table');
            ApexPages.addMessage(myMsg); 
        }
        return al;
    }  
    
    //Search Method
    public pageReference Search()
    {
        system.debug('INSIDE SEARCH');
        List<Connection_Request__c> al = Database.Query(qry+' LIMIT :limitsize  OFFSET :OffsetSize ');
        System.debug('name: '+name);
        System.debug('LEW_Name: '+LEW_Name);
        System.debug('NMI: '+NMI);
        System.debug('Work_Site_Address: '+Work_Site_Address);
        System.debug('REC_No: '+REC_No);
        System.debug('REC_Name: '+REC_Name);
        qry=qry+'where Name!=null ';
        if(!String.isEmpty(name))
        {
            qry=qry+'and name=:name ';  
        }
        if(!String.isEmpty(Request_Type))
        {
            qry=qry+'and Request_Type__c=:Request_Type '; 
        }
        if(!String.isEmpty(LEW_Name))
        {
            qry=qry+'and LEW_Name__c=:LEW_Name ';  
        }
        if(!String.isEmpty(NMI))
        {
            qry=qry+'and NMI__c=:NMI ';   
        }
        if(!String.isEmpty(Meter_Number))
        {
            qry=qry+'and Meter_Number__c=:Meter_Number '; 
        }
        if(!String.isEmpty(REC_No))
        {
            qry=qry+'and REC_No__c=:REC_No ';   
        }
        if(!String.isEmpty(REC_Name))
        {
            qry=qry+'and REC_Name__c=:REC_Name ';   
        }
        if(!String.isEmpty(Work_Site_Address))
        {
            qry=qry+'and Work_Site_Address__c=:Work_Site_Address '; 
        }
        if(!String.isEmpty(Progress))
        {
            qry=qry+'and Progress__c=:Progress ';   
        }
        if(!String.isEmpty(Retailer))
        {
            qry=qry+'and Retailer__c=:Retailer ' +orderby;  
        }
       /* if(String.isEmpty(name) && String.isEmpty(Request_Type) &&  String.isEmpty(LEW_Name) && String.isEmpty(NMI) && String.isEmpty(Meter_Number) && String.isEmpty(REC_No)  && String.isEmpty(REC_Name) && String.isEmpty(Work_Site_Address) && String.isEmpty(Progress) && String.isEmpty(Retailer) && String.isEmpty(Date_Range))
        {
            system.debug('Please enter at least  one search field');
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'Please enter at least  one search field');
            ApexPages.addMessage(myMsg); 
        }*/
        List<Connection_Request__c> al2= Database.Query(qry+' LIMIT :limitsize  OFFSET :OffsetSize ');
        //system.debug('inside getData al.size()='+al2.size());
        if(al2.size()==1)
        {
            PageReference pg=new PageReference('/'+al2[0].Id);
            return pg;
        }
        return null;
    }
    
    public PageReference reset() {
        system.debug('INSIDE RESET');
        PageReference newpage = new PageReference(System.currentPageReference().getURL());
        newpage.setRedirect(true);
        return newpage;
    }
    
    Public PageReference Cancel()
    {        
        system.debug('INSIDE CANCEL');
        PageReference pg=New PageReference('http://developer.salesforce.com/');
        return pg;    
    } 
    
    public void previous()
    {
        system.debug('INSIDE PREVIOUS');
        //system.debug('offset check'+OffsetSize+' pagesize:'+pagesize);
        OffsetSize = OffsetSize - pagesize;
        search();
    }
    
    public void next() 
    {
        system.debug('INSIDE NEXT');
        //system.debug('offset check'+OffsetSize+' pagesize:'+pagesize);
        OffsetSize = OffsetSize + pagesize;
        search();
    }
    
    public Boolean getDisablePrevious() { 
        system.debug('INSIDE getDisablePrevious');
        System.debug('offset: '+OffsetSize+' pagesize: '+pagesize+' totalRec: '+totalRecords);
        //this will disable the previous and beginning buttons
        if (OffsetSize>0) 
            return false;
        else 
            return true;
    }
    
    public Boolean getDisableNext() { //this will disable the next and end buttons
        system.debug('INSIDE getDisableNext');
        System.debug('offset: '+OffsetSize+' pagesize: '+pagesize+' totalRec: '+totalRecords);
        //pagesize=2;
        if (OffsetSize + pagesize < totalRecords) 
            return false; 
        else 
            return true;
    }
    
    public void FirstPage()
    {
        system.debug('INSIDE FirstPage');
        search();
        system.debug('offset check: '+OffsetSize+' pagesize: '+pagesize);
        OffsetSize =0;
    }
    
    public void LastPage()
    {
        system.debug('INSIDE LastPage');
        search();
        system.debug('offset check: '+OffsetSize+' pagesize: '+pagesize);
        OffsetSize = totalrecords - math.mod(totalRecords, pagesize); 
    }
    
    public Integer getTotal_size()
    {
        system.debug('INSIDE getTotal_size');
        system.debug('offset check: '+OffsetSize+' pagesize: '+pagesize+' totalrecords check: '+totalRecords);
        return totalRecords;
    }
    
    public Integer getPageNumber() 
    {
        system.debug('INSIDE getPageNumber');
        system.debug('offset check: '+OffsetSize+' pagesize: '+pagesize+' LimitSize check: '+LimitSize);
        return OffsetSize/pagesize + 1;
    }
    
    public Integer getTotalPages() 
    {
        system.debug('INSIDE getTotalPages');
        system.debug('totalRecords: '+totalRecords+' pagesize: '+pagesize+' LimitSize check: '+LimitSize);
        if (math.mod(totalRecords, pagesize) > 0) {
            return totalRecords/pagesize + 1;
        } else {
            return (totalRecords/pagesize);
        }
    }
}