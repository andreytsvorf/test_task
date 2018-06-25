public with sharing class ProdTableController{
   
   public Contact cont {get;set;}
   public Order_Table__c orderTable {get;set;}
   
   public ProdTableController(){
        cont = new Contact();
        orderTable = new Order_Table__c();
   }

   
  public  Product_Table__c getProdTable() {
     List <Product_Table__c> products = [SELECT Id, Name, Image_Url__c, Unit_price__c, Title__c, Product_Description__c FROM Product_Table__c
               WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
     
      if(products.size()>0) return products.get(0);
      return new Product_Table__c() ;
   }
   
   public Contact getcont(){  
       return cont;
   }
   public Order_Table__c getorderTable(){  
       return orderTable;
   }
   
   public PageReference save(){
       List<Contact> ContactUsers = [SELECT Id, FirstName, LastName From Contact Where Email=:cont.Email];
       /*  if(!ContactUsers.isEmpty()){
                ContactUsers[0].FirstName = cont.FirstName;  
                ContactUsers[0].LastName = cont.LastName; 
            } else{
            ContactUsers.add(new Contact(FirstName = cont.FirstName, LastName = cont.LastName, Email = cont.Email));
        }*/
       if(!ContactUsers.isEmpty()){
           for(Contact ContactUser : ContactUsers){        
               ContactUser.FirstName = cont.firstName;  
               ContactUser.LastName = cont.lastName;  
           }
       }else{
           ContactUsers.add(new Contact(FirstName = cont.firstName, LastName = cont.lastName, Email = cont.Email));
       }
       upsert ContactUsers;
       
 //      List<Order_Table__c> OrderTables = [SELECT Id, FirstName, LastName From Contact Where Email=:cont.Email];
       
       
    /* System.debug('=>'+JSON.serialize(ContactUsers)); отладчик по значению http://jsonviewer.stack.hu/
       System.debug('=>'+JSON.serialize(cont));*/        
     /* PageReference acctPage = new PageReference('Hello');
       acctPage.setRedirect(true)*/
       return null;
   }

}