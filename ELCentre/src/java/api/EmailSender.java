package api;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Properties;


public class EmailSender {

    private static final String USERNAME = "edupluscenterhn@gmail.com"; 
    private static final String PASSWORD = "zqlx legn nzvt anok"; 

    public static void sendEmail(String toEmail, String subject, String body) throws MessagingException, UnsupportedEncodingException {
        // Cấu hình SMTP server
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // TLS
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Phiên làm việc
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        // Tạo email
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(USERNAME, "ELCentre", "UTF-8"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);
        message.setText(body);
        
        // Gửi với charset UTF-8
        message.setContent(body.replace("\n", "<br>"), "text/html; charset=UTF-8");
        // Gửi
        Transport.send(message);
    }
}
