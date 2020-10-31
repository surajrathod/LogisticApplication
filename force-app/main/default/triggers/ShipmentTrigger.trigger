trigger ShipmentTrigger on Shipment_Package__c (after insert, after update) {
    if(Trigger.isAfter && Trigger.isInsert){
        HandlerQuotation.newQuotationCreate(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        HandlerNotifications.NotificationBody(Trigger.old,Trigger.new);
    }
}