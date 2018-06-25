public class testTriggerHandler {
    public static void hdl(List<Product_Table__c> productTables){
        List<Date> addedDates = new List<Date>();
        for (Product_Table__c productTable : productTables) { 
            addedDates.add(productTable.Added_Date__c);
        }
        List<Warehouse__c> warehouses = [SELECT Id, Period_End__c, Period_Start__c FROM Warehouse__c 
                                         WHERE Period_Start__c <=: addedDates AND Period_End__c >=: addedDates];
        Map<Product_Table__c, Warehouse__c> productTableIdsByWarehouses = new Map<Product_Table__c, Warehouse__c>();
        Org_Configuration__c orgConfig = Org_Configuration__c.getInstance();
        for (Product_Table__c productTable : productTables) {
            Boolean isWarehouseExist = false;
            for (Warehouse__c warehouse : warehouses) {
                if (warehouse.Period_Start__c <= productTable.Added_Date__c && warehouse.Period_End__c >= productTable.Added_Date__c) {
                    productTable.Warehouse__c = warehouse.Id;
                    isWarehouseExist = true;
                    break;
                }
            }
            if (!isWarehouseExist) {
                productTableIdsByWarehouses.put(
                    productTable,
                    new Warehouse__c(Name = 'Warehouse' + productTable.Added_Date__c.format() + ' ' + productTable.Added_Date__c.addDays(Integer.valueOf(orgConfig.Period_Term__c)).format(),
                                    Period_Start__c = productTable.Added_Date__c,
                                    Period_End__c = productTable.Added_Date__c.addDays(Integer.valueOf(orgConfig.Period_Term__c)))                                   
                  
                );
            }
        }
        insert productTableIdsByWarehouses.values();
        for (Product_Table__c productTable : productTableIdsByWarehouses.keySet()) {
            Warehouse__c warehouse = productTableIdsByWarehouses.get(productTable);
            productTable.Warehouse__c = warehouse.Id;
        }
    }
}