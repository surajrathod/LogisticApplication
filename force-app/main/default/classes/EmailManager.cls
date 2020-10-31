public class EmailManager {
    public static void sendMail(String address,String body,String subject){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        mail.setSenderDisplayName('FastFastLogistic');            
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}