/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.HocPhiDAO;
import dal.HocSinhDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.GiaoVien_ChiTietDay;
import model.HocPhi;
import model.TaiKhoan;

/**
 *
 * @author wrx_Chur04
 */
public class ParentActionWithTuition extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ParentActionWithTuition</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ParentActionWithTuition at " + request.getContextPath() + "</h1>");
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
                
            case "viewHP" : 
                doViewHP(request, response) ; 
                break ; 
        }
    }

    protected void doView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String ID_HocSinh = request.getParameter("id");
        int idHocSinh = Integer.parseInt(ID_HocSinh) ; 
        ArrayList<GiaoVien_ChiTietDay> lophocs = HocPhiDAO.GetAllLopHocDangHocChiTietHocSinhToSendHocPhi(idHocSinh);

        if (lophocs == null) {
            request.setAttribute("message", "Không có biểu lớp nào để xem biểu học phí");
            request.getRequestDispatcher("/views/parent/parentViewAllClassOfChildPayment.jsp").forward(request, response);
        } else {
            session.setAttribute("ID_HocSinhH", ID_HocSinh);
            session.setAttribute("lophocs", lophocs);
            request.getRequestDispatcher("/views/parent/parentViewAllClassOfChildPayment.jsp").forward(request, response);
        }

    }
    
    protected void doViewHP(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        String ID_LopHoc = request.getParameter("idLop") ; 
        String TenLopHoc = request.getParameter("TenLopHoc") ; 
       
        String idStr = (String) request.getSession().getAttribute("ID_HocSinhH");
        int ID_HocSinh = Integer.parseInt(idStr);

        PrintWriter out = response.getWriter() ; 
        
        ArrayList<HocPhi> hocphis = HocPhiDAO.GetAllInforHocPhiLopHocHocSinh(ID_LopHoc , ID_HocSinh ) ; 
        if (hocphis != null ) {
            request.setAttribute("hocphis", hocphis);
            request.setAttribute("TenLopHoc", TenLopHoc);
            request.getRequestDispatcher("/views/parent/parentReceiveHocPhi.jsp").forward(request, response);
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
