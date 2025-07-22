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

    private static final int PAGE_SIZE = 12;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // get parameter
        String keyword = request.getParameter("keyword");
        String monHocIdParam = request.getParameter("monHocId");
        String loaiTaiLieuIdParam = request.getParameter("loaiTaiLieuId");
        String pageParam = request.getParameter("page");

        Integer monHocId = null;
        try {
            if (monHocIdParam != null && !monHocIdParam.isEmpty()) {
                monHocId = Integer.parseInt(monHocIdParam);
            }
        } catch (NumberFormatException e) { /* Bỏ qua, giữ giá trị null */ }

        Integer loaiTaiLieuId = null;
        try {
            if (loaiTaiLieuIdParam != null && !loaiTaiLieuIdParam.isEmpty()) {
                loaiTaiLieuId = Integer.parseInt(loaiTaiLieuIdParam);
            }
        } catch (NumberFormatException e) {  }

        int page = 1;
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) { page = 1; }
        
        // Initiate DAO
        DangTaiLieuDAO dao = new DangTaiLieuDAO();

        List<DangTaiLieu> listTaiLieu = dao.getFilteredMaterials(keyword, monHocId, loaiTaiLieuId, page, PAGE_SIZE);
        int totalMaterials = dao.countFilteredMaterials(keyword, monHocId, loaiTaiLieuId);
        int totalPages = (int) Math.ceil((double) totalMaterials / PAGE_SIZE);

        List<MonHoc> listMonHoc = dao.getAllMonHoc();
        List<LoaiTaiLieu> listLoaiTaiLieu = dao.getAllLoaiTaiLieu();

        // set Attribute
        request.setAttribute("listTaiLieu", listTaiLieu);
        request.setAttribute("listMonHoc", listMonHoc); 
        request.setAttribute("listLoaiTaiLieu", listLoaiTaiLieu); 
        
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);

        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedMonHocId", monHocId); 
        request.setAttribute("selectedLoaiTaiLieuId", loaiTaiLieuId);

        // forward to JSP
        request.getRequestDispatcher("views/Home-Material/Homepage-Material.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
    }
}