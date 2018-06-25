Public class MyController{
    public String userInput{get;set;}
    
    public PageReference doSubmit(){
        if(userInput==NULL || userInput=='' ){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Fail'));
            
        }
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Pass'));
        }
        
        return null;
    }
}