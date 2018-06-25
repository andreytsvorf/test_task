public class CreateOrderController {
    
    public Product_Table__c product { get; set; } 
    List <Product_Table__c> products { get; set; }
    public Order_Table__c orderTable { get; set; }    
    public Contact contact { get; set; }
    public List<Contact> ContactUsers {get; set; }
    public Order_Table__c newOrderTable = new Order_Table__c();
    
    public  CreateOrderController(){
        getProdTable();        
        if( products.isEmpty()){            
            ApexPages.addMessage(
              new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.order_is_not_created )
            );            
        }                    
        orderTable = new Order_Table__c();        
        contact = new Contact();              
    }          
    
    public Product_Table__c getProdTable() {
        products = [
          SELECT Id, Name, Title__c, Product_Description__c, Units_Available__c, Unit_Price__c, Image_Url__c 
          FROM Product_Table__c
          WHERE Id = :ApexPages.currentPage().getParameters().get('Id')
        ];        

            product = products.get(0);
            return product;
                    	                   
    }
    
    public PageReference createOrder(){
        ContactUsers = [
          SELECT Id, FirstName, LastName 
          FROM Contact 
          WHERE Email=:contact.Email
        ];
        if(!ContactUsers.isEmpty()){
            for(Contact ContactUser : ContactUsers){        
                ContactUser.FirstName = contact.FirstName;  
                ContactUser.LastName = contact.LastName;  
            }
        }else{
            ContactUsers.add(new Contact(
              FirstName = contact.FirstName, 
              LastName = contact.LastName, 
              Email = contact.Email
            )
            );
        }
        upsert ContactUsers;
        
        orderTable.Order_Amount__c = orderTable.Units__c * product.Unit_Price__c;
        Order_Table__c newOrderTable = new Order_Table__c(
          Units__c = orderTable.Units__c,
          Contact__c = ContactUsers[0].Id,
          Product__c = product.Id,
          Order_Amount__c = orderTable.Order_Amount__c
        );
        
        if(product.Units_Available__c > 0 && ( product.Units_Available__c - orderTable.Units__c ) >= 0 ){
            product.Units_Available__c -= orderTable.Units__c;
            
            ApexPages.addMessage(
              new ApexPages.Message(ApexPages.Severity.INFO, System.Label.OrderCompleted )
            );
            upsert product;
        } else {
            ApexPages.addMessage(
              new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.order_is_not_created )
            );                       
        }
        
        insert orderTable;        
        return null;
    }  
    
}