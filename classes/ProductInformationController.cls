public class ProductInformationController {
    
    public Product_Table__c getProductById() {
        List<Product_Table__c> products = [SELECT Id, Name, Title__c, Product_Description__c, Unit_Price__c, Image_Url__c FROM Product_Table__c
                                           WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
        if(products.size() > 0) return products.get(0);
        return new Product_Table__c(Name='New Product');        
    }
    
    public PageReference saveData() {        
        PageReference newVFPage = new PageReference('/apex/FormBuyProductsVFPage?id=' + ApexPages.currentPage().getParameters().get('Id'));       
        newVFPage.setRedirect(true);
        return newVFPage;        
    }             
    
}