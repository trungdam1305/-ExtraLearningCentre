/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.ManageCourses;

import dal.GiaoVienDAO;
import dal.HocSinhDAO;
import dal.KhoaHocDAO;
import dal.LichHocDAO;
import dal.LopHocDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.GiaoVien;
import model.HocSinh;
import model.KhoaHoc;
import model.LichHoc;
import model.LopHoc;

/**
 *
 * @author Vuh26
 */
public class ManageClassDetail_LopHoc_HocSinh extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageClassDetail_LopHoc_HocSinh</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageClassDetail_LopHoc_HocSinh at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
   
protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
    try {
        // Lấy tham số
        int idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
        int idKhoaHoc = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
        int idKhoi = Integer.parseInt(request.getParameter("ID_Khoi"));
        String idHocSinh = request.getParameter("idHocSinh"); // Lấy idHocSinh từ request

        // Xây dựng backUrl để quay lại viewLopHoc_HocSinh.jsp
        String backUrl;
        if (idHocSinh != null && !idHocSinh.isEmpty()) {
            backUrl = request.getContextPath() + "/adminActionWithStudent?action=viewClass&id=" + idHocSinh;
        } else {
            // URL mặc định nếu không có idHocSinh
            backUrl = request.getContextPath() + "/adminGetFromDashboard?action=hocsinh";
        }
        request.setAttribute("backUrl", backUrl);

        // Khởi tạo DAO
        LopHocDAO lopHocDAO = new LopHocDAO();
        LichHocDAO lichHocDAO = new LichHocDAO();
        GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
        HocSinhDAO hocSinhDAO = new HocSinhDAO();
        KhoaHocDAO khoaHocDAO = new KhoaHocDAO();

        // Lấy thông tin lớp học
        LopHoc lopHoc = lopHocDAO.getLopHocById(idLopHoc);
        if (lopHoc == null) {
            request.setAttribute("err", "Không tìm thấy lớp học.");
            request.setAttribute("lichHocList", new ArrayList<LichHoc>());
            request.setAttribute("giaoVien", null);
            request.setAttribute("hocSinhList", new ArrayList<HocSinh>());
            request.setAttribute("allStudents", new ArrayList<HocSinh>());
            request.setAttribute("availableTeachers", new ArrayList<GiaoVien>());
            request.setAttribute("previousTeachers", new ArrayList<GiaoVien>());
            request.setAttribute("previousStudents", new ArrayList<HocSinh>());
            request.setAttribute("ID_KhoaHoc", idKhoaHoc);
            request.setAttribute("ID_Khoi", idKhoi);
            request.getRequestDispatcher("/views/admin/viewClass_LopHoc_HocSinh.jsp").forward(request, response);
            return;
        }

        // Xử lý ClassCode từ tham số URL nếu cột ClassCode là null
        String classCodeFromUrl = request.getParameter("ClassCode");
        if (lopHoc.getClassCode() == null && classCodeFromUrl != null && !classCodeFromUrl.trim().isEmpty()) {
            lopHoc.setClassCode(classCodeFromUrl);
            System.out.println("doGet: Set ClassCode from URL: " + classCodeFromUrl);
        }

        // Lấy danh sách lịch học
        List<LichHoc> lichHocList = lichHocDAO.getLichHocByLopHoc(idLopHoc);

        // Lấy giáo viên của lớp
        GiaoVien giaoVien = giaoVienDAO.getGiaoVienByLopHoc1(idLopHoc);
        System.out.printf("doGet: GiaoVien for ID_LopHoc=%d: %s%n", idLopHoc,
                giaoVien != null ? giaoVien.getHoTen() : "null");

        // Lấy danh sách học sinh trong lớp
        List<HocSinh> hocSinhList = hocSinhDAO.getHocSinhByLopHoc1(idLopHoc);
        System.out.printf("doGet: HocSinhList size for ID_LopHoc=%d: %d%n", idLopHoc,
                hocSinhList != null ? hocSinhList.size() : 0);

        // Lấy danh sách tất cả học sinh
        List<HocSinh> allStudents = hocSinhDAO.adminGetAllHocSinh11();

        // Lấy danh sách giáo viên phù hợp với khóa học
        KhoaHoc khoaHoc = khoaHocDAO.getKhoaHocById(idKhoaHoc);
        List<GiaoVien> availableTeachers = new ArrayList<>();
        if (khoaHoc != null) {
            String tenKhoaHoc = khoaHoc.getTenKhoaHoc().toLowerCase();
            availableTeachers = giaoVienDAO.getTeachersBySpecialization1(tenKhoaHoc);
            System.out.printf("doGet: AvailableTeachers size for ID_KhoaHoc=%d: %d%n",
                    idKhoaHoc, availableTeachers.size());
        } else {
            System.out.printf("doGet: KhoaHoc is null for ID_KhoaHoc=%d%n", idKhoaHoc);
        }

        // Lấy danh sách giáo viên và học sinh đã tham gia các buổi học trước
        List<GiaoVien> previousTeachers = giaoVienDAO.getPreviousTeachersByLopHoc1(idLopHoc);
        List<HocSinh> previousStudents = hocSinhDAO.getPreviousStudentsByLopHoc1(idLopHoc);
        System.out.printf("doGet: PreviousTeachers size for ID_LopHoc=%d: %d%n",
                idLopHoc, previousTeachers != null ? previousTeachers.size() : 0);
        System.out.printf("doGet: PreviousStudents size for ID_LopHoc=%d: %d%n",
                idLopHoc, previousStudents != null ? previousStudents.size() : 0);

        // Đặt thuộc tính cho JSP
        request.setAttribute("lopHoc", lopHoc);
        request.setAttribute("lichHocList", lichHocList);
        request.setAttribute("giaoVien", giaoVien);
        request.setAttribute("hocSinhList", hocSinhList);
        request.setAttribute("allStudents", allStudents);
        request.setAttribute("availableTeachers", availableTeachers);
        request.setAttribute("previousTeachers", previousTeachers);
        request.setAttribute("previousStudents", previousStudents);
        request.setAttribute("ID_KhoaHoc", idKhoaHoc);
        request.setAttribute("ID_Khoi", idKhoi);
        request.setAttribute("idHocSinh", idHocSinh); // Đặt idHocSinh để sử dụng trong JSP nếu cần

        // Chuyển tiếp đến JSP
        request.getRequestDispatcher("/views/admin/viewClass_LopHoc_HocSinh.jsp").forward(request, response);
    } catch (NumberFormatException e) {
        System.out.println("doGet: Invalid parameter: " + e.getMessage());
        e.printStackTrace();
        request.setAttribute("err", "Tham số không hợp lệ!");
        request.getRequestDispatcher("/views/admin/viewClass_LopHoc_HocSinh.jsp").forward(request, response);
    } catch (Exception e) {
        System.out.println("doGet: Error: " + e.getMessage());
        e.printStackTrace();
        request.setAttribute("err", "Lỗi khi tải thông tin lớp học: " + e.getMessage());
        request.getRequestDispatcher("/views/admin/viewClass_LopHoc_HocSinh.jsp").forward(request, response);
    }
}
    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
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
