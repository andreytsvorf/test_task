public class AccountExtension {
    /**
* The variable that stores the Account details
*
* @var Account
*/
    
    private final Account record;
    
    /**
* Contructor. Takes a standard controller variable and assigns it to the record
*
* @param ApexPages.StandardController stdController
*/
    
    public AccountExtension(ApexPages.StandardController stdController) {
        this.record = (Account)stdController.getRecord();
    }
    

 
}