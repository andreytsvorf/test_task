public class ProductDescriptionController { 
          
  public PageReference saveData() {        
      PageReference newVFPage = new PageReference('/apex/FormBuyProductsVFPage?id=' + ApexPages.currentPage().getParameters().get('Id'));       
      newVFPage.setRedirect(true);
      return newVFPage;        
  }            
  
  public Product_Table__c getProdTable() {
      
      Product_Table__c product = new Product_Table__c(Name='New Product');
      
      List<Product_Table__c> products = [SELECT Id, Name, Title__c, Product_Description__c, Units_Available__c, Unit_Price__c, Image_Url__c FROM Product_Table__c
                                          WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
      
      if(products.size() > 0){
          product = products.get(0);            
      }  
      return product;  
  }
}