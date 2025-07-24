/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.GiaoVienDAO;
import dal.HoTroDAO;
import dal.HocSinhDAO;
import dal.LopHocDAO;
import dal.StaffDAO;
import dal.ThongBaoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.HoTro;
import model.Staff;
import model.TaiKhoan;
import model.ThongBao;

/**
 *
 * @author wrx_Chur04
 */
public class staffGoToFirstPage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet staffGoToFirstPage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet staffGoToFirstPage at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession() ; 
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        
        ArrayList<Staff> staffs = StaffDAO.getNameStaff(user.getID_TaiKhoan());
        Integer tongSoHocSinhDangHoc = HocSinhDAO.adminGetTongSoHocSinhDangHoc();
        Integer tongSoDonTuVan = ThongBaoDAO.getSoTuVan() ; 
        Integer tongSoGiaoVienDangDay = GiaoVienDAO.adminGetTongSoGiaoVienDangDay();
        Integer tongSoLopHocDangHoc = LopHocDAO.adminGetTongSoLopHocDangHoc();
        Integer tongSoHocSinhChoHoc = HocSinhDAO.adminGetTongSoHocSinhChoHoc();
        ArrayList<HoTro> HoTroList = (ArrayList) HoTroDAO.staffGetHoTroDashBoard();
        ArrayList<ThongBao> ConsultationList = ThongBaoDAO.getAllTuVan();
        request.setAttribute("ConsultationList", ConsultationList);
        request.setAttribute("staffs", staffs);
        request.setAttribute("tongSoDonTuVan", tongSoDonTuVan);
        request.setAttribute("tongHS", tongSoHocSinhDangHoc);
        request.setAttribute("tongGV", tongSoGiaoVienDangDay);
        request.setAttribute("tongLH", tongSoLopHocDangHoc);
        request.setAttribute("hsChoHoc", tongSoHocSinhChoHoc);

        request.setAttribute("HoTroList", HoTroList);

        request.getRequestDispatcher("/views/staff/staffDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
