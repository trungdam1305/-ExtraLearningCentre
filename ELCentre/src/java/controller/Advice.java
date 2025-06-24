package controller; // Thuộc package controller để xử lý logic điều hướng

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.ThongBaoDAO; // DAO để tương tác với CSDL liên quan đến thông báo

/**
 * Servlet tiếp nhận form tư vấn người dùng gửi lên, lưu vào hệ thống.
 */
public class Advice extends HttpServlet {

    // Xử lý yêu cầu GET hoặc POST chung (mặc định - mẫu)
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Trả về giao diện HTML đơn giản để test servlet (không dùng trong thực tế)
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html><html><head><title>Servlet Advice</title></head>");
            out.println("<body><h1>Servlet Advice tại " + request.getContextPath() + "</h1></body></html>");
        }
    }

    // Xử lý yêu cầu GET – hiện tại không làm gì (có thể dùng sau nếu hiển thị form)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        //processRequest(request, response);
    }

    // Xử lý dữ liệu khi người dùng gửi biểu mẫu tư vấn (POST)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận đúng tiếng Việt

        // Nhận dữ liệu từ form
        String hoTen = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String noiDung = request.getParameter("NoiDung");

        // Tạo thông báo lưu vào CSDL
        String noiDungThongBao = "[TƯ VẤN] Họ tên: " + hoTen + " | Email: " + email + 
                                 " | SĐT: " + phone + " | Nội dung: " + noiDung;

        try {
            System.out.println("Trước khi insert vào dtb");
            ThongBaoDAO.insertThongBaoTuVan(noiDungThongBao); // Lưu xuống CSDL
            System.out.println("Đã gọi xong hàm");
            response.sendRedirect(request.getContextPath() + "/views/advice-success.jsp"); // Chuyển tới trang xác nhận
        } catch (Exception e) {
            e.printStackTrace(); // Debug nếu có lỗi xảy ra
        }
    }

    // (CHƯA HOÀN THIỆN) Hàm kiểm tra họ tên có hợp lệ hay không
    public static String isValidHoTen(String hoTen) {
        if (hoTen == null || hoTen.trim().isEmpty()) {
            return "Tên không thể để trống.";
        }
        hoTen = hoTen.trim();
        // Có thể bổ sung Regex để kiểm tra tên hợp lệ hơn (chữ có dấu, không số)
        return null; // Trả về null nếu hợp lệ
    }

    @Override
    public String getServletInfo() {
        return "Servlet tiếp nhận thông tin tư vấn và lưu vào hệ thống";
    }
}