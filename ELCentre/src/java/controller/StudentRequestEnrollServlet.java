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
        if (classCode == null || classCode.isEmpty()) {
            request.setAttribute("error", "Mã lớp không hợp lệ.");
            forward(request, response);
            return;
        }

        LopHoc lopHoc = LopHocDAO.getLopHocByClassCode(classCode);
        if (lopHoc == null) {
            request.setAttribute("error", "Không tìm thấy lớp học.");
            forward(request, response);
            return;
        }

        HocSinh hocSinh = HocSinhDAO.findByTaiKhoanId(user.getID_TaiKhoan());
        if (hocSinh == null) {
            request.setAttribute("error", "Không tìm thấy thông tin học sinh.");
            forward(request, response);
            return;
        }

        String lopTrenTruong = hocSinh.getLopDangHocTrenTruong();
        Optional<GiaoVien> giaoVien = GiaoVienDAO.findByLopHocId(lopHoc.getID_LopHoc());
        if (giaoVien.isPresent()) {
            String lopDayTrenTruong = giaoVien.get().getLopDangDayTrenTruong();
            if (lopTrenTruong != null && lopTrenTruong.equalsIgnoreCase(lopDayTrenTruong)) {
                request.setAttribute("error", "Lớp bạn đang học trùng với lớp giáo viên đang dạy trên trường.");
                forward(request, response);
                return;
            }
        }

        boolean daGui = ThongBaoDAO.checkRequestExists(user.getID_TaiKhoan(), classCode);
        if (daGui) {
            request.setAttribute("error", "Bạn đã gửi yêu cầu trước đó.");
            forward(request, response);
            return;
        }

        ThongBao thongBao = new ThongBao();
        thongBao.setID_TaiKhoan(user.getID_TaiKhoan());
        thongBao.setNoiDung("Yêu cầu đăng ký vào lớp " + classCode);
        thongBao.setThoiGian(LocalDateTime.now());

        boolean result = ThongBaoDAO.insertRequestJoinClass(thongBao);
        if (result) {
            request.setAttribute("success", "Gửi yêu cầu đăng ký thành công.");
        } else {
            request.setAttribute("error", "Không thể gửi yêu cầu.");
        }
        forward(request, response);
    }

    private void forward(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/student/studentViewLopTrongKhoa.jsp").forward(request, response);
    }
}