package controller; // Lớp nằm trong package controller

// Import các lớp hỗ trợ xử lý servlet, gửi email và tương tác với database/model
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import api.EmailSender;
import dal.ThongBaoDAO;
import model.ThongBao;

/**
 * Servlet dùng để gửi email tư vấn đến địa chỉ email được trích xuất từ nội dung thông báo.
 */
public class SendAdviceMailServlet extends HttpServlet {

    // Phương thức xử lý mặc định khi người dùng gửi yêu cầu GET hoặc POST
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập kiểu trả về là HTML với encoding UTF-8
        response.setContentType("text/html;charset=UTF-8");

        // Xuất nội dung HTML test ra trình duyệt (dùng để test servlet)
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html><head><title>Servlet SendAdviceMailServlet</title></head>");
            out.println("<body><h1>Servlet SendAdviceMailServlet tại " + request.getContextPath() + "</h1></body>");
            out.println("</html>");
        }
    }

    // Giao tiếp bằng phương thức GET sẽ gọi xử lý chung
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // Xử lý khi người dùng gửi yêu cầu POST (thường là từ form)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form gửi lên
            String idRaw = request.getParameter("id");
            String subject = request.getParameter("subject");
            String content = request.getParameter("content");
            int id = Integer.parseInt(idRaw);

            // Lấy đối tượng ThongBao từ cơ sở dữ liệu
            ThongBao tb = ThongBaoDAO.getThongBaoById(id);
            if (tb == null) {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy thông báo.");
                response.sendRedirect(request.getContextPath() + "/views/admin/adminApproveRegisterUser.jsp");
                return;
            }

            // Trích xuất email từ nội dung thông báo
            String email = extractEmail(tb.getNoiDung());
            if (email == null || email.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy địa chỉ email trong nội dung.");
                response.sendRedirect(request.getContextPath() + "/views/admin/adminApproveRegisterUser.jsp");
                return;
            }

            // Gửi email tư vấn
            EmailSender.sendEmail(email, subject, content);

            // Gửi thông báo thành công về client
            request.getSession().setAttribute("successMessage", "Email đã được gửi thành công đến: " + email);
            response.sendRedirect(request.getContextPath() + "/views/admin/adminApproveRegisterUser.jsp");

        } catch (Exception e) {
            // Xử lý nếu có lỗi xảy ra trong quá trình gửi mail
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi khi gửi email.");
            response.sendRedirect(request.getContextPath() + "/views/admin/adminApproveRegisterUser.jsp");
        }
    }

    // Hàm trích xuất địa chỉ email từ nội dung chuỗi thông báo
    private String extractEmail(String noiDung) {
        String regex = "(?i)email\\s*:?\\s*([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+)";
        java.util.regex.Matcher matcher = java.util.regex.Pattern.compile(regex).matcher(noiDung);
        if (matcher.find()) {
            return matcher.group(1); // Trả về email nếu tìm thấy
        }
        return null; // Nếu không tìm thấy email nào
    }

    @Override
    public String getServletInfo() {
        return "Xử lý việc gửi mail tư vấn";
    }
}