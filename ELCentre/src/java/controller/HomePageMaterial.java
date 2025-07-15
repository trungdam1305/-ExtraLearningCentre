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

        // --- 1. Lấy các tham số từ request ---
        String keyword = request.getParameter("keyword");
        String monHocIdParam = request.getParameter("monHocId");
        String loaiTaiLieuIdParam = request.getParameter("loaiTaiLieuId");
        String pageParam = request.getParameter("page");

        // --- 2. Chuyển đổi tham số sang kiểu số ---
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
        } catch (NumberFormatException e) { /* Bỏ qua, giữ giá trị null */ }

        int page = 1;
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) { page = 1; }
        
        // --- 3. Khởi tạo DAO và truy vấn dữ liệu ---
        DangTaiLieuDAO dao = new DangTaiLieuDAO();

        List<DangTaiLieu> listTaiLieu = dao.getFilteredMaterials(keyword, monHocId, loaiTaiLieuId, page, PAGE_SIZE);
        int totalMaterials = dao.countFilteredMaterials(keyword, monHocId, loaiTaiLieuId);
        int totalPages = (int) Math.ceil((double) totalMaterials / PAGE_SIZE);

        List<MonHoc> listMonHoc = dao.getAllMonHoc();
        List<LoaiTaiLieu> listLoaiTaiLieu = dao.getAllLoaiTaiLieu();

        // --- 4. Đặt các thuộc tính vào request để gửi tới JSP ---
        request.setAttribute("listTaiLieu", listTaiLieu);
        request.setAttribute("listMonHoc", listMonHoc); // Gửi danh sách đối tượng Môn Học
        request.setAttribute("listLoaiTaiLieu", listLoaiTaiLieu); // Gửi danh sách đối tượng Loại Tài Liệu
        
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);

        // Giữ lại giá trị của các bộ lọc
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedMonHocId", monHocId); // ID môn học đã chọn
        request.setAttribute("selectedLoaiTaiLieuId", loaiTaiLieuId); // ID loại tài liệu đã chọn

        // --- 5. Forward tới trang JSP ---
        request.getRequestDispatcher("views/Home-Material/Homepage-Material.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
    }
}