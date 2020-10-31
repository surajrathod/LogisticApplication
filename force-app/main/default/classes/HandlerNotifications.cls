public class HandlerNotifications {
    public static void NotificationBody(List<Shipment_Package__c> OldShipmentval,List<Shipment_Package__c> NewShipmentval){
        String oldStatusVal;
        String newStatusVal;
        String Name;
        String Email;
        Set<Id> customerID=new Set<Id>();
        Set<Id> DriverID = new Set<Id>();
        Drivers__c driver;
        
        //loop over the shipment 
        //check the status and Driver assigned to it
        for(Shipment_Package__c ship:NewShipmentval){
            newStatusVal = ship.Status__c;
            customerID.add(ship.Customer__c);
            
            if(ship.Driver__c !=null){
                DriverID.add(ship.Driver__c);
                driver=[Select Name,PhoneNo__c from Drivers__c where ID IN:DriverID limit 1];
            }
        }
      	//query the customer information for the shipments
        Customer__c customer=[Select Name,FromEmail__c from Customer__c where ID IN:customerID limit 1];
        Name=customer.Name;
        Email=customer.FromEmail__c;
        

		for(Shipment_Package__c oldship: OldShipmentval){
            oldStatusVal=oldship.Status__c;
        } 
        //Notify the customer about there Orders
        if(oldStatusVal != newStatusVal){
            ShipmentStatusNotification(newStatusVal,Name,Email);
        }
       
        // notify the customer about the driver assigned to the shipment
        if(driver !=null){
            DriverAssigned(driver.Name,Email);
        }
    }
    
    private static void ShipmentStatusNotification(String newStatusVal,String Name,String Email){
        String subject='Shipment Status';
        String body = 'Hello '+Name+' Your Order has been ' + newStatusVal;
        
		EmailManager.sendMail(Email,body,subject);        
    }
    
    private static void DriverAssigned(String driverName,String Email){
        String subject ='your order reached';
        String body = 'Hello' + ' Your Order has been reached the Hub, will be Delivered by ' + driverName;
        EmailManager.sendMail(Email,body,subject);
    }
}