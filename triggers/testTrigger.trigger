trigger testTrigger on Product_Table__c (before insert) {
    
    testTriggerHandler.hdl(Trigger.new);
    
    
    
}