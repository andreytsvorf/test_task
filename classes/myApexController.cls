public with sharing class myApexController {
    
    public String pencilBoxName { get; set; }
    
    public List<Pencil__c> list_pencil { get; set; }
    
    public myApexController(){        
        list_pencil= [SELECT Id, Name, CreatedDate, OwnerId, Pencil_Box__c, Pencil_Box__r.Name FROM Pencil__c ];               
    }   
    
    public PageReference updateBoxName() { 
        List<Pencil_Box__c> pencilBoxes = [SELECT Id FROM Pencil_Box__c WHERE Name =: pencilBoxName];
        
        Pencil_Box__c penBox = new Pencil_Box__c();
        if(pencilBoxes.isEmpty()){
            penBox.Name = pencilBoxName;                    
            insert penBox;
        } else {
            penBox = pencilBoxes[0];                           
        }
        
        for(Pencil__c pencils : list_pencil){
            pencils.Pencil_Box__c = penBox.Id;
            pencils.Pencil_Box__r.Name = pencilBoxName;          
        }
        update list_pencil;
        
        return null;
    }
}