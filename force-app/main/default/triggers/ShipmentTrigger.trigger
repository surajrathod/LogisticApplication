trigger ShipmentTrigger on Shipment_Package__c (after insert) {
    //get the default values for the quotation from the custom settings
    PriceBooks__c price=PriceBooks__c.getInstance();

	List<Quotation__c> Quotation=new List<Quotation__c>();    
    Double TotalPrice=0;
    //loop over the shipment and set the Quotation Price based on the selected Fields
    for(Shipment_Package__c shipment:Trigger.new){
        if(shipment.Package_Content__c=='Document'){
            TotalPrice = TotalPrice+=price.Document__c;
        }else if(shipment.Package_Content__c=='Product'){
            TotalPrice = TotalPrice+=price.Product__c;
        }
        
        if(shipment.Shipment_Type__c=='Fast Day'){
            TotalPrice = TotalPrice+=price.Fast_Delivery__c;
        }else if(shipment.Shipment_Type__c=='Normal Delivery'){
            TotalPrice = TotalPrice+=price.NormalDelivery__c;
        }
        
        TotalPrice = TotalPrice+=price.Base_Charge__c;
        Quotation.add(new Quotation__c(Name=shipment.Name+'Quote',Package__c=shipment.Id,TotalPrice__c=TotalPrice));
        
    }
    //insert the quotation for the shipment
    if(Quotation.size()>0){
        insert Quotation;
    }
    
}