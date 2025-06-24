package api; // Khai báo package là "api"

// Import các lớp cần thiết từ thư viện Jakarta Mail
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
    // Tài khoản Gmail dùng để gửi email (nên được lưu an toàn, không nên hard-code như thế này)
    private static final String USERNAME = "edupluscenterhn@gmail.com";
    private static final String PASSWORD = "wpzo gbxt mpoe ljqx"; // Mật khẩu ứng dụng (App Password)

    // Phương thức gửi email
    public static void sendEmail(String toEmail, String subject, String body)
            throws MessagingException, UnsupportedEncodingException {

        // Thiết lập thông tin cấu hình cho SMTP server của Gmail
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true"); // Bắt buộc xác thực
        props.put("mail.smtp.starttls.enable", "true"); // Bật TLS để bảo mật
        props.put("mail.smtp.host", "smtp.gmail.com"); // Host SMTP của Gmail
        props.put("mail.smtp.port", "587"); // Cổng dùng cho TLS

        // Tạo phiên làm việc với thông tin xác thực
        Session session = Session.getInstance(props, new Authenticator() {
            // Cung cấp tài khoản/mật khẩu khi server yêu cầu xác thực
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        // Tạo đối tượng email mới
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(USERNAME, "ELCentre", "UTF-8")); // Thiết lập người gửi
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail)); // Người nhận
        message.setSubject(subject); // Chủ đề email
        message.setText(body); // Nội dung email (thuần văn bản)

        // Thiết lập lại nội dung email dạng HTML để hỗ trợ xuống dòng
        message.setContent(body.replace("\n", "<br>"), "text/html; charset=UTF-8");

        // Gửi email đi
        Transport.send(message);
    }
}