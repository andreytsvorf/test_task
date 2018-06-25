public with sharing class ProductTableController {
    
    public List<Product_Table__c> list_prodTable { get; set; }
    
    public ProductTableController(){
        list_prodTable = [SELECT Id, Name, Title__c, Product_Description__c, Unit_Price__c, Image_Url__c FROM Product_Table__c];
                       
// hjhjkhdkjfhkhk
       for(Product_Table__c prod : list_prodTable){
           if(prod.Product_Description__c.length() > 100){
                prod.Product_Description__c = prod.Product_Description__c.left(100) + '...' ;
           }
       }
    }

}