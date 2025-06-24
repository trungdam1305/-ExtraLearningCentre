package controller; // Khai báo lớp thuộc package controller

// Import các thư viện cần thiết cho việc gửi email
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMultipart;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.Properties;

// Lớp Servlet để xử lý việc gửi email xác nhận tư vấn
public class SendEmailServlet extends HttpServlet {

    // Xử lý yêu cầu GET hoặc POST chung nếu cần
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập kiểu nội dung HTML trả về
        response.setContentType("text/html;charset=UTF-8");

        // In nội dung HTML đơn giản (dùng chủ yếu để test hoặc giữ cấu trúc servlet mẫu)
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html><head><title>Servlet NewServlet</title></head>");
            out.println("<body><h1>Servlet NewServlet tại " + request.getContextPath() + "</h1></body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Khi người dùng truy cập bằng GET -> xử lý chung
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nhận thông tin họ tên và email người dùng từ form
        String regName = request.getParameter("regName");
        String regEmail = request.getParameter("regEmail");

        // Gửi email đến người đăng ký
        boolean mailSent = sendEmail(regEmail);

        // Trả kết quả về trình duyệt
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if (mailSent) {
                out.println("<script>alert('Bạn đã đăng ký tư vấn thành công!'); window.location = 'views/HomePage.jsp';</script>");
            } else {
                out.println("<script>alert('Gửi email thất bại, vui lòng thử lại!'); window.history.back();</script>");
            }
        }
    }

    // Hàm gửi email xác nhận tư vấn
    private boolean sendEmail(String recipientEmail) {
        final String senderEmail = "edupluscenterhn@gmail.com"; // Email gửi
        final String senderPassword = "zvfdc iaus rvmq wrmz"; // Mật khẩu ứng dụng Gmail

        String link = "https://www.facebook.com/profile.php?id=61576366144647"; // Link fanpage

        // Thiết lập thông số SMTP để gửi qua Gmail
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true"); // Bắt buộc xác thực
        props.put("mail.smtp.starttls.enable", "true"); // Bật TLS
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP host
        props.put("mail.smtp.port", "587"); // Cổng TLS

        // Xác thực tài khoản gửi
        Session session = Session.getInstance(props,
            new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

        try {
            // Tạo email
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(
                "Cảm ơn bạn vì đã đăng kí tư vấn đến từ trung tâm chúng tôi. Hãy liên lạc với chúng tôi để nhận được thông tin sớm nhất",
                "UTF-8"
            );

            // Tạo nội dung HTML có kèm ảnh
            MimeMultipart multipart = new MimeMultipart("related");

            MimeBodyPart htmlPart = new MimeBodyPart();
            String htmlContent = "<h3>Xin chào!</h3>"
                + "<p>Cảm ơn bạn đã đăng ký tư vấn.</p>"
                + "<img src=\"cid:image1\" alt=\"Logo Trung Tâm\" />"
                + "<p>Hãy kết nối với chúng tôi:</p>"
                + "<a href=\"" + link + "\">" + link + "</a>";
            htmlPart.setContent(htmlContent, "text/html; charset=UTF-8");
            multipart.addBodyPart(htmlPart);

            // Gắn ảnh vào email
            MimeBodyPart imagePart = new MimeBodyPart();
            String imagePath = getServletContext().getRealPath("/img/SieuLogo-xoaphong.png"); // Đường dẫn ảnh
            imagePart.attachFile(imagePath);
            imagePart.setContentID("<image1>"); // Liên kết với cid trong HTML
            imagePart.setDisposition(MimeBodyPart.INLINE); // Hiển thị trong nội dung
            multipart.addBodyPart(imagePart);

            message.setContent(multipart);

            // Gửi email
            Transport.send(message);
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Mô tả ngắn gọn về servlet (mặc định)
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}