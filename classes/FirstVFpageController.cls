public class FirstVFpageController {
    
    public List<Product_Table__c> list_prodTable { get; set; }
    
    public FirstVFpageController(){    
    list_prodTable = [SELECT Id, Name, Title__c, Units_Available__c, Product_Description__c, Unit_Price__c, Image_Url__c FROM Product_Table__c];        
    }       
}