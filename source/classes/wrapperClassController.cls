public class wrapperClassController 
{
    //Our collection of the class/wrapper objects cContact 
  	public List<jJobApplication> jobAppList {get; set;}
  	//This method uses a simple SOQL query to return a List of Contacts
  	public List<jJobApplication> getJobApps() 
    {
    	if(jobAppList == null) 
        {
            jobAppList = new List<jJobApplication>();
            for(Job_Application__c j: [select Id,Candidate__c,Status__c,Cover_Letter__c,Position__c 
                                           from Job_Application__c where Position__c = null ])
            {
                // As each contact is processed we create a new cContact object and add it to the contactList
                jobAppList.add(new jJobApplication(j));
            }
        }
        return jobAppList;
     }
 	 public PageReference processSelected() 
     {      
         //We create a new list of Contacts that we be populated only with Contacts if they are selected
   		 List<Job_Application__c> selectedJobApps = new List<Job_Application__c>();
   		 //We will cycle through our list of cContacts and will check to see if the selected property is set to true, if it is we add the Contact to the selectedContacts list
   		 for(jJobApplication jJob: getJobApps())
         {
     		 if(jJob.selected == true) 
             {
               	 jJob.job.Position__c=ApexPages.currentPage().getParameters().get('id');
               	 System.debug(ApexPages.currentPage().getParameters().get('id'));
                 
       			 selectedJobApps.add(jJob.job);
      		}
   		 }
   		 // Now we have our list of selected contacts and can perform any type of logic we want, sending emails, updating a field on the Contact, etc
    	 System.debug('These are the selected Contacts...');
       	 Database.SaveResult[] dr=Database.update(selectedJobApps);
   		 for(Job_Application__c job: selectedJobApps)
         {
             system.debug(job);
   		 }
    	jobAppList=null; // we need this line if we performed a write operation  because getContacts gets a fresh list now
   
   	    Job_Application__c job  =  new Job_Application__c();
        
        PageReference pageRef = new ApexPages.StandardController(job).view();
        pageRef.setRedirect(true);
        return pageRef;
     }
      public PageReference Cancel() 
      {
          Job_Application__c job  =  new Job_Application__c();
          PageReference pageRef = new ApexPages.StandardController(job).view();
          pageRef.setRedirect(true);
          return pageRef;
          return null;      
      }
    
      public PageReference selectAll() 
      {
          List<Job_Application__c> selectAll = new List<Job_Application__c>();
          for(jJobApplication jJob: getJobApps()) 
          {
              jJob.selected=true; 
              selectAll.add(jJob.job);
          }
          update selectAll;
          return null;      
      }
      // This is our wrapper/container class. A container class is a class, a data structure, or an abstract data type whose instances are collections of other objects. In this example a wrapper class contains both the standard salesforce object Contact and a Boolean value
      public class jJobApplication 
      {
          public Job_Application__c job {get; set;}
          public Boolean selected {get; set;}
        
          //This is the contructor method. When we create a new cContact object we pass a Contact that is set to the con property. We also set the selected value to false
          public jJobApplication(Job_Application__c j) 
          {
              job = j;   
              selected = false;
          }
      }
}