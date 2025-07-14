/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.HocSinh;
import dal.HocSinhDAO;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.HocSinh_ChiTietHoc;
import dal.HocSinh_ChiTietDAO;
import dal.HocSinh_SDTDAO;
import dal.LopHocInfoDTODAO;
import dal.TaiKhoanDAO;
import dal.ThongBaoDAO;
import dal.TruongHocDAO;
import dao.UserLogsDAO;
import java.time.LocalDateTime;
import java.util.List;
import model.GiaoVien;
import model.HocSinh_SDT;
import model.LopHocInfoDTO;
import model.TruongHoc;
import model.UserLogs;

/**
 *
 * @author wrx_Chur04
 */
public class adminActionWithStudent extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet adminActionWithStudent</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminActionWithStudent at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        switch (action) {
            case "view":
                doView(request, response);
                break;

            case "viewClass":
                doViewClass(request, response);     
                break;

            case "viewTuiTionAndSendNTF":
                doViewTuiTionAndSendNotification(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");

        switch (type) {
            case "update":
                doUpdateInfor(request, response);
                break;
            case "sendNotification":
                doSendNotification(request, response);
                break;
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    protected void doView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String ID = request.getParameter("id");
        String ID_TaiKhoan = request.getParameter("idtaikhoan");
        ArrayList<HocSinh_SDT> hocsinhs = HocSinh_SDTDAO.adminGetSoDienThoaiHocSinhByIDTK(ID_TaiKhoan);
        ArrayList<TruongHoc> truonghoc = TruongHocDAO.adminGetTenTruong();
        if (hocsinhs != null) {
            request.setAttribute("truonghoc", truonghoc);
            request.setAttribute("hocsinhs", hocsinhs);
            request.getRequestDispatcher("/views/admin/adminViewHocSinhChiTiet.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Không có thông tin của học sinh này");
            request.getRequestDispatcher("/views/admin/adminViewHocSinhChiTiet.jsp").forward(request, response);
        }

    }
    protected void doUpdateInfor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String ID_HocSinh = request.getParameter("idhocsinh");
        String ID_taikhoan = request.getParameter("idtaikhoan");
        String diachi = request.getParameter("diachi");
        String idTruong = request.getParameter("idTruongHoc");
        String lopTrenTruong = request.getParameter("lop");
        String sdt = request.getParameter("sdt");
        String ghichu = request.getParameter("ghichu");

        int ID_TruongHS = Integer.parseInt(idTruong);
        ArrayList<GiaoVien> truongVaLopDangDayCuaGiaoVienDayHocSinhDo = HocSinh_ChiTietDAO.adminGetLopHocCuaGiaoVienSoVoiHocSinh(ID_HocSinh);

        boolean canUpdate = true;

        for (GiaoVien gv : truongVaLopDangDayCuaGiaoVienDayHocSinhDo) {
            if (gv.getID_TruongHoc() == ID_TruongHS
                    && gv.getLopDangDayTrenTruong().equalsIgnoreCase(lopTrenTruong)) {
                canUpdate = false;
                break;
            }
        }

        if (canUpdate) {
            try {
                int ID_TaiKhoan = Integer.parseInt(ID_taikhoan);
                if (sdt.length() != 10) {
                    throw new Exception("Số điện thoại phải dài 10 chữ số!");
                }

                if (!sdt.startsWith("0")) {
                    throw new Exception("Số điện thoại phải bắt đầu bằng số 0!");
                }

                boolean s1 = TaiKhoanDAO.adminUpdateInformationAccount(sdt, ID_TaiKhoan);
                boolean s2 = HocSinh_ChiTietDAO.updateTruongLopHocSinh(diachi, idTruong, ghichu, lopTrenTruong, ID_HocSinh);
                if (s1 == true && s2 == true) {
                    request.setAttribute("message", "Thay đổi thành công!");
                    UserLogs log = new UserLogs(0, 1, "Thay đổi thông tin học sinh có ID tài khoản " + ID_TaiKhoan, LocalDateTime.now());
                    UserLogsDAO.insertLog(log);
                    ArrayList<HocSinh_SDT> hocsinhs = HocSinh_SDTDAO.adminGetSoDienThoaiHocSinh();
                    session.setAttribute("hocsinhs", hocsinhs);
                    request.getRequestDispatcher("/views/admin/adminReceiveHocSinh.jsp").forward(request, response);

                }
            } catch (Exception e) {
                request.setAttribute("message", e.getMessage());
                request.getRequestDispatcher("/views/admin/adminReceiveHocSinh.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("message", "Không thể thay đổi ! Vi phạm nghị đinh 29 !!");
            request.getRequestDispatcher("/views/admin/adminReceiveHocSinh.jsp").forward(request, response);
        }

    }
    protected void doViewTuiTionAndSendNotification(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String ID = request.getParameter("id");
        String ID_TaiKhoan = request.getParameter("idtaikhoan");

        ArrayList<HocSinh_ChiTietHoc> hocsinhchitiets = HocSinh_ChiTietDAO.adminGetAllLopHocCuaHocSinh(ID);
        if (hocsinhchitiets != null) {
            request.setAttribute("idtk", ID_TaiKhoan);
            request.setAttribute("hocsinhchitiets", hocsinhchitiets);
            request.getRequestDispatcher("views/admin/adminViewHocPhiHocSinh.jsp").forward(request, response);
        }
    }

    protected void doSendNotification(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String ID_TaiKhoan = request.getParameter("idtaikhoan");
        String NoiDung = request.getParameter("noidung");
        boolean sendNTF = ThongBaoDAO.adminSendNotification(ID_TaiKhoan, NoiDung);
        if (sendNTF) {
            request.setAttribute("message", "Gửi thông báo thành công!");
            request.getRequestDispatcher("/views/admin/adminReceiveHocSinh.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Gửi thông báo thất bại!");
            request.getRequestDispatcher("/views/admin/adminReceiveHocSinh.jsp").forward(request, response);
        }
    }

    protected void doViewClass(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ID = request.getParameter("id");
        int idHocSinh;
        try {
            idHocSinh = Integer.parseInt(ID);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID học sinh không hợp lệ.");
            request.getRequestDispatcher("/views/admin/error.jsp").forward(request, response);
            return;
        }
        // Lấy danh sách lớp học của học sinh
        LopHocInfoDTODAO lhd = new LopHocInfoDTODAO();
        List<LopHocInfoDTO> lopHocs = lhd.getClassesByStudentId(idHocSinh);
        if (lopHocs == null || lopHocs.isEmpty()) {
            request.setAttribute("error", "Không tìm thấy lớp học nào cho học sinh này.");
            request.getRequestDispatcher("/views/admin/viewLopHoc_HocSinh.jsp").forward(request, response);
            return;
        }
        // Giả sử lấy lớp đầu tiên trong danh sách làm idLopHocHienTai
        // (Bạn có thể cần logic khác để xác định lớp hiện tại, ví dụ: dựa trên trạng thái "Đang học")
        int idLopHocHienTai = lopHocs.get(0).getIdLopHoc(); // Lấy ID lớp học đầu tiên

        // Truyền các tham số cần thiết
        request.setAttribute("idHocSinh", idHocSinh);
        request.setAttribute("idLopHocHienTai", idLopHocHienTai);
        request.setAttribute("lopHocs", lopHocs);
        request.getRequestDispatcher("/views/admin/viewLopHoc_HocSinh.jsp").forward(request, response);
    }
}

