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

        //Initialize Session
        HttpSession session = request.getSession();
        
        //Display HomePage Teacher (Specialised Teacher)
        setGiaoVienCoDinh(session);
        
        //Initialize KhoaHocDAO and show number of course
        KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
        int numKhoaHoc = khoaHocDAO.getTotalCourses();
        
        
        //Initiaolize HocSinhDAO and show number of student
        HocSinhDAO hocSinhDAO = new HocSinhDAO();
        int numHocSinh = hocSinhDAO.getTotalHocSinh();
        
        
        //Initialize LopHocDAo 
        LopHocDAO lopHocDAO = new LopHocDAO();
        //show all number of class
        int numLopHoc = lopHocDAO.getTotalLopHoc();
        
        
        //show all available class
        List<LopHoc> lopHoc = lopHocDAO.getAllLopHoc();
        
        //Initialize KhoiHocDAO
        KhoiHocDAO khoiHocDAO = new KhoiHocDAO();
        List<KhoiHoc> listKhoi = khoiHocDAO.getAllKhoiHoc();
            
        //Initialize BlogDAO
        BlogDAO blogDAO = new BlogDAO();
        List<Blog> listBlog = blogDAO.getAllBlog();
        
        //Initialize GiaoVienDAO
        GiaoVienDAO gvDAO = new GiaoVienDAO();
        List<GiaoVien> listGiaoVien = gvDAO.HomePageGetGiaoVien();
        
        
        //Set Attribute for request to HomePage
        request.setAttribute("listGiaoVien", listGiaoVien);
        request.setAttribute("listBlog", listBlog);
        request.setAttribute("listKhoi", listKhoi);
        request.setAttribute("lopHoc", lopHoc);
        request.setAttribute("numLopHoc", numLopHoc);
        request.setAttribute("numHocSinh", numHocSinh);
        request.setAttribute("numKhoaHoc", numKhoaHoc);
        request.getRequestDispatcher("views/HomePage.jsp").forward(request, response);
    } 
    //Debugging to Test the DAO and Function
    public static void main(String[] args) {
        LopHocDAO lopHocDAO = new LopHocDAO();
        List<LopHoc> lop = lopHocDAO.getAllLopHoc();
        for (LopHoc lops : lop){
            System.out.println(lops.getID_KhoaHoc() + lops.getImage());
        }
        System.out.println("Số lớp học lấy được: " + (lop == null ? "null" : lop.size())); 
    }
    
    //Set Specialised Teacher
private void setGiaoVienCoDinh(HttpSession session) {
    String[] tenGiaoVien = {
        "Đàm Quang Trung",
        "Vũ Văn Chủ",
        "Vũ Minh Hoàng",
        "Đỗ Huy Đô",
        "Ngô Xuân Tuấn Dũng"
    };
    
    GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
    
    for (int i = 0; i < tenGiaoVien.length; i++) {
        GiaoVien gv = giaoVienDAO.getGiaoVienByHoTen(tenGiaoVien[i]);
        session.setAttribute("giaoVien" + (i + 1), gv);
    }
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
