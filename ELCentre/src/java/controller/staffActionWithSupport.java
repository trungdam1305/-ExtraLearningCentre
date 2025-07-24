/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.HoTroDAO;
import dal.TaiKhoanDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.HoTro;
import model.TaiKhoan;

/**
 *
 * @author wrx_Chur04
 */
public class staffActionWithSupport extends HttpServlet {

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
            out.println("<title>Servlet staffActionWithSupport</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet staffActionWithSupport at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        ArrayList<HoTro> hotros = HoTroDAO.getHoTroByIdTaiKhoan(user.getID_TaiKhoan());
        if (hotros != null) {
            request.setAttribute("hotros", hotros);
            request.getRequestDispatcher("/views/staff/staffReceiveHoTroCuaMinh.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Bạn chưa gửi hỗ trợ nào");
            request.getRequestDispatcher("/views/staff/staffReceiveHoTroCuaMinh.jsp").forward(request, response);
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenhotro = request.getParameter("tenHoTro");
        String mota = request.getParameter("moTa");
        String IDTaiKhoan = request.getParameter("idTaiKhoan");
        String sdt = TaiKhoanDAO.admingetSDTTaiKhoanByID(IDTaiKhoan);
        String hoten = TaiKhoanDAO.adminGetNameTaiKhoanByID(IDTaiKhoan);
        boolean s1 = HoTroDAO.sendHoTroByIdTaiKhoan(mota, tenhotro, mota, IDTaiKhoan, "Staff", sdt);
        if (s1) {
            HttpSession session = request.getSession();
            ArrayList<HoTro> HoTroList = HoTroDAO.staffGetHoTroDashBoard();
            request.setAttribute("message", "Gửi hỗ trợ thành công");
            session.setAttribute("HoTroList", HoTroList);
            request.getRequestDispatcher("/views/staff/staffViewHoTro.jsp").forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}