package controller;

import dal.BlogDAO;
import dal.StaffDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.*;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;


@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,   // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ManagePost extends HttpServlet {

    private final BlogDAO blogDAO;
    private final StaffDAO staffDAO; // Giữ lại để lấy thông tin header

    public ManagePost() {
        this.blogDAO = new BlogDAO();
        this.staffDAO = new StaffDAO(); // Khởi tạo
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        // Lấy thông tin staff cho header
        ArrayList<Staff> staffs = staffDAO.getNameStaff(user.getID_TaiKhoan());
        request.setAttribute("staffs", staffs);

        String action = request.getParameter("action");
        action = (action == null || action.isEmpty()) ? "list" : action;

        try {
            switch (action) {
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    handleDeleteBlog(request, response);
                    break;
                default: // "list"
                    handleListBlogs(request, response);
                    break;
            }
        } catch (Exception e) {
            log("Error in ManagePost doGet", e);
            request.setAttribute("errorMessage", "Đã xảy ra lỗi không mong muốn: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn phải đăng nhập để thực hiện hành động này.");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hành động không hợp lệ.");
            return;
        }

        try {
            switch (action) {
                case "addBlog":
                    handleAddBlog(request, response);
                    break;
                case "updateBlog":
                    handleUpdateBlog(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hành động không được hỗ trợ.");
                    break;
            }
        } catch (Exception e) {
            log("Error in ManagePost doPost", e);
            request.setAttribute("errorMessage", "Đã xảy ra lỗi không mong muốn: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    private void handleListBlogs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // CHỈNH SỬA: Logic lọc nhất quán với HomePageBlog
        int filterKeywordId = parseIntegerParameter(request.getParameter("keywordId"));
        int filterKeytagId = parseIntegerParameter(request.getParameter("keytagId"));
        int currentPage = parseIntegerParameter(request.getParameter("page"));
        if (currentPage == 0) currentPage = 1; // Mặc định là trang 1
        
        int pageSize = 5;

        List<Blog> blogList = blogDAO.getFilteredBlogs(filterKeywordId, filterKeytagId, currentPage, pageSize);
        int totalBlogs = blogDAO.countFilteredBlogs(filterKeywordId, filterKeytagId);
        int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);

        // Lấy dữ liệu cho dropdown filter
        request.setAttribute("allKeywords", blogDAO.getAllKeywords());
        request.setAttribute("allKeytags", blogDAO.getAllKeyTags());

        // Đặt thuộc tính cho JSP
        request.setAttribute("blogList", blogList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("selectedKeywordId", filterKeywordId);
        request.setAttribute("selectedKeytagId", filterKeytagId);
        
        request.getRequestDispatcher("/views/staff/managePost.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadDropdownData(request);
        request.setAttribute("formTitle", "Thêm Bài Viết Mới");
        request.setAttribute("formAction", "addBlog");
        request.getRequestDispatcher("/views/staff/addEditPost.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int blogId = parseIntegerParameter(request.getParameter("id"));
        if (blogId == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID bài viết không hợp lệ.");
            return;
        }

        Blog blog = blogDAO.getBlogById(blogId);
        if (blog == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy bài viết.");
            return;
        }

        loadDropdownData(request);
        request.setAttribute("blog", blog);
        request.setAttribute("formTitle", "Chỉnh Sửa Bài Viết");
        request.setAttribute("formAction", "updateBlog");
        request.getRequestDispatcher("/views/staff/addEditPost.jsp").forward(request, response);
    }
    
    private void handleAddBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // ... (Giữ nguyên logic handleAddBlog đã tối ưu từ trước)
        String blogTitle = request.getParameter("blogTitle");
        String blogDescription = request.getParameter("blogDescription");
        String noiDung = request.getParameter("noiDung");
        
        if (blogTitle == null || blogTitle.trim().isEmpty() ||
            blogDescription == null || blogDescription.trim().isEmpty() ||
            noiDung == null || noiDung.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Tiêu đề, mô tả và nội dung không được để trống.");
            showAddForm(request, response);
            return;
        }
        
        Blog newBlog = new Blog();
        newBlog.setBlogTitle(blogTitle);
        newBlog.setBlogDescription(blogDescription);
        newBlog.setNoiDung(noiDung);
        newBlog.setBlogDate(LocalDateTime.now());
        
        newBlog.setID_PhanLoai(parseIntegerParameter(request.getParameter("idPhanLoai")));
        newBlog.setID_KeyTag(parseIntegerParameter(request.getParameter("idKeyTag")));
        newBlog.setID_Keyword(parseIntegerParameter(request.getParameter("idKeyword")));

        String imageFileName = uploadImage(request);
        newBlog.setImage(imageFileName);
        
        blogDAO.addBlog(newBlog);
        response.sendRedirect(request.getContextPath() + "/ManagePost?message=add_success");
    }

    private void handleUpdateBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // ... (Giữ nguyên logic handleUpdateBlog đã tối ưu từ trước)
        int blogId = parseIntegerParameter(request.getParameter("id"));
        Blog existingBlog = blogDAO.getBlogById(blogId);

        if (existingBlog == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy bài viết để cập nhật.");
            return;
        }

        existingBlog.setBlogTitle(request.getParameter("blogTitle"));
        existingBlog.setBlogDescription(request.getParameter("blogDescription"));
        existingBlog.setNoiDung(request.getParameter("noiDung"));

        existingBlog.setID_PhanLoai(parseIntegerParameter(request.getParameter("idPhanLoai")));
        existingBlog.setID_KeyTag(parseIntegerParameter(request.getParameter("idKeyTag")));
        existingBlog.setID_Keyword(parseIntegerParameter(request.getParameter("idKeyword")));

        String newImageFileName = uploadImage(request);
        if (newImageFileName != null) {
            deleteOldImage(existingBlog.getImage(), request);
            existingBlog.setImage(newImageFileName);
        }

        blogDAO.updateBlog(existingBlog);
        response.sendRedirect(request.getContextPath() + "/ManagePost?message=update_success");
    }

    private void handleDeleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // ... (Giữ nguyên logic handleDeleteBlog đã tối ưu từ trước)
        int blogId = parseIntegerParameter(request.getParameter("id"));
        if (blogId == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID bài viết không hợp lệ.");
            return;
        }

        Blog blogToDelete = blogDAO.getBlogById(blogId);
        if (blogToDelete != null) {
            deleteOldImage(blogToDelete.getImage(), request);
            blogDAO.deleteBlog(blogId);
            response.sendRedirect(request.getContextPath() + "/ManagePost?message=delete_success");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy bài viết để xóa.");
        }
    }
    
    // --- CÁC PHƯƠNG THỨC HELPER GIỮ NGUYÊN ---
    private void loadDropdownData(HttpServletRequest request) {
        request.setAttribute("phanLoaiList", blogDAO.getAllPhanLoaiBlog());
        request.setAttribute("availableKeyTags", blogDAO.getAllKeyTags());
        request.setAttribute("availableKeywords", blogDAO.getAllKeywords());
    }

    private String uploadImage(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
            String originalFileName = filePart.getSubmittedFileName();
            String extension = "";
            int lastDotIndex = originalFileName.lastIndexOf('.');
            if (lastDotIndex > 0) {
                extension = originalFileName.substring(lastDotIndex);
            }
            String newFileName = UUID.randomUUID().toString() + extension;
            String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "blog_images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePart.write(uploadPath + File.separator + newFileName);
            return newFileName;
        }
        return null;
    }

    private void deleteOldImage(String fileName, HttpServletRequest request) {
        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "blog_images";
            File imageFile = new File(uploadPath + File.separator + fileName);
            if (imageFile.exists()) imageFile.delete();
        }
    }

    private int parseIntegerParameter(String param) {
        if (param == null || param.trim().isEmpty()) return 0;
        try {
            return Integer.parseInt(param);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing blog posts (CRUD operations).";
    }
}