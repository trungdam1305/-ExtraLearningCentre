    
package controller;

import dao.GiaoVienDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.GiaoVien;
import model.GiaoVien_TruongHoc;
import model.GiaoVien_ChiTietDay ; 
import dao.GiaoVien_ChiTietDayDAO ; 

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
        String idGiaoVien = request.getParameter("id") ; 
                
        switch (action) {
            case "view":
                doView(request, response) ; 
                break;

            case "viewLopHocGiaoVien":
                doViewLopHocGiaoVien(request, response) ; 
                break;

            case "update":
                break;
        }
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

    
    
    protected void doView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ID = request.getParameter("id") ; 
        String ID_TaiKhoan = request.getParameter("idTaiKhoan") ; 
        ArrayList<GiaoVien_TruongHoc> giaoviens = GiaoVienDAO.adminGetGiaoVienByID(ID_TaiKhoan) ; 
        if (giaoviens != null ) {
            request.setAttribute("giaoviens", giaoviens);
            request.getRequestDispatcher("/views/admin/adminViewGiaoVienChiTiet.jsp").forward(request, response);
        }
    }
    
    
    protected void doViewLopHocGiaoVien(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ID = request.getParameter("id") ; 
        
        ArrayList<GiaoVien_ChiTietDay> giaoviens = GiaoVien_ChiTietDayDAO.adminGetAllLopHocGiaoVien(ID) ; 
        if (giaoviens != null ) {
            request.setAttribute("giaoviens", giaoviens);
            request.getRequestDispatcher("/views/admin/adminViewLopHocGiaoVien.jsp").forward(request, response);
        }
    }
}
