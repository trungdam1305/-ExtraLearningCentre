package controller;

import dal.*;
import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Optional;

public class StudentRequestEnrollServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        String classCode = request.getParameter("classCode");
        if (classCode == null || classCode.trim().isEmpty()) {
            session.setAttribute("message", "❌ Mã lớp không hợp lệ.");
            response.sendRedirect("StudentViewLopTrongKhoaServlet");
            return;
        }

        LopHoc lopHoc = LopHocDAO.getLopHocByClassCode(classCode);
        
        if (lopHoc == null) {
            session.setAttribute("message", "❌ Không tìm thấy lớp học.");
            response.sendRedirect("StudentViewLopTrongKhoaServlet");
            return;
        }

        HocSinh hocSinh = HocSinhDAO.findByTaiKhoanId(user.getID_TaiKhoan());
        if (hocSinh == null) {
            session.setAttribute("message", "❌ Không tìm thấy thông tin học sinh.");
            response.sendRedirect("StudentViewLopTrongKhoaServlet");
            return;
        }

        String lopTrenTruong = hocSinh.getLopDangHocTrenTruong();
        Optional<GiaoVien> giaoVien = GiaoVienDAO.findByLopHocId(lopHoc.getID_LopHoc());
        if (giaoVien.isPresent()) {
            String lopDayTrenTruong = giaoVien.get().getLopDangDayTrenTruong();
            if (lopTrenTruong != null && lopTrenTruong.equalsIgnoreCase(lopDayTrenTruong)) {
                session.setAttribute("message", "⚠️ Lớp bạn đang học trùng với lớp giáo viên đang dạy trên trường.");
                response.sendRedirect("StudentViewLopTrongKhoaServlet");
                return;
            }
        }

        boolean daGui = ThongBaoDAO.checkRequestExists(user.getID_TaiKhoan(), classCode);
        if (daGui) {
            session.setAttribute("message", "⚠️ Bạn đã gửi yêu cầu đăng ký lớp này trước đó.");
            response.sendRedirect("StudentViewLopTrongKhoaServlet");
            return;
        }

        ThongBao thongBao = new ThongBao();
        thongBao.setID_TaiKhoan(user.getID_TaiKhoan());
        thongBao.setNoiDung("📝 Yêu cầu đăng ký vào lớp " + classCode);
        thongBao.setThoiGian(LocalDateTime.now());

        boolean result = ThongBaoDAO.insertRequestJoinClass(thongBao);
        if (result) {
            session.setAttribute("message", "✅ Gửi yêu cầu đăng ký thành công. Vui lòng chờ xác nhận từ quản trị.");
        } else {
            session.setAttribute("message", "❌ Không thể gửi yêu cầu đăng ký lớp. Vui lòng thử lại sau.");
        }

        response.sendRedirect("StudentViewLopTrongKhoaServlet");
    }
}
