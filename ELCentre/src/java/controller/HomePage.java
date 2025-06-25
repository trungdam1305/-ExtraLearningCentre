/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.BlogDAO;
import dao.GiaoVienDAO;
import dao.HocSinhDAO;
import dao.KhoaHocDAO;
import dao.KhoiHocDAO;
import dao.LopHocDAO;
import dao.SliderDAO;
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
            out.println("<title>Servlet HomePage</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePage at " + request.getContextPath () + "</h1>");
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

    // DAO init
    KhoaHocDAO khoaHocDAO = new KhoaHocDAO();//Initiallize KhoaHocDAO
    HocSinhDAO hocSinhDAO = new HocSinhDAO();//Initiallize HocSinhDAO
    LopHocDAO lopHocDAO = new LopHocDAO();//Initiallize LopHocDAO
    KhoiHocDAO khoiHocDAO = new KhoiHocDAO();//Initiallize KhoiHocDAO
    BlogDAO blogDAO = new BlogDAO();//Initiallize BlogDAO
    SliderDAO sliderDAO = new SliderDAO();//Initiallize SliderDAO
    GiaoVienDAO gvDAO = new GiaoVienDAO();//Initiallize GiaoVienDAO
    
    // Get Data with DAO
    List<GiaoVien> listSpecialGV = gvDAO.getSpecialised(); //get Hot Teacher
    int numKhoaHoc = khoaHocDAO.getTotalCourses();  //get num of Course in centre
    int numHocSinh = hocSinhDAO.getTotalHocSinh(); //get num of Student in centre
    int numLopHoc = lopHocDAO.getTotalLopHoc(); //get num of classes in centre
    List<LopHoc> lopHoc = lopHocDAO.getAllFeaturedLopHoc();//get List Feature Class
    List<LopHocTheoNhomDTO> listLopHoc = lopHocDAO.getTongLopHocTheoNhomMonHoc();//get List Class divided by Subject
    List<KhoiHoc> listKhoi = khoiHocDAO.getAllKhoiHoc();//get List Grade
    List<Blog> listBlog = blogDAO.getBlogsByTrungTam("Trung Tâm");//get ListBlog that refer to centre
    List<GiaoVien> listGiaoVien = gvDAO.HomePageGetGiaoVien();//get List Teacher
    List<Slider> sliders = sliderDAO.getAllSlider();//get List Slide
    

    // Set data to request and send to jsp
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

    // forward to jsp
    request.getRequestDispatcher("views/HomePage.jsp").forward(request, response);
}

    //Debugging to Test the DAO and Function
    public static void main(String[] args) {
    GiaoVienDAO gvDAO = new GiaoVienDAO();
    KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
    HocSinhDAO hocSinhDAO = new HocSinhDAO();
    LopHocDAO lopHocDAO = new LopHocDAO();
    KhoiHocDAO khoiHocDAO = new KhoiHocDAO();
    BlogDAO blogDAO = new BlogDAO();

    List<GiaoVien> listSpecialGV = gvDAO.getSpecialised();
    int numKhoaHoc = khoaHocDAO.getTotalCourses();
    int numHocSinh = hocSinhDAO.getTotalHocSinh();
    int numLopHoc = lopHocDAO.getTotalLopHoc();
    List<LopHoc> lopHoc = lopHocDAO.getAllFeaturedLopHoc();
    List<LopHocTheoNhomDTO> listLopHoc = lopHocDAO.getTongLopHocTheoNhomMonHoc();
    List<KhoiHoc> listKhoi = khoiHocDAO.getAllKhoiHoc();
    List<Blog> listBlog = blogDAO.getAllBlog();
    List<GiaoVien> listGiaoVien = gvDAO.HomePageGetGiaoVien();

    System.out.println("listLopHoc size: " + (listLopHoc == null ? 0 : listLopHoc.size()));
    System.out.println("listKhoi size: " + (listKhoi == null ? 0 : listKhoi.size()));
    System.out.println("listSpecialGV size: " + (listSpecialGV == null ? 0 : listSpecialGV.size()));
    System.out.println("listGiaoVien size: " + (listGiaoVien == null ? 0 : listGiaoVien.size()));
    System.out.println("numKhoaHoc: " + numKhoaHoc);
    System.out.println("numHocSinh: " + numHocSinh);
    System.out.println("numLopHoc: " + numLopHoc);
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
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
