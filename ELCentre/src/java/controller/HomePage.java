// Author: trungdam
// Servlet: HomePage
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BlogDAO;
import dal.GiaoVienDAO;
import dal.HocSinhDAO;
import dal.KhoaHocDAO;
import dal.KhoiHocDAO;
import dal.LopHocDAO;
import dal.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Blog;
import model.GiaoVien;
import model.KhoaHoc;
import model.KhoiHoc;
import model.LopHoc;
import model.LopHocTheoNhomDTO;
import model.Slider;

/**
 *
 * @author admin
 */
public class HomePage extends HttpServlet {
    
    /** * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet HomePage</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePage at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");

    // Initialize Data Access Objects (DAOs) for database interaction.
    KhoaHocDAO khoaHocDAO = new KhoaHocDAO();    // For courses
    HocSinhDAO hocSinhDAO = new HocSinhDAO();    // For students
    LopHocDAO lopHocDAO = new LopHocDAO();      // For classes
    KhoiHocDAO khoiHocDAO = new KhoiHocDAO();    // For grades
    BlogDAO blogDAO = new BlogDAO();            // For blogs
    SliderDAO sliderDAO = new SliderDAO();      // For sliders
    GiaoVienDAO gvDAO = new GiaoVienDAO();      // For teachers
    
    // Retrieve various data from the database using the DAOs.
    List<GiaoVien> listSpecialGV = gvDAO.getSpecialised();                 // Get "hot" teachers
    int numKhoaHoc = khoaHocDAO.getTotalCourses();                         // Get total number of courses
    int numHocSinh = hocSinhDAO.getTotalHocSinh();                         // Get total number of students
    int numLopHoc = lopHocDAO.getTotalLopHoc();                             // Get total number of classes
    List<LopHoc> lopHoc = lopHocDAO.getAllFeaturedLopHoc();                // Get a list of featured classes
    List<LopHocTheoNhomDTO> listLopHoc = lopHocDAO.getTongLopHocTheoNhomMonHoc(); // Get classes grouped by subject
    List<KhoiHoc> listKhoi = khoiHocDAO.getAllKhoiHoc();                  // Get a list of grades
    List<Blog> listBlog = blogDAO.getFourBlog();                           // Get the latest four blog posts
    List<GiaoVien> listGiaoVien = gvDAO.HomePageGetGiaoVien();             // Get a general list of teachers for the homepage
    List<Slider> sliders = sliderDAO.getAllSlider();                       // Get all sliders for the homepage carousel
    
    // Set the retrieved data as attributes in the request to be accessed by the JSP.
    request.setAttribute("sliders", sliders);
    request.setAttribute("listLopHoc", listLopHoc);
    request.setAttribute("listSpecialGV", listSpecialGV);
    request.setAttribute("listGiaoVien", listGiaoVien);
    request.setAttribute("listBlog", listBlog);
    request.setAttribute("listKhoi", listKhoi);
    request.setAttribute("lopHoc", lopHoc);
    request.setAttribute("numLopHoc", numLopHoc);
    request.setAttribute("numHocSinh", numHocSinh);
    request.setAttribute("numKhoaHoc", numKhoaHoc);

    // Forward the request to the HomePage JSP for rendering.
    request.getRequestDispatcher("views/HomePage.jsp").forward(request, response);
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}