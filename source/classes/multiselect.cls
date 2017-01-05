public class multiselect {
    Public List<string> leftToRightArrow{get;set;}
    Public List<string> rightToLeftArrow{get;set;}
    public List<SelectOption> availableProjects{get; set;}
    public List<SelectOption> assignedProjects{get; set;}
    public List<SelectOption> oldProj{get; set;}
    List<Project_Account__c> deleteRec;
    public String eId;
    list<string> projectIds;
    
    public multiselect(){
        leftToRightArrow = new List<String>();
        rightToLeftArrow = new List<String>();
        eId = ApexPages.currentPage().getParameters().get('eId');
        assignedProjects = new List<SelectOption>();
        availableProjects = new List<SelectOption>();
        projectIds=new list<string>();
        for(Assignment_Detail__c c : [select id,Name, Project_Accounts__c, Project_Accounts__r.name, Project_Accounts__r.Project_Code__c, Employees__c from Assignment_Detail__c WHERE (Project_Accounts__r.Active__c =: 'Active' and Employees__c =:eid)])
        {
            assignedProjects.add(new SelectOption(c.Project_Accounts__c, c.Project_Accounts__r.name));
            projectIds.add(c.Project_Accounts__c);
        }
        List<Project_Account__c> pAcc = [SELECT Id,Name FROM Project_Account__c WHERE Id NOT IN: projectIds AND Active__c=:'Active'];
        System.debug('****pacc***'+pAcc);
        for(Project_Account__c pa: pAcc){
            availableProjects.add(new SelectOption(pa.Id, pa.Name));
        }
        system.debug('deleteRec'+deleteRec);
        system.debug('assignedProjects'+assignedProjects);
        system.debug('rightToLeftArrow'+rightToLeftArrow);
        system.debug('availableProjects'+availableProjects);
        system.debug('leftToRightArrow'+leftToRightArrow);
        
    }
    
    public PageReference LeftSideList(){
        System.debug('*****leftToRightArrow***'+leftToRightArrow);
        if(!leftToRightArrow.isEmpty()){
            List<Project_Account__c> pac = [SELECT Id,Name FROM Project_Account__c WHERE Id IN: leftToRightArrow AND Active__c=:'Active'];
            for(Project_Account__c pa : pac){
                assignedProjects.add(new SelectOption(pa.Id, pa.Name));
                projectIds.add(pa.Id);
            }
        }
        for(Integer j=0; j<availableProjects.size();j++){
            for(Integer i=0; i<leftToRightArrow.size();i++){
                if(availableProjects[j].getValue() == leftToRightArrow[i]){
                    System.debug('****availableProjects.size()**'+availableProjects.size());
                    availableProjects.remove(j);
                }
            }
        }
        system.debug('assignedProjects'+assignedProjects);
        system.debug('rightToLeftArrow'+rightToLeftArrow);
        system.debug('availableProjects'+availableProjects);
        system.debug('leftToRightArrow'+leftToRightArrow);
        return null;
    }
    
    public PageReference RightSideList(){
        List<String>pId = new List<String>();
        System.debug('*****leftToRightArrow***'+rightToLeftArrow);
        if(!rightToLeftArrow.isEmpty()){
            List<Project_Account__c> pac = [SELECT Id,Name FROM Project_Account__c WHERE Id IN: rightToLeftArrow AND Active__c=:'Active'];
            for(Project_Account__c pa : pac){
                availableProjects.add(new SelectOption(pa.Id, pa.Name));
                pId.add(pa.Id);
            }
        }
        for(Integer j=0; j<assignedProjects.size();j++){
            for(Integer i=0; i<rightToLeftArrow.size();i++){
                if(assignedProjects[j].getValue() == rightToLeftArrow[i]){
                    assignedProjects.remove(j);
                }
            }
        }
        system.debug('assignedProjects'+assignedProjects);
        system.debug('rightToLeftArrow'+rightToLeftArrow);
        system.debug('availableProjects'+availableProjects);
        system.debug('leftToRightArrow'+leftToRightArrow);
        return null;
    }
    
    public pagereference saveButton(){
        system.debug('assignedProjects in SAVE'+assignedProjects);
        system.debug('leftToRightArrow'+leftToRightArrow);
        system.debug('rightToLeftArrow'+rightToLeftArrow);
        
        List<Assignment_Detail__c> c = new List<Assignment_Detail__c>();
        c = [select id,Name, Project_Accounts__c, Employees__c from Assignment_Detail__c WHERE Employees__c =:eid];
        delete c;
        c = new List<Assignment_Detail__c>();
        for(SelectOption sc: assignedProjects){
            Assignment_Detail__c assignDetail = new Assignment_Detail__c();
            assignDetail.Employees__c = eId;
            assignDetail.Project_Accounts__c = sc.getValue();
            c.add(assignDetail);
        }
        insert c;
        PageReference pageRef = new PageReference('/apex/EmplControllerPage');
            return pageRef;
        return null;
    }
    
    public PageReference cancelButton(){
        PageReference pageRef = new PageReference('/apex/EmplControllerPage');
            return pageRef;
    }
    
}