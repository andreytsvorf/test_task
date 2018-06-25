@isTest
public class CreateOrderControllerTest {

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

      List<Product_Table__c> expectedListProdTable = [
        SELECT Id, Name, Title__c, Units_Available__c, Product_Description__c, Unit_Price__c, Image_Url__c 
        FROM Product_Table__c
        WHERE Id = :ApexPages.currentPage().getParameters().get('Id')
      ];

      Product_Table__c expectedProduct = expectedListProdTable.get(0);  

      CreateOrderController prodDescCntr = new CreateOrderController();
      Product_Table__c actualdProduct = prodDescCntr.getProdTable();      

      System.assertEquals(expectedProduct, actualdProduct);

      Test.stopTest();

  }  



    @isTest static void testCreateOrderPositive () {

     List<Contact> testListContact = new List<Contact>{
        new Contact(
          FirstName = 'Andrew',
          LastName = 'Tsvor',
          Email = 'andre@tsbo.com'
        ),
        new Contact(
          FirstName = 'Dmitry',
          LastName = 'Tsvorik',
          Email = 'andre@tsbo.com'
        )
      };   

      insert testListContact; 

      Org_Configuration__c orgConfig = Org_Configuration__c.getInstance();
      orgConfig.Period_Term__c = 12 ;
      insert orgConfig;

      Product_Table__c testProduct = new Product_Table__c (
        Unit_Price__c = 200,
        Units_Available__c = 20,
        Name='Samsung',
        Title__c = 'asdasdasdasd',                                                     
        Product_Description__c = 'asdasdasdaskjlkjlkj kljdflkjgdflkj fdjklfdjglkj jkhkjfdhgjkdfhkj',
        Added_Date__c = Date.Today()
      );
      insert testProduct;

      ApexPages.CurrentPage().getParameters().put('id', testProduct.Id);

      Test.startTest();

      CreateOrderController testCreateOrderController = new CreateOrderController();
      // The client write a data
      testCreateOrderController.contact.Email = 'andre@tsbo.com'; 
      testCreateOrderController.contact.FirstName = 'andre@tsbo.com';
      testCreateOrderController.contact.LastName = 'andre@tsbo.com';
      testCreateOrderController.orderTable.Units__c = 3;

      testCreateOrderController.createOrder(); 

      Order_Table__c testOrderTable = testCreateOrderController.orderTable;

      List<Order_Table__c> expectedListOrderTable = [
        SELECT Units__c, Contact__c, Order_Amount__c   
        FROM Order_Table__c
      ];
      Order_Table__c expectedOrderTable = expectedListOrderTable.get(0);
             
      System.assertEquals(expectedOrderTable.Units__c, testOrderTable.Units__c);

      Test.stopTest();

    
    }

}


  /*   @isTest static void testCreateOrderNegative() {

      Org_Configuration__c orgConfig = Org_Configuration__c.getInstance();
      orgConfig.Period_Term__c = 12 ;
      insert orgConfig;

      Product_Table__c testProduct = new Product_Table__c (
        Units_Available__c = 20,
        Name='Samsung',
        Title__c = 'asdasdasdasd',                                                     
        Product_Description__c = 'asdasdasdaskjlkjlkj kljdflkjgdflkj fdjklfdjglkj jkhkjfdhgjkdfhkj',
        Added_Date__c = Date.Today()
      );
      insert testProduct;

      ApexPages.CurrentPage().getParameters().put('id', testProduct.Id);

      Test.startTest();

      CreateOrderController testCreateOrderController = new CreateOrderController();
      testCreateOrderController.contact.Email = 'andre@tsbo.com'; 
      testCreateOrderController.contact.FirstName = 'andre@tsbo.com';
      testCreateOrderController.contact.LastName = 'andre@tsbo.com';
      testCreateOrderController.orderTable.Units__c = 3; 

      testCreateOrderController.createOrder();
      
      Contact actualContact = testCreateOrderController.ContactUsers.get(0);
      
      System.debug( actualContact);

      List<Contact> expectedListContact = [
        SELECT FirstName, LastName, Email
        FROM Contact
        WHERE Email = :testCreateOrderController.contact.Email 
      ];

        Contact expectedContact = expectedListContact.get(0);
     
      System.assertEquals(expectedContact, actualContact);

      Test.stopTest();
      }

     }   */

/*
     @isTest static void testCreateOrderInspectOrderTable() {

      Org_Configuration__c orgConfig = Org_Configuration__c.getInstance();
      orgConfig.Period_Term__c = 12 ;
      insert orgConfig;

      Product_Table__c testProduct = new Product_Table__c (
        Unit_Price__c = 200,
        Units_Available__c = 20,
        Name='Samsung',
        Title__c = 'asdasdasdasd',                                                     
        Product_Description__c = 'asdasdasdaskjlkjlkj kljdflkjgdflkj fdjklfdjglkj jkhkjfdhgjkdfhkj',
        Added_Date__c = Date.Today()
      );
      insert testProduct;

      ApexPages.CurrentPage().getParameters().put('id', testProduct.Id);

      Test.startTest();

      CreateOrderController testCreateOrderController = new CreateOrderController();
      testCreateOrderController.contact.Email = 'andre@tsbo.com'; 

      testCreateOrderController.createOrder();
      
      List<Contact> actual_listContact = testCreateOrderController.ContactUsers;
      
      System.debug( actual_listContact);

      List<Contact> expected_listContact = [
        SELECT FirstName, LastName, Email
        FROM Contact
        WHERE Email = :testCreateOrderController.contact.Email 
      ];

       if(!expected_listContact.isEmpty()){
            for(Contact ContactUser : expected_listContact){        
                ContactUser.FirstName = testCreateOrderController.contact.FirstName;  
                ContactUser.LastName = testCreateOrderController.contact.LastName;  
            }
        }else{
              expected_listContact.add(new Contact(
              FirstName = testCreateOrderController.contact.FirstName, 
              LastName = testCreateOrderController.contact.LastName, 
              Email = testCreateOrderController.contact.Email
            )
            );
        }
     

            
      testCreateOrderController.orderTable.Units__c = 3;
      Order_Table__c testOrderTable = testCreateOrderController.orderTable;

      
      testOrderTable.Order_Amount__c = testOrderTable.Units__c * testProduct.Unit_Price__c; 
      
      Order_Table__c expectedOrderTable =  new Order_Table__c(
          Units__c = 12,
          Contact__c = expected_listContact[0].Id,
          Product__c = testProduct.Id,
          Order_Amount__c = testOrderTable.Order_Amount__c
      );
      insert expectedOrderTable;

      Order_Table__c actualOrderTable = testCreateOrderController.newOrderTable;

      System.assertEquals(expectedOrderTable, actualOrderTable);

      Test.stopTest();  */


     //  if (testProduct.Units_Available__c > 0 && ( testProduct.Units_Available__c - testOrderTable.Units__c ) >= 0 ){
      //      testProduct.Units_Available__c -= testOrderTable.Units__c;

       //     upsert testProduct;
       //     insert testOrderTable;


   // System.assertEquals(testOrderTable, actual_listContact.size());

   // } 
             
  
