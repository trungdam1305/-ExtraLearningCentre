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
public class Course_Sort extends HttpServlet {

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
            out.println("<title>Servlet Sort</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Sort at " + request.getContextPath() + "</h1>");
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
        int pageSize = 6;
        int pageNumber = 1;
        String pageParam = request.getParameter("page");
        String sortName = request.getParameter("sortName");

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

        if (sortName != null && !sortName.isEmpty()) {
            switch (sortName) {
                case "ended":
                    khoaHocList = KhoaHocDAO.getCoursesByTrangThai("đã kết thúc", offset, pageSize);
                    totalCourses = KhoaHocDAO.countCoursesByTrangThai("đã kết thúc");
                    break;
                case "active":
                    khoaHocList = KhoaHocDAO.getCoursesByTrangThai("đang hoạt động", offset, pageSize);
                    totalCourses = KhoaHocDAO.countCoursesByTrangThai("đang hoạt động");
                    break;
                case "notStarted":
                    khoaHocList = KhoaHocDAO.getCoursesByTrangThai("chưa bắt đầu", offset, pageSize);
                    totalCourses = KhoaHocDAO.countCoursesByTrangThai("chưa bắt đầu");
                    break;
                case "ASC":
                case "DESC":
                    khoaHocList = KhoaHocDAO.getSortedKhoaHoc(offset, pageSize, sortName);
                    totalCourses = KhoaHocDAO.getTotalCourses();
                    break;
                default:
                    khoaHocList = KhoaHocDAO.getKhoaHoc(offset, pageSize);
                    totalCourses = KhoaHocDAO.getTotalCourses();
                    break;
            }
        } else {
            khoaHocList = KhoaHocDAO.getKhoaHoc(offset, pageSize);
            totalCourses = KhoaHocDAO.getTotalCourses();
        }

        int totalPages = (int) Math.ceil((double) totalCourses / pageSize);

        request.setAttribute("defaultCourses", khoaHocList);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortName", sortName);

        request.getRequestDispatcher("/views/ManagerCourses2.jsp").forward(request, response);

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

}
