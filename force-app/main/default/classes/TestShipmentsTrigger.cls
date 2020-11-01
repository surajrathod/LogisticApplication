@isTest
public class TestShipmentsTrigger {
    
    @testSetup
    static void setup(){
        Customer__c cust = new Customer__c(
            Name='Suraj Rathod',
            FromEmail__c='surajrathod999@gmail.com',
            FromCity__c='Akola',
            FromCountry__c='INDIA',
            FromPhone__c='2323232323',
            FromPinCode__c=444004,
            FromState__c='Maharashtra',
            FromStreet__c='New Khetan Nagar Kaulkhed',
            
            ReceivingName__c='Sujita Rathod',
            ToEmail__c='surajrathod999@gmail.com',
            ToCity__c='Pune',
            ToCountry__c='INDIA',
            ToPhone__c='7878787878',
            ToPinCode__c=411047,
            ToState__c='Maharashtra',
            ToStreet__c='New kaveri complex'
        );
        insert cust;
    }
    
    @isTest
    static void insertShipmentCreateQuotationNormalDeliveryTest(){
        Customer__c cust=[Select Id from Customer__c];
        
        Shipment_Package__c shipment=new Shipment_Package__c(
            Package_Content__c='Product',
            Shipment_Type__c='Normal Delivery',
            Customer__c=cust.Id,
            Content_Value__c=343,
            Weight__c=23
        );
        insert shipment;
        //check if shipment related to quotation inserted
        Quotation__c quot =[Select Package__c from Quotation__c];
        system.assertEquals(quot.Package__c, Shipment.Id);
        
    }
    @isTest
    static void insertShipmentCreateQuotationFastDeliveryTest(){
        Customer__c cust=[Select Id from Customer__c];
        
        Shipment_Package__c shipment=new Shipment_Package__c(
            Package_Content__c='Document',
            Shipment_Type__c='Fast Day',
            Customer__c=cust.Id,
            Content_Value__c=347,
            Weight__c=23
        );
        insert shipment;
        //check if shipment related to quotation inserted
        Quotation__c quot =[Select Package__c from Quotation__c];
        system.assertEquals(quot.Package__c, Shipment.Id);
    }
    
    @isTest
    static void NotificationTest(){
        Customer__c cust=[Select Id from Customer__c];
        Drivers__c dri=new Drivers__c(
        	Name='Sriraj chavan',
            PhoneNo__c='232323232'
        );
        insert dri;
        Shipment_Package__c shipment=new Shipment_Package__c(
            Package_Content__c='Document',
            Shipment_Type__c='Fast Day',
            Customer__c=cust.Id,
            Content_Value__c=347,
            Weight__c=23
        );
        insert shipment;
        shipment.Status__c='Packed';
        shipment.Driver__c=dri.Id;
        update shipment;
    }
}