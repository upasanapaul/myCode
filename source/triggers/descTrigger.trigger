trigger descTrigger on Account (before insert, before update) {
     
    if(trigger.isInsert){
        for (account a: trigger.new){  
        a.description='hello' + a.Name;     
        }
     }

    if(trigger.isUpdate){
        for (account acc: trigger.new){  
        acc.description='Your Account is updeted.' + acc.Name;
           
        }
       
    }
        
}