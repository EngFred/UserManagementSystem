package com.usermanagementsys.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class MailUtil {

    public static boolean sendTemporaryPassword(String recipientEmail, String tempPassword) {
        // Your email credentials
        final String senderEmail = "ax540781@gmail.com";
        final String senderPassword = "giwdwresvsqtniks";

        // Mail server properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // TLS
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");


        try{
            // Authenticate session
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

            // Compose email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(
                    Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Your Temporary Password");

            String htmlMessage = "<h3>Password Reset</h3>"
                    + "<p>Your temporary password is:</p>"
                    + "<h2 style='color: #007bff;'>" + tempPassword + "</h2>"
                    + "<p>This password is valid for a short time. Please reset it immediately</p>";

            message.setContent(htmlMessage, "text/html; charset=utf-8");

            // Send email
            Transport.send(message);
            System.out.println("Temporary password sent to: " + recipientEmail);

            return true;
        } catch (Exception e) {
            System.err.println("Failed to send email: "+ e);
            return false;
        }
    }
}

