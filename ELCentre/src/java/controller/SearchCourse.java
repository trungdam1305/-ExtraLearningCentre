/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.KhoaHocDAO;
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
public class SearchCourse extends HttpServlet {

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
            out.println("<title>Servlet SearchCourse</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchCourse at " + request.getContextPath() + "</h1>");
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
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");

    String name = request.getParameter("name");

    if (name == null || name.trim().isEmpty()) {
        response.getWriter().println("Vui lòng nhập tên khóa học cần tìm.");
        return;
    }

    // CHUẨN HÓA CHUỖI TÌM KIẾM
    String normalizedName = name.trim().replaceAll("\\s+", " ");

    // Tính tổng số khóa học sau khi tìm kiếm
    int totalCourses = KhoaHocDAO.getTotalCoursesByName(normalizedName);

    int pageSize = 6;
    int pageNumber = 1;

    String pageParam = request.getParameter("page");
    if (pageParam != null) {
        try {
            pageNumber = Integer.parseInt(pageParam);
            if (pageNumber < 1) {
                pageNumber = 1;
            }
        } catch (NumberFormatException e) {
            pageNumber = 1;
        }
    }

    int totalPages = (int) Math.ceil((double) totalCourses / pageSize);
    int offset = (pageNumber - 1) * pageSize;

    // Lấy danh sách phân trang
    List<KhoaHoc> list = KhoaHocDAO.getKhoaHocByNamePaging(normalizedName, offset, pageSize);

    if (list == null || list.isEmpty()) {
        request.setAttribute("err", "Không tìm thấy khóa học nào với tên chứa: " + normalizedName);
        request.getRequestDispatcher("/views/ManagerCourses2.jsp").forward(request, response);
    } else {
        request.setAttribute("totalCourses", totalCourses);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortName", "");
        request.setAttribute("searchName", name); // giữ lại chuỗi gốc người dùng nhập để hiển thị lại
        request.setAttribute("list", list);
        request.getRequestDispatcher("/views/ResultFind.jsp").forward(request, response);
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

    public static void main(String[] args) {
        String testName = "toán"; // Tên khóa học muốn tìm

        List<KhoaHoc> list = KhoaHocDAO.getKhoaHocByName(testName);

        if (list == null) {
            System.out.println("Lỗi khi truy vấn database hoặc không có kết quả trả về.");
        } else if (list.isEmpty()) {
            System.out.println("Không tìm thấy khóa học nào với tên chứa: " + testName);
        } else {
            System.out.println("Danh sách khóa học tìm được:");
            for (KhoaHoc kh : list) {
                System.out.println("ID: " + kh.getID_KhoaHoc() + ", Tên: " + kh.getTenKhoaHoc());
            }
        }
    }

    private String normalizeSearchString(String input) {
        // Loại bỏ khoảng trắng đầu/cuối và thay thế nhiều khoảng trắng liên tiếp bằng 1 khoảng trắng
        return input.trim().replaceAll("\\s+", " ");
    }
    
 

}
