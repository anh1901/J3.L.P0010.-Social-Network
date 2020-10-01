/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.utils;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class SendEmail {
    final static Logger logger = Logger.getLogger(SendEmail.class.getName());

    public static void sendEmail(String host, String port, 
            final String email,final String password, String toAddress,
            String subject, String message)
            throws AddressException, MessagingException
    {
        logger.info("Sending email.");
        Properties p=new Properties();
        p.put("mail.smtp.host", host);
        p.put("mail.smtp.port", port);
        p.put("mail.smtp.auth", "true");
        p.put("mail.smtp.starttls.enable", "true");
        
        Authenticator authenticator=new Authenticator() {
            @Override
            public  PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(email, password);
            }
        
        };
        Session session = Session.getInstance(p, authenticator);
        Message msg=new MimeMessage(session);
        msg.setFrom(new InternetAddress(toAddress));
        InternetAddress[] toAddresses = {new InternetAddress(toAddress)};
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        msg.setSubject(subject);
        msg.setSentDate(new Date());
        msg.setText(message);
        Transport.send(msg);
        logger.info("Sent email.");
    }
}
