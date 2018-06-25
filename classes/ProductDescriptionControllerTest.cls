@isTest
private class  ProductDescriptionControllerTest {
    
    @isTest static void testSaveData () {
        
      Org_Configuration__c orgConfig = Org_Configuration__c.getInstance();
      orgConfig.Period_Term__c = 12 ;
      insert orgConfig;
        
      Product_Table__c testProduct = new Product_Table__c (
        Name='Samsung',
        Title__c = 'asdasdasdasd',                                                     
        Product_Description__c = 'asdasdasdaskjlkjlkj kljdflkjgdflkj fdjklfdjglkj jkhkjfdhgjkdfhkj',
        Added_Date__c = Date.Today()
      );

      insert testProduct;
        
      ApexPages.CurrentPage().getParameters().put('id', testProduct.Id);
      Test.startTest();
      PageReference pageRef = new PageReference (
        '/apex/FormBuyProductsVFPage?id=' + ApexPages.currentPage().getParameters().get('Id')
      );      
        
      ProductDescriptionController prodDescCntr = new ProductDescriptionController();
      PageReference newPageRef = prodDescCntr.saveData();
        
      System.assertEquals ( pageRef.getUrl() , newPageRef.getUrl() );
      Test.stopTest();
    }






    @isTest static void testGetProdTable () {      

      Org_Configuration__c orgConfig = Org_Configuration__c.getInstance();
      orgConfig.Period_Term__c = 12 ;
      insert orgConfig;

      Product_Table__c testProduct = new Product_Table__c (
        Name='Samsung',
        Title__c = 'asdasdasdasd',                                                     
        Product_Description__c = 'asdasdasdaskjlkjlkj kljdflkjgdflkj fdjklfdjglkj jkhkjfdhgjkdfhkj',
        Added_Date__c = Date.Today()
      );
      insert testProduct;

      ApexPages.CurrentPage().getParameters().put('id', testProduct.Id);

      Test.startTest();

      List<Product_Table__c> expectedlistProdTable = [
        SELECT Id, Name, Title__c, Units_Available__c, Product_Description__c, Unit_Price__c, Image_Url__c 
        FROM Product_Table__c
        WHERE Id = :ApexPages.currentPage().getParameters().get('Id')
      ];

      Product_Table__c expectedProduct = expectedlistProdTable.get(0);  

      ProductDescriptionController prodDescCntr = new ProductDescriptionController();
      Product_Table__c actualdProduct = prodDescCntr.getProdTable();      

      System.assertEquals(expectedProduct, actualdProduct);

      Test.stopTest();

    }  
}