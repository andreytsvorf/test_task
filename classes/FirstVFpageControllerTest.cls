@isTest
private class FirstVFpageControllerTest {
    
    @isTest static void testProduct() {
        Org_Configuration__c orgConfig = Org_Configuration__c.getInstance();
        orgConfig.Period_Term__c = 12 ;
        insert orgConfig;
        
        Product_Table__c product = new Product_Table__c (
          Name='Samsung',
          Title__c = 'asdasdasdasd',                                                     
          Product_Description__c = 'asdasdasdaskjlkjlkj kljdflkjgdflkj fdjklfdjglkj jkhkjfdhgjkdfhkj',
          Added_Date__c = Date.Today()
        );
        insert product;
        
        FirstVFPageController testController = new FirstVFPageController();
        
        List<Product_Table__c> expectedProdTable = [
          SELECT Id, Name, Title__c, Units_Available__c, Product_Description__c, Unit_Price__c, Image_Url__c 
          FROM Product_Table__c
        ];

        
        System.assertEquals(expectedProdTable.size(), testController.list_prodTable.size());                       
    }                             
}