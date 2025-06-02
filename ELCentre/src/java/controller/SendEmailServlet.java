/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Properties;

/**
 *
 * @author admin
 */
public class SendEmailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String regName = request.getParameter("regName");
        String regEmail = request.getParameter("regEmail");

        boolean mailSent = sendEmail(regEmail); // otp = 0 vì bạn không dùng mã OTP thực tế

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if (mailSent) {
                out.println("<script>alert('Bạn đã đăng ký tư vấn thành công!'); window.location = 'views/HomePage.jsp';</script>");
            } else {
                out.println("<script>alert('Gửi email thất bại, vui lòng thử lại!'); window.history.back();</script>");
            }
        }
    }

    
    private boolean sendEmail(String recipientEmail) {
    final String senderEmail = "edupluscenterhn@gmail.com"; // Thay bằng email của bạn
    final String senderPassword = "zvfdc iaus rvmq wrmz"; // Thay bằng mật khẩu ứng dụng
    String link = "https://www.facebook.com/profile.php?id=61576366144647";

    Properties props = new Properties();
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "587");

    Session session = Session.getInstance(props,
            new jakarta.mail.Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(senderEmail, senderPassword);
        }
    });

    try {
    MimeMessage message = new MimeMessage(session);
    message.setFrom(new InternetAddress(senderEmail));
    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
    message.setSubject("Cảm ơn bạn vì đã đăng kí tư vấn đến từ trung tâm chúng tôi. Hãy liên lạc với chúng tôi để nhận được thông tin sớm nhất", "UTF-8");

    MimeMultipart multipart = new MimeMultipart("related");

    MimeBodyPart htmlPart = new MimeBodyPart();
    String htmlContent = "<h3>Xin chào!</h3>"
    + "<p>Cảm ơn bạn đã đăng ký tư vấn.</p>"
    + "<img src=\"cid:image1\" alt=\"Logo Trung Tâm\" />"
    + "<p>Hãy kết nối với chúng tôi:</p>"
    + "<a href=\"" + link + "\">" + link + "</a>";
htmlPart.setContent(htmlContent, "text/html; charset=UTF-8");

    multipart.addBodyPart(htmlPart);

    MimeBodyPart imagePart = new MimeBodyPart();
    String imagePath = getServletContext().getRealPath("/img/SieuLogo-xoaphong.png");
    imagePart.attachFile(imagePath);

    imagePart.setContentID("<image1>");
    imagePart.setDisposition(MimeBodyPart.INLINE);
    multipart.addBodyPart(imagePart);

    message.setContent(multipart);

    Transport.send(message);
    return true;
} catch (Exception e) {
    e.printStackTrace();
    return false;
}

    }
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
