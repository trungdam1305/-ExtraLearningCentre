/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.GiaoVienDAO;
import dal.HocSinhDAO;
import dal.ThongBaoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author wrx_Chur04
 */
public class adminActionWithNotification extends HttpServlet {

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
            out.println("<title>Servlet adminActionWithNotification</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminActionWithNotification at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    protected void doSendNTFToClass(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ID_LopHoc = request.getParameter("ID_LopHoc");
        ArrayList<String> listID_HS = HocSinhDAO.adminGetListIDHSbyID_LopHoc(ID_LopHoc);
        String ID_GiaoVien = GiaoVienDAO.adminGetIdGiaoVienToSendNTF(ID_LopHoc);
        request.setAttribute("listID_HS", listID_HS);
        request.setAttribute("ID_GiaoVien", ID_GiaoVien);
        String noidungGV = request.getParameter("noidungGV");
        String noidungHS = request.getParameter("noidungHS");
        boolean s1 = ThongBaoDAO.adminSendClassNotification(listID_HS, noidungHS);
        boolean s2 = ThongBaoDAO.adminSendNotification(ID_GiaoVien, noidungGV);

        if (s1 && s2) {
            request.setAttribute("message", "Gửi thông báo thành công!");
            request.getRequestDispatcher("/views/admin/adminReceiveThongBao.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Gửi thông báo thất bại!");
            request.getRequestDispatcher("/views/admin/adminReceiveThongBao.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        switch (type) {
            case "sendToClass":
                doSendNTFToClass(request, response);
                break;
        }

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
