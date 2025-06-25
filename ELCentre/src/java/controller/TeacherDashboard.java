/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.GiaoVien_LopHocDAO;
import dao.GiaoVienDAO;
import dao.LichHocDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;
import model.LichHoc;
import model.TaiKhoan;

/**
 *
 * @author admin
 */
public class TeacherDashboard extends HttpServlet {
   
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
            out.println("<title>Servlet TeacherDashboard</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TeacherDashboard at " + request.getContextPath () + "</h1>");
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
        HttpSession session = request.getSession();
        //Get Session User to get data
        TaiKhoan user = (TaiKhoan)session.getAttribute("user");
        
        GiaoVien_LopHocDAO gvLhDAO = new GiaoVien_LopHocDAO();//Initiallize GiaoVienLopHocDAO
        int numLopHoc = GiaoVien_LopHocDAO.teacherGetTongSoLopHoc(user.getID_TaiKhoan());//get teacher's num of classes
        int numHocSinh = GiaoVien_LopHocDAO.teacherGetTongSoHocSinh(user.getID_TaiKhoan());//get teacher's num of students
        
        GiaoVienDAO dao = new GiaoVienDAO();//Initiallize GiaoVienDAO
        double luongGV = dao.getLuongTheoTaiKhoan(user.getID_TaiKhoan());//get teacher's salary
        DecimalFormat df = new DecimalFormat("#,###");//format salary of teacher
        String luongGv = df.format(luongGV);
              
        LocalDate startOfWeek = LocalDate.now().with(DayOfWeek.MONDAY);//Initiallize the start day of week
        LocalDate endOfWeek = LocalDate.now().with(DayOfWeek.SUNDAY);//Initiallize the end day of week
        //Get Schedule of week
        List<LichHoc> fullList = LichHocDAO.getLichHocTrongTuan(user.getID_TaiKhoan(), startOfWeek, endOfWeek);

        // Pagination
        int pageSize = 10; // In a Page 10 items
        int page = 1;//set default page = 1
        String pageParam = request.getParameter("page");//get item name = page from jsp 
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);//parse page from string to int
        }
        int total = fullList.size();
        int fromIndex = Math.max((page - 1) * pageSize, 0);
        int toIndex = Math.min(fromIndex + pageSize, total);
        List<LichHoc> pageList = fullList.subList(fromIndex, toIndex);//get pageList from schedule subList

        // request to jsp
        request.setAttribute("tkbTrongTuan", pageList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", (int) Math.ceil((double) total / pageSize));    
        session.setAttribute("user", user);
        request.setAttribute("numLopHoc", numLopHoc);
        request.setAttribute("numHocSinh", numHocSinh);
        request.setAttribute(("luongGV"), luongGv);
        request.setAttribute("startOfWeek", startOfWeek);
        request.getRequestDispatcher("views/teacher/teacherDashboard.jsp").forward(request, response);
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
