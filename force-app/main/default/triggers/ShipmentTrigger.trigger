trigger ShipmentTrigger on Shipment_Package__c (after insert) {
    List<PriceBook__mdt> prices=[SELECT Document__c,Fast_Delivery__c,Product__c,Base_Charge__c,NormalDelivery__c from PriceBook__mdt Limit 1];
    
    
    List<Quotation__c> Quotation=new List<Quotation__c>();    
    Double TotalPrice=0;
    //loop over the shipment and set the Quotation Price based on the selected Fields
    for(Shipment_Package__c shipment:Trigger.new){
        for(PriceBook__mdt price:prices){
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
        }
        
        Quotation.add(new Quotation__c(Name=shipment.Name+'Quote',Package__c=shipment.Id,TotalPrice__c=TotalPrice));
        
    }
    //insert the quotation for the shipment
    if(Quotation.size()>0){
        insert Quotation;
    }
    
}