
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.GiaoVienDAO;
import dal.HocSinh_SDTDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.GiaoVien;
import model.GiaoVien_TruongHoc;
import model.HocSinh_SDT;

/**
 *
 * @author wrx_Chur04
 */
public class adminFindInFilterGroup extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet adminFindInFilterGroup</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminFindInFilterGroup at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String khoa = request.getParameter("khoa");

        if (keyword == null) {
            keyword = "";
        }
        keyword = keyword.trim();

        if (status == null) {
            status = "";
        }

        if (khoa == null) {
            khoa = "";
        }
        PrintWriter out = response.getWriter();
        ArrayList<HocSinh_SDT> filteredList = HocSinh_SDTDAO.adminGetHocSinhFilter(keyword, status, khoa);

        session.setAttribute("hocsinhs", filteredList);
        request.getRequestDispatcher("/views/admin/adminReceiveHocSinh.jsp").forward(request, response);
    }

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession() ; 
        String keyword = request.getParameter("keyword");
        String chuyenmon = request.getParameter("chuyenmon");
        String trangthai = request.getParameter("trangthaiday");

        if (keyword == null) {
            keyword = "";
        }
        if (chuyenmon == null) {
            chuyenmon = "";
        }
        if (trangthai == null) {
            trangthai = "";
        }

        ArrayList<GiaoVien_TruongHoc> filtered = HocSinh_SDTDAO.adminGetGiaoVienFilter(keyword.trim(), chuyenmon, trangthai);
        session.setAttribute("giaoviens", filtered);
        request.getRequestDispatcher("/views/admin/adminReceiveGiaoVien.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
