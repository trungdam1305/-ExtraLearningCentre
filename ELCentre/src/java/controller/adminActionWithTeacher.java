package controller;

import dal.GiaoVienDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.GiaoVien;
import model.GiaoVien_TruongHoc;
import model.GiaoVien_ChiTietDay;
import dal.GiaoVien_ChiTietDayDAO;
import dal.HocSinh_ChiTietDAO;
import dal.HocSinh_SDTDAO;
import dal.LopHocInfoDTODAO;
import dal.TaiKhoanDAO;
import dal.ThongBaoDAO;
import dal.TruongHocDAO;
import dao.UserLogsDAO;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import model.HocSinh;
import model.HocSinh_SDT;
import java.util.List;
import model.HocSinh;
import model.HocSinh_SDT;
import model.LopHocInfoDTO;
import model.TaiKhoan;
import model.TruongHoc;
import model.UserLogs;

/**
 *
 * @author wrx_Chur04
 */
public class adminActionWithTeacher extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet adminActionWithTeacher</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminActionWithTeacher at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idGiaoVien = request.getParameter("id");

        switch (action) {
            case "view":
                doView(request, response);
                break;

            case "viewLopHocGiaoVien":
                doViewLopHocGiaoVien(request, response);
                break;

            case "update":
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
    }// </editor-fold>

    protected void doView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ID = request.getParameter("id");
        String ID_TaiKhoan = request.getParameter("idTaiKhoan");
        ArrayList<GiaoVien_TruongHoc> giaoviens = GiaoVienDAO.adminGetGiaoVienByID(ID_TaiKhoan);
        ArrayList<TruongHoc> truonghoc = TruongHocDAO.adminGetTenTruong();
        if (giaoviens != null) {
            request.setAttribute("giaoviens", giaoviens);
            request.setAttribute("truonghoc", truonghoc);
            request.getRequestDispatcher("/views/admin/adminViewGiaoVienChiTiet.jsp").forward(request, response);
        }
    }

    protected void doViewLopHocGiaoVien(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra quyền truy cập (giả sử có session lưu thông tin người dùng)
        // HttpSession session = request.getSession();
        // TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        // if (user == null || !user.getUserType().equals("Admin")) {
        //     response.sendRedirect(request.getContextPath() + "/login");
        //     return;
        // }

        String ID = request.getParameter("id");
        int id;
        try {
            id = Integer.parseInt(ID);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID giáo viên không hợp lệ.");
            request.getRequestDispatcher("/views/admin/error.jsp").forward(request, response);
            return;
        }

        // Lấy danh sách lớp học
        LopHocInfoDTODAO lhd = new LopHocInfoDTODAO();
        List<LopHocInfoDTO> lopHocs = lhd.getClassesByTeacherId(id);
        if (lopHocs == null || lopHocs.isEmpty()) {
            request.setAttribute("error", "Không tìm thấy lớp học nào cho giáo viên này.");
            request.getRequestDispatcher("/views/admin/viewLopHoc_GiaoVien.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin giáo viên bằng hàm getGiaoVienById1 (thêm phần này)
        GiaoVienDAO gvDAO = new GiaoVienDAO();  // Giả sử đây là DAO của bạn
        GiaoVien giaoVien = gvDAO.getGiaoVienById1(id);
        String tenGiaoVien = (giaoVien != null) ? giaoVien.getHoTen() : "Không tìm thấy tên giáo viên";  // Lấy tên từ object

        // Set attributes
        request.setAttribute("idGiaoVien", id);
        request.setAttribute("lopHocs", lopHocs);
        request.setAttribute("tenGiaoVien", tenGiaoVien);  // Set tên giáo viên

        request.getRequestDispatcher("/views/admin/viewLopHoc_GiaoVien.jsp").forward(request, response);
    }

    protected void doUpdateInfor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String ID_GiaoVien = request.getParameter("idgiaovien");
        String ID_taikhoan = request.getParameter("idtaikhoan");
        String idTruong = request.getParameter("idTruongHoc");
        String lopTrenTruong = request.getParameter("lop");
        String sdt = request.getParameter("sdt");
        String luong = request.getParameter("luong");
        String isHot = request.getParameter("hot");
        int IsHot = Integer.parseInt(isHot);
        int ID_TruongGV = Integer.parseInt(idTruong);
        double luong1 = Double.parseDouble(luong);
        ArrayList<HocSinh> truongVaLopDangHocCuaHocSinhTrongLopGiaoVien = HocSinh_ChiTietDAO.adminGetLopHocCuaHocSinhSoVoiGiaoVien(ID_GiaoVien);

        boolean canUpdate = true;

        for (HocSinh hs : truongVaLopDangHocCuaHocSinhTrongLopGiaoVien) {
            if (hs.getID_TruongHoc() == ID_TruongGV
                    && hs.getLopDangHocTrenTruong().equalsIgnoreCase(lopTrenTruong)) {
                canUpdate = false;
                break;
            }
        }

        if (canUpdate) {
            try {
                int ID_TaiKhoan = Integer.parseInt(ID_taikhoan);
                BigDecimal Luong = BigDecimal.valueOf(luong1);
                if (sdt.length() != 10) {
                    throw new Exception("Số điện thoại phải dài 10 chữ số!");
                }

                if (!sdt.startsWith("0")) {
                    throw new Exception("Số điện thoại phải bắt đầu bằng số 0!");
                }



                boolean s1 = TaiKhoanDAO.adminUpdateInformationAccount(sdt, ID_TaiKhoan);
                boolean s2 = HocSinh_ChiTietDAO.updateTruongLopGiaoVien(idTruong, lopTrenTruong, sdt, IsHot, ID_GiaoVien, Luong);
                if (s1 == true && s2 == true) {
                    request.setAttribute("message", "Thay đổi thành công!");
                    UserLogs log = new UserLogs(0, 1, "Thay đổi thông tin giáo viên có ID tài khoản " + ID_TaiKhoan, LocalDateTime.now());
                    UserLogsDAO.insertLog(log);
                    ArrayList<GiaoVien_TruongHoc> giaoviens = new ArrayList<GiaoVien_TruongHoc>();
                    giaoviens = GiaoVienDAO.admminGetAllGiaoVien();
                    session.setAttribute("giaoviens", giaoviens);
                    request.getRequestDispatcher("/views/admin/adminReceiveGiaoVien.jsp").forward(request, response);

                }
            } catch (Exception e) {
                request.setAttribute("message", e.getMessage());
                request.getRequestDispatcher("/views/admin/adminReceiveGiaoVien.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("message", "Không thể thay đổi ! Vi phạm nghị đinh 29 !!");
            request.getRequestDispatcher("/views/admin/adminReceiveHocSinh.jsp").forward(request, response);
        }

    }

    protected void doSendNotification(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String ID_TaiKhoan = request.getParameter("idtaikhoan");
        String NoiDung = request.getParameter("noidung");
        boolean sendNTF = ThongBaoDAO.adminSendNotification(ID_TaiKhoan, NoiDung, "Teacher");
        if (sendNTF) {
            request.setAttribute("message", "Gửi thông báo thành công!");

            request.getRequestDispatcher("/views/admin/adminReceiveGiaoVien.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Gửi thông báo thất bại!");
            request.getRequestDispatcher("/views/admin/adminReceiveGiaoVien.jsp").forward(request, response);
        }

    }

}