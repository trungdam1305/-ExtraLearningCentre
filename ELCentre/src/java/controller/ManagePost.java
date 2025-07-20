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

import model.Blog;
import model.Staff;
import model.TaiKhoan;
import model.PhanLoaiBlog;
import model.KeyTag;
import model.Keyword;
import model.KhoiHoc;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ManagePost extends HttpServlet {

    private final BlogDAO blogDAO;
    private final StaffDAO staffDAO;
    // You'll need a KhoiHocDAO if you uncomment this
    // private final KhoiHocDAO khoiHocDAO;

    public ManagePost() {
        this.blogDAO = new BlogDAO();
        this.staffDAO = new StaffDAO();
        // this.khoiHocDAO = new KhoiHocDAO(); // Initialize if uncommented
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

        ArrayList<Staff> staffs = staffDAO.getNameStaff(user.getID_TaiKhoan());
        request.setAttribute("staffs", staffs);

        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "list";
        }
        
        try {
            switch(action) {
                case "list":
                    handleListBlogs(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    handleDeleteBlog(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action specified.");
                    break;
            }
        } catch (SQLException e) {
            log("Database error in ManagePost doGet: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            log("Invalid number format in ManagePost doGet: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Invalid input format for ID or year.");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        } catch (Exception e) {
            log("An unexpected error occurred in ManagePost doGet: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "An unexpected error occurred.");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "";
        }

        try {
            switch (action) {
                case "addBlog":
                    handleAddBlog(request, response);
                    break;
                case "updateBlog":
                    handleUpdateBlog(request, response);
                    break;
                case "deleteBlog":
                    handleDeleteBlog(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid or unsupported POST action.");
                    break;
            }
        } catch (SQLException e) {
            log("Database error in ManagePost doPost: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            log("Invalid number format in ManagePost doPost: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Invalid input format for ID or year.");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        } catch (Exception e) {
            log("An unexpected error occurred in ManagePost doPost: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "An unexpected error occurred.");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    private void handleListBlogs(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String idKeyTagParam = request.getParameter("idKeyTag");
        String yearParam = request.getParameter("year");
        String pageParam = request.getParameter("page");

        int currentPage = 1;
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid page parameter: " + pageParam, e);
        }
        int pageSize = 5;

        int filterKeyTagId = 0;
        try {
            if (idKeyTagParam != null && !idKeyTagParam.isEmpty()) {
                filterKeyTagId = Integer.parseInt(idKeyTagParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid KeyTag ID parameter: " + idKeyTagParam, e);
        }

        Integer filterYear = null;
        try {
            if (yearParam != null && !yearParam.isEmpty()) {
                filterYear = Integer.parseInt(yearParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid year parameter: " + yearParam, e);
        }
        
        List<Blog> blogList = blogDAO.getFilteredBlogs(keyword, filterKeyTagId, filterYear, currentPage, pageSize);
        int totalBlogs = blogDAO.countFilteredBlogs(keyword, filterKeyTagId, filterYear);
        
        List<KeyTag> availableKeyTags = blogDAO.getAllKeyTags();
        List<Integer> availableYears = blogDAO.getDistinctBlogYears();

        int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);

        request.setAttribute("blogList", blogList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedKeyTagId", filterKeyTagId);
        request.setAttribute("selectedYear", filterYear);
        
        List<PhanLoaiBlog> phanLoaiList = blogDAO.getAllPhanLoaiBlog(); 
        request.setAttribute("phanLoaiList", phanLoaiList);

        // If you had khoiHocList here, it would also be passed to managePost.jsp
        // List<KhoiHoc> khoiHocList = khoiHocDAO.getAllKhoiHoc(); 
        // request.setAttribute("khoiHocList", khoiHocList);

        request.getRequestDispatcher("/views/staff/managePost.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        List<PhanLoaiBlog> phanLoaiList = blogDAO.getAllPhanLoaiBlog(); 
        request.setAttribute("phanLoaiList", phanLoaiList);

        List<KeyTag> availableKeyTags = blogDAO.getAllKeyTags(); 
        request.setAttribute("availableKeyTags", availableKeyTags);
        
        List<Keyword> availableKeywords = blogDAO.getAllKeywords();
        request.setAttribute("availableKeywords", availableKeywords);

        // --- NEW: Fetch available KhoiHoc List ---
        // You'll need to uncomment this if KhoiHoc is enabled
        // List<KhoiHoc> khoiHocList = khoiHocDAO.getAllKhoiHoc(); 
        // request.setAttribute("khoiHocList", khoiHocList);

        request.setAttribute("blog", null);
        request.setAttribute("formTitle", "Thêm Blog Mới");
        request.getRequestDispatcher("/views/staff/addEditPost.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        int blogId = 0;
        try {
            blogId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid blog ID for editing.");
            return;
        }

        Blog blog = blogDAO.getBlogById(blogId);

        if (blog == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Blog not found for editing.");
            return;
        }

        List<PhanLoaiBlog> phanLoaiList = blogDAO.getAllPhanLoaiBlog(); 
        request.setAttribute("phanLoaiList", phanLoaiList);

        List<KeyTag> availableKeyTags = blogDAO.getAllKeyTags(); 
        request.setAttribute("availableKeyTags", availableKeyTags);
        
        List<Keyword> availableKeywords = blogDAO.getAllKeywords();
        request.setAttribute("availableKeywords", availableKeywords);

        // --- NEW: Fetch available KhoiHoc List ---
        // You'll need to uncomment this if KhoiHoc is enabled
        // List<KhoiHoc> khoiHocList = khoiHocDAO.getAllKhoiHoc(); 
        // request.setAttribute("khoiHocList", khoiHocList);

        request.setAttribute("blog", blog);
        request.setAttribute("formTitle", "Sửa Post");
        request.getRequestDispatcher("/views/staff/addEditPost.jsp").forward(request, response);
    }

    private void handleAddBlog(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        String blogTitle = request.getParameter("blogTitle");
        String blogDescription = request.getParameter("blogDescription");
        String noiDung = request.getParameter("noiDung");
        String idKeyTagParam = request.getParameter("idKeyTag"); 
        String idPhanLoaiParam = request.getParameter("idPhanLoai"); // Can be "" if optional        // Can be "0" or "" if optional
        String idKeywordParam = request.getParameter("idKeyword");   // Can be "0" if optional

        // Validate required fields (only title, description, content are *always* required)
        if (blogTitle == null || blogTitle.trim().isEmpty() ||
            blogDescription == null || blogDescription.trim().isEmpty() ||
            noiDung == null || noiDung.trim().isEmpty()) { // Removed idPhanLoaiParam from required check
            
            request.setAttribute("errorMessage", "Tiêu đề, mô tả và nội dung blog không được để trống.");
            showAddForm(request, response);
            return;
        }

        // --- Handle nullable Integer IDs ---
        Integer idPhanLoai = null; // Use Integer to allow null   // Use Integer to allow null
        Integer idKeyTag = null;   // Use Integer to allow null
        Integer idKeyword = null;  // Use Integer to allow null

        try {
            if (idPhanLoaiParam != null && !idPhanLoaiParam.isEmpty()) { // Check for empty string
                idPhanLoai = Integer.parseInt(idPhanLoaiParam);
            }
            if (idKeyTagParam != null && !idKeyTagParam.isEmpty() && !idKeyTagParam.equals("0")) { // Check for empty string or "0"
                idKeyTag = Integer.parseInt(idKeyTagParam);
            }
            if (idKeywordParam != null && !idKeywordParam.isEmpty() && !idKeywordParam.equals("0")) { // Check for empty string or "0"
                idKeyword = Integer.parseInt(idKeywordParam);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Định dạng ID cho phân loại, khối học, KeyTag hoặc Keyword không hợp lệ.");
            showAddForm(request, response);
            return;
        }

        String imageFileName = null;
        try {
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                String fileName = filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "blog_images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                String extension = "";
                int lastDotIndex = fileName.lastIndexOf('.');
                if (lastDotIndex > 0) {
                    extension = fileName.substring(lastDotIndex);
                }
                imageFileName = UUID.randomUUID().toString() + extension;
                filePart.write(uploadPath + File.separator + imageFileName);
            }
        } catch (Exception e) {
            log("Error uploading image for add blog: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Lỗi khi tải ảnh lên: " + e.getMessage());
            showAddForm(request, response);
            return;
        }

        Blog newBlog = new Blog();
        newBlog.setBlogTitle(blogTitle);
        newBlog.setBlogDescription(blogDescription);
        newBlog.setNoiDung(noiDung);
        newBlog.setBlogDate(LocalDateTime.now());
        newBlog.setImage(imageFileName);
        
        // --- Set nullable Integer IDs ---
        // Your model.Blog needs to have Integer ID fields for this to work perfectly with nulls
        // E.g., private Integer ID_PhanLoai; in model.Blog
        // If your Blog model still uses 'int', then set 0 or -1 as a default, and handle that in DAO SQL.
        // For simplicity, assuming model.Blog.ID_PhanLoai, ID_Khoi, ID_KeyTag, ID_Keyword are now Integer.
        newBlog.setID_PhanLoai(idPhanLoai);
        newBlog.setID_KeyTag(idKeyTag);
        newBlog.setID_Keyword(idKeyword);

        blogDAO.addBlog(newBlog);

        response.sendRedirect(request.getContextPath() + "/ManagePost?message=add_success");
    }

    private void handleUpdateBlog(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int blogId = 0;
        try {
            blogId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid blog ID for update.");
            return;
        }

        Blog existingBlog = blogDAO.getBlogById(blogId);

        if (existingBlog == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Blog to update not found.");
            return;
        }

        existingBlog.setBlogTitle(request.getParameter("blogTitle"));
        existingBlog.setBlogDescription(request.getParameter("blogDescription"));
        existingBlog.setNoiDung(request.getParameter("noiDung"));

        String idPhanLoaiParam = request.getParameter("idPhanLoai");
        String idKeyTagParam = request.getParameter("idKeyTag");
        String idKeywordParam = request.getParameter("idKeyword");

        // --- Handle nullable Integer IDs ---
        Integer idPhanLoai = null;
        Integer idKeyTag = null;
        Integer idKeyword = null;

        try {
            if (idPhanLoaiParam != null && !idPhanLoaiParam.isEmpty()) {
                idPhanLoai = Integer.parseInt(idPhanLoaiParam);
            }
            if (idKeyTagParam != null && !idKeyTagParam.isEmpty() && !idKeyTagParam.equals("0")) {
                idKeyTag = Integer.parseInt(idKeyTagParam);
            }
            if (idKeywordParam != null && !idKeywordParam.isEmpty() && !idKeywordParam.equals("0")) {
                idKeyword = Integer.parseInt(idKeywordParam);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Định dạng ID cho phân loại, khối học, KeyTag hoặc Keyword không hợp lệ.");
            showEditForm(request, response);
            return;
        }

        existingBlog.setID_PhanLoai(idPhanLoai);
        existingBlog.setID_KeyTag(idKeyTag);
        existingBlog.setID_Keyword(idKeyword);

        String newImageFileName = existingBlog.getImage();
        try {
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                String fileName = filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "blog_images";
                
                if (existingBlog.getImage() != null && !existingBlog.getImage().isEmpty()) {
                    File oldImage = new File(uploadPath + File.separator + existingBlog.getImage());
                    if (oldImage.exists()) {
                        oldImage.delete();
                    }
                }
                
                String extension = "";
                int lastDotIndex = fileName.lastIndexOf('.');
                if (lastDotIndex > 0) {
                    extension = fileName.substring(lastDotIndex);
                }
                newImageFileName = UUID.randomUUID().toString() + extension;
                filePart.write(uploadPath + File.separator + newImageFileName);
            }
        } catch (Exception e) {
            log("Error uploading new image for update blog: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Lỗi khi tải ảnh mới lên: " + e.getMessage());
            showEditForm(request, response);
            return;
        }
        existingBlog.setImage(newImageFileName);

        blogDAO.updateBlog(existingBlog);

        response.sendRedirect(request.getContextPath() + "/ManagePost?message=update_success");
    }

    private void handleDeleteBlog(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int blogId = 0;
        try {
            blogId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid blog ID for deletion.");
            return;
        }

        Blog blogToDelete = blogDAO.getBlogById(blogId);

        if (blogToDelete == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Blog to delete not found.");
            return;
        }

        if (blogToDelete.getImage() != null && !blogToDelete.getImage().isEmpty()) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "blog_images";
            File imageFile = new File(uploadPath + File.separator + blogToDelete.getImage());
            if (imageFile.exists()) {
                if (!imageFile.delete()) {
                    log("Warning: Failed to delete image file: " + imageFile.getAbsolutePath());
                }
            }
        }

        blogDAO.deleteBlog(blogId);

        response.sendRedirect(request.getContextPath() + "/ManagePost?message=delete_success");
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing blog posts.";
    }
}