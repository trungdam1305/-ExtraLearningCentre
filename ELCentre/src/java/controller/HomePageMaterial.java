/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.DangTaiLieuDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DangTaiLieu;

/**
 *
 * @author admin
 */
public class HomePageMaterial extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet HomePageMaterial</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePageMaterial at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //Initiallize DangTaiLieuDAO
        DangTaiLieuDAO dao = new DangTaiLieuDAO();
        //Initiallize Page for pagination
        int page = 1;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        List<String> listDanhMuc = dao.getAllDanhMuc();//Initiallize all Danh Muc List
        List<DangTaiLieu> list = dao.getTaiLieuByPage(page);//get Tai Lieu by Page
        int total = dao.countTaiLieu();//count Material
        int totalPages = (int) Math.ceil(total / 12.0);
        int numToan = dao.getTaiLieuToan();//get num of Math Material
        int numVan = dao.getTaiLieuVan();//get num of Literature Material
        int numAnh = dao.getTaiLieuAnh();//get num of Englist Material
        
        // Set data to request and send to jsp
        request.setAttribute("listDanhMuc", listDanhMuc);
        request.setAttribute("numToan", numToan);
        request.setAttribute("numVan", numVan);
        request.setAttribute("numAnh", numAnh);
        request.setAttribute("listTaiLieu", list);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        // forward to jsp
        request.getRequestDispatcher("views/Home-Material/Homepage-Material.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //get data danhmuc from jsp
        String danhMuc = request.getParameter("danhmuc");
        //Initiallize DangTaiLieuDAO
        DangTaiLieuDAO dao = new DangTaiLieuDAO();
        List<DangTaiLieu> list1 = dao.searchByDanhMuc(danhMuc != null ? danhMuc : "");//search Material by DanhMuc
        // Set data to request and send to jsp
        request.setAttribute("listTaiLieu", list1);
        request.setAttribute("keyword", danhMuc);
        // forward to jsp
        request.getRequestDispatcher("views/Home-Material/Homepage-Material.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
