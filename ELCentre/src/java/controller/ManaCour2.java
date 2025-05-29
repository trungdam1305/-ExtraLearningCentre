/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.KhoaHocDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.KhoaHoc;

/**
 *
 * @author Vuh26
 */
public class ManaCour2 extends HttpServlet {
   
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
            out.println("<title>Servlet ManaCour2</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManaCour2 at " + request.getContextPath () + "</h1>");
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
        List<KhoaHoc> list = KhoaHocDAO.getKhoaHoc();
        request.setAttribute("list", list);
        request.getRequestDispatcher("views/ManagerCourses2.jsp").forward(request, response);
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

    
    public static void main(String[] args) {
        ArrayList<KhoaHoc> courses = KhoaHocDAO.getKhoaHoc();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        if (courses == null || courses.isEmpty()) {
            System.out.println("Không có khóa học nào hoặc xảy ra lỗi khi truy vấn.");
            return;
        }

        for (KhoaHoc course : courses) {
            System.out.println("ID: " + course.getID_KhoaHoc());
            System.out.println("Tên khóa học: " + course.getTenKhoaHoc());
            System.out.println("Mô tả: " + course.getMoTa());
            System.out.println("Thời gian bắt đầu: " + course.getThoiGianBatDau());
            System.out.println("Thời gian kết thúc: " + course.getThoiGianKetThuc());
            System.out.println("Ghi chú: " + course.getGhiChu());
            System.out.println("Trạng thái: " + course.getTrangThai());
            System.out.println("Ngày tạo: " + course.getNgayTao().format(formatter));
            System.out.println("-----------------------------------");
        }
    }
}
