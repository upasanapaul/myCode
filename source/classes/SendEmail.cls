public class SendEmail {
    public static void send(List<String> sendTo)
    {
        List<Messaging.SingleEmailMessage> mails =new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail =new Messaging.SingleEmailMessage();
        mail.setToAddresses(sendTo);
        mail.setSubject('Contact Updates');
        mail.setHtmlBody('Contact has been updated');
        mails.add(mail);
        Messaging.sendEmail(mails);
    }

}