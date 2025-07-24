// Author: trungdam
// Servlet: HomePageMaterial
package controller;

import dal.DangTaiLieuDAO;
import model.DangTaiLieu;
import model.LoaiTaiLieu;
import model.MonHoc;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

public class HomePageMaterial extends HttpServlet {

    private static final int PAGE_SIZE = 12; // Define the number of materials per page.

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Get parameters from the request for filtering and pagination.
        String keyword = request.getParameter("keyword");
        String monHocIdParam = request.getParameter("monHocId");
        String loaiTaiLieuIdParam = request.getParameter("loaiTaiLieuId");
        String pageParam = request.getParameter("page");

        // Parse 'monHocId' parameter, handling potential NumberFormatException.
        Integer monHocId = null;
        try {
            if (monHocIdParam != null && !monHocIdParam.isEmpty()) {
                monHocId = Integer.parseInt(monHocIdParam);
            }
        } catch (NumberFormatException e) { /* Ignore and keep as null if invalid */ }

        // Parse 'loaiTaiLieuId' parameter, handling potential NumberFormatException.
        Integer loaiTaiLieuId = null;
        try {
            if (loaiTaiLieuIdParam != null && !loaiTaiLieuIdParam.isEmpty()) {
                loaiTaiLieuId = Integer.parseInt(loaiTaiLieuIdParam);
            }
        } catch (NumberFormatException e) { /* Ignore and keep as null if invalid */ }

        // Parse 'page' parameter, defaulting to 1 if invalid or not provided.
        int page = 1;
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) { page = 1; }
        
        // Initialize the Data Access Object (DAO) for materials.
        DangTaiLieuDAO dao = new DangTaiLieuDAO();

        // Retrieve filtered materials based on keyword, subject, material type, and pagination.
        List<DangTaiLieu> listTaiLieu = dao.getFilteredMaterials(keyword, monHocId, loaiTaiLieuId, page, PAGE_SIZE);
        
        // Count total filtered materials to calculate total pages for pagination.
        int totalMaterials = dao.countFilteredMaterials(keyword, monHocId, loaiTaiLieuId);
        int totalPages = (int) Math.ceil((double) totalMaterials / PAGE_SIZE);

        // Retrieve lists of all subjects and material types for filter dropdowns.
        List<MonHoc> listMonHoc = dao.getAllMonHoc();
        List<LoaiTaiLieu> listLoaiTaiLieu = dao.getAllLoaiTaiLieu();

        // Set attributes for the JSP to display.
        request.setAttribute("listTaiLieu", listTaiLieu);         // List of materials for the current page
        request.setAttribute("listMonHoc", listMonHoc);           // List of all subjects
        request.setAttribute("listLoaiTaiLieu", listLoaiTaiLieu); // List of all material types
        
        request.setAttribute("totalPages", totalPages);           // Total number of pages
        request.setAttribute("currentPage", page);                // Current page number

        request.setAttribute("keyword", keyword);                   // Retain the search keyword in the input field
        request.setAttribute("selectedMonHocId", monHocId);         // Retain the selected subject filter
        request.setAttribute("selectedLoaiTaiLieuId", loaiTaiLieuId); // Retain the selected material type filter

        // Forward the request to the JSP page to render the material homepage.
        request.getRequestDispatcher("views/Home-Material/Homepage-Material.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // For this servlet, POST requests are handled the same way as GET requests.
        doGet(request, response);
    }
}