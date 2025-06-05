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
import java.text.Normalizer;
import java.util.List;
import java.util.regex.Pattern;
import model.KhoaHoc;

/**
 *
 * @author Vuh26
 */
public class SortForResultFind extends HttpServlet {

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
            out.println("<title>Servlet SortForResultFind</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SortForResultFind at " + request.getContextPath() + "</h1>");
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

        int pageSize = 8;
        int pageNumber = 1;

        String pageParam = request.getParameter("page");
        String sortName = request.getParameter("sortName");
        String searchName = request.getParameter("name"); // lấy từ input hidden name="name"
        if (searchName != null) {
            searchName = searchName.trim().replaceAll("\\s+", " ");
            searchName = removeAccent(searchName); // Gọi hàm bạn đã có
        }

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

        int offset = (pageNumber - 1) * pageSize;
        List<KhoaHoc> khoaHocList;
        int totalCourses;

        boolean hasSearchName = searchName != null && !searchName.trim().isEmpty();

        // Lọc theo tên nếu có
        if (hasSearchName) {
            switch (sortName != null ? sortName : "") {
                case "":
                    // Chỉ tìm theo tên
                    khoaHocList = KhoaHocDAO.getCoursesByTen(searchName, offset, pageSize);
                    totalCourses = KhoaHocDAO.getTotalCoursesByTen(searchName);
                    break;

                case "ASCTrang":
                    khoaHocList = KhoaHocDAO.getCoursesByTrangThaiVaTen("active", searchName, offset, pageSize);
                    totalCourses = KhoaHocDAO.getTotalCoursesByTrangThaiVaTen("active", searchName);
                    break;
                case "DESCTrang":
                    khoaHocList = KhoaHocDAO.getCoursesByTrangThaiVaTen("inactive", searchName, offset, pageSize);
                    totalCourses = KhoaHocDAO.getTotalCoursesByTrangThaiVaTen("inactive", searchName);
                    break;
                default:
                    // Chỉ tìm theo tên
                    khoaHocList = KhoaHocDAO.getCoursesByTen(searchName, offset, pageSize);
                    totalCourses = KhoaHocDAO.getTotalCoursesByTen(searchName);
                    break;
            }
        } else {
            // Không tìm theo tên
            switch (sortName != null ? sortName : "") {
                case "ASC":
                case "DESC":
                    khoaHocList = KhoaHocDAO.getSortedKhoaHoc(offset, pageSize, sortName);
                    totalCourses = KhoaHocDAO.getTotalCourses();
                    break;
                case "ASCTrang":
                    khoaHocList = KhoaHocDAO.getCoursesByTrangThai("đang hoạt động", offset, pageSize);
                    totalCourses = KhoaHocDAO.countCoursesByTrangThai("đang hoạt động");
                    break;
                case "DESCTrang":
                    khoaHocList = KhoaHocDAO.getCoursesByTrangThai("chưa hoạt động", offset, pageSize);
                    totalCourses = KhoaHocDAO.countCoursesByTrangThai("chưa hoạt động");
                    break;
                default:
                    khoaHocList = KhoaHocDAO.getKhoaHoc(offset, pageSize);
                    totalCourses = KhoaHocDAO.getTotalCourses();
                    break;
            }
        }

        int totalPages = (int) Math.ceil((double) totalCourses / pageSize);

        request.setAttribute("list", khoaHocList);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortName", sortName);
        request.setAttribute("searchName", searchName);
        request.setAttribute("totalCourses", totalCourses);

        request.getRequestDispatcher("/views/ResultFind.jsp").forward(request, response);
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

    
    public static String removeAccent(String s) {
        if (s == null) return "";
        String temp = Normalizer.normalize(s, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(temp).replaceAll("").replaceAll("đ", "d").replaceAll("Đ", "D");
    }
}
