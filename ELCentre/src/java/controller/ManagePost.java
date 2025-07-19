package controller;

import dal.BlogDAO;
import dal.KhoiHocDAO;
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
import model.KeyTag;    // Import KeyTag model
import model.Keyword;   // Import Keyword model (NEW)
import model.KhoiHoc; // Assuming you have this model and a DAO for it

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Servlet for managing blog posts (search, filter, pagination, CRUD).
 * @author admin
 */
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ManagePost extends HttpServlet {

    private final BlogDAO blogDAO;
    private final StaffDAO staffDAO;
    private final KhoiHocDAO khoiHocDAO = new KhoiHocDAO();
    // Uncomment and initialize if you have these DAOs
    // private final PhanLoaiBlogDAO phanLoaiBlogDAO;
    // private final KhoiHocDAO khoiHocDAO;

    public ManagePost() {
        this.blogDAO = new BlogDAO();
        this.staffDAO = new StaffDAO();
        // this.phanLoaiBlogDAO = new PhanLoaiBlogDAO();
        // this.khoiHocDAO = new KhoiHocDAO();
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
            log("Database error in ManagePost doGet: " + e.getMessage(), e); // Log the full stack trace
            request.setAttribute("errorMessage", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response); // Forward to an error page
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

    /**
     * Handles listing blogs with search, filter, and pagination.
     */
    private void handleListBlogs(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String idKeyTagParam = request.getParameter("idKeyTag");
        String yearParam = request.getParameter("year");
        String pageParam = request.getParameter("page");
        // categoryIdParam is not used in the filtering of ManagePost's table,
        // so it's not retrieved here.

        int currentPage = 1;
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid page parameter: " + pageParam, e);
        }
        int pageSize = 5; // Configurable items per page

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
        
        // Use blogDAO.getFilteredBlogs for the list of blogs
        List<Blog> blogList = blogDAO.getFilteredBlogs(keyword, filterKeyTagId, filterYear, currentPage, pageSize);
        // Use blogDAO.countFilteredBlogs for the total count
        int totalBlogs = blogDAO.countFilteredBlogs(keyword, filterKeyTagId, filterYear);
        
        // Fetch all available KeyTags and Years for filter dropdowns
        List<KeyTag> availableKeyTags = blogDAO.getAllKeyTags();
        List<Integer> availableYears = blogDAO.getDistinctBlogYears();

        int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);

        request.setAttribute("blogList", blogList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        
        // Retain search/filter parameters for display in JSP
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedKeyTagId", filterKeyTagId);
        request.setAttribute("selectedYear", filterYear);

        request.setAttribute("availableKeyTags", availableKeyTags);
        request.setAttribute("availableYears", availableYears);
        
        // Populate dropdowns for add/edit form (these lists are needed by addEditPost.jsp)
        List<PhanLoaiBlog> phanLoaiList = blogDAO.getAllPhanLoaiBlog(); 
        request.setAttribute("phanLoaiList", phanLoaiList);

        // If you have a KhoiHocDAO and need a dropdown for KhoiHoc, uncomment this:
        // List<KhoiHoc> khoiHocList = khoiHocDAO.getAllKhoiHoc(); 
        // request.setAttribute("khoiHocList", khoiHocList);

        request.getRequestDispatcher("/views/staff/managePost.jsp").forward(request, response);
    }

    /**
     * Displays the form for adding a new blog post.
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        // Populate dropdowns (PhanLoaiBlog, KeyTag, Keyword, KhoiHoc) for the form
        List<PhanLoaiBlog> phanLoaiList = blogDAO.getAllPhanLoaiBlog(); 
        request.setAttribute("phanLoaiList", phanLoaiList);

        List<KeyTag> availableKeyTags = blogDAO.getAllKeyTags(); 
        request.setAttribute("availableKeyTags", availableKeyTags);
        
        // --- NEW: Fetch available Keywords ---
        List<Keyword> availableKeywords = blogDAO.getAllKeywords();
        request.setAttribute("availableKeywords", availableKeywords);
        
        List<KhoiHoc> khoiHocList = khoiHocDAO.getAllKhoiHoc(); // <--- You need this line
        request.setAttribute("khoiHocList", khoiHocList);
        // If you have a KhoiHocDAO, uncomment and fetch its list
        // List<KhoiHoc> khoiHocList = khoiHocDAO.getAllKhoiHoc(); 
        // request.setAttribute("khoiHocList", khoiHocList);

        request.setAttribute("blog", null); // Indicates adding new blog
        request.setAttribute("formTitle", "Thêm Blog Mới");
        request.getRequestDispatcher("/views/staff/addEditPost.jsp").forward(request, response);
    }

    /**
     * Displays the form for editing an existing blog post.
     */
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

        // Populate dropdowns (PhanLoaiBlog, KeyTag, Keyword, KhoiHoc) for the form
        List<PhanLoaiBlog> phanLoaiList = blogDAO.getAllPhanLoaiBlog(); 
        request.setAttribute("phanLoaiList", phanLoaiList);

        List<KeyTag> availableKeyTags = blogDAO.getAllKeyTags(); 
        request.setAttribute("availableKeyTags", availableKeyTags);
        
        // --- NEW: Fetch available Keywords ---
        List<Keyword> availableKeywords = blogDAO.getAllKeywords();
        request.setAttribute("availableKeywords", availableKeywords);
        
        List<KhoiHoc> khoiHocList = khoiHocDAO.getAllKhoiHoc(); // <--- You need this line
    request.setAttribute("khoiHocList", khoiHocList);
        
        // If you have a KhoiHocDAO, uncomment and fetch its list
        // List<KhoiHoc> khoiHocList = khoiHocDAO.getAllKhoiHoc(); 
        // request.setAttribute("khoiHocList", khoiHocList);

        request.setAttribute("blog", blog); // Pass blog object to populate form fields
        request.setAttribute("formTitle", "Sửa Post");
        request.getRequestDispatcher("/views/staff/addEditPost.jsp").forward(request, response);
    }

    /**
     * Handles adding a new blog post from form submission.
     */
    private void handleAddBlog(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        String blogTitle = request.getParameter("blogTitle");
        String blogDescription = request.getParameter("blogDescription");
        String noiDung = request.getParameter("noiDung");
        String idKeyTagParam = request.getParameter("idKeyTag"); 
        String idPhanLoaiParam = request.getParameter("idPhanLoai");
        String idKhoiParam = request.getParameter("idKhoi");
        String idKeywordParam = request.getParameter("idKeyword"); // NEW: Get ID_Keyword from select box

        // Validate required fields
        if (blogTitle == null || blogTitle.trim().isEmpty() ||
            blogDescription == null || blogDescription.trim().isEmpty() ||
            noiDung == null || noiDung.trim().isEmpty() ||
            idPhanLoaiParam == null || idPhanLoaiParam.isEmpty()) {
            
            request.setAttribute("errorMessage", "Tiêu đề, mô tả, nội dung và phân loại blog không được để trống.");
            showAddForm(request, response); // Return to form with error and populate dropdowns again
            return;
        }

        int idPhanLoai = 0;
        int idKeyTag = 0;
        int idKhoi = 0; // Default or handle as nullable if your DB allows
        int idKeyword = 0; // NEW: Initialize ID_Keyword
        
        try {
            idPhanLoai = Integer.parseInt(idPhanLoaiParam);
            if (idKeyTagParam != null && !idKeyTagParam.isEmpty()) {
                idKeyTag = Integer.parseInt(idKeyTagParam);
            }
            if (idKhoiParam != null && !idKhoiParam.isEmpty()) {
                idKhoi = Integer.parseInt(idKhoiParam);
            }
            // NEW: Parse ID_Keyword
            if (idKeywordParam != null && !idKeywordParam.isEmpty()) {
                idKeyword = Integer.parseInt(idKeywordParam);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Định dạng ID không hợp lệ.");
            showAddForm(request, response); // Return to form with error
            return;
        }
        
        List<KhoiHoc> khoiHocList = khoiHocDAO.getAllKhoiHoc(); // <--- You need this line
        request.setAttribute("khoiHocList", khoiHocList);
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
            showAddForm(request, response); // Return to form with error
            return;
        }

        Blog newBlog = new Blog();
        newBlog.setBlogTitle(blogTitle);
        newBlog.setBlogDescription(blogDescription);
        newBlog.setNoiDung(noiDung);
        newBlog.setBlogDate(LocalDateTime.now());
        newBlog.setImage(imageFileName);
        newBlog.setID_PhanLoai(idPhanLoai);
        newBlog.setID_KeyTag(idKeyTag);
        newBlog.setID_Keyword(idKeyword); // NEW: Set ID_Keyword
        // The blog object's string KeyTag/KeyWord fields will be populated from DB on retrieve, not set here.

        blogDAO.addBlog(newBlog);

        response.sendRedirect(request.getContextPath() + "/ManagePost?message=add_success");
    }

    /**
     * Handles updating an existing blog post from form submission.
     */
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

        // Retrieve updated data from form
        existingBlog.setBlogTitle(request.getParameter("blogTitle"));
        existingBlog.setBlogDescription(request.getParameter("blogDescription"));
        existingBlog.setNoiDung(request.getParameter("noiDung"));
        // Remove direct setting of string KeyTag/KeyWord if using IDs from select boxes
        // existingBlog.setKeyTag(request.getParameter("keyTag")); 
        // existingBlog.setKeyWord(request.getParameter("keyWord"));

        String idPhanLoaiParam = request.getParameter("idPhanLoai");
        String idKhoiParam = request.getParameter("idKhoi");
        String idKeyTagParam = request.getParameter("idKeyTag"); 
        String idKeywordParam = request.getParameter("idKeyword"); // NEW: Get ID_Keyword

        // Validate and parse IDs
        int idPhanLoai = 0;
        int idKhoi = 0;
        int idKeyTag = 0;
        int idKeyword = 0; // NEW: Initialize ID_Keyword

        try {
            if (idPhanLoaiParam != null && !idPhanLoaiParam.isEmpty()) {
                idPhanLoai = Integer.parseInt(idPhanLoaiParam);
            }
            if (idKhoiParam != null && !idKhoiParam.isEmpty()) {
                idKhoi = Integer.parseInt(idKhoiParam);
            }
            if (idKeyTagParam != null && !idKeyTagParam.isEmpty()) {
                idKeyTag = Integer.parseInt(idKeyTagParam);
            }
            // NEW: Parse ID_Keyword
            if (idKeywordParam != null && !idKeywordParam.isEmpty()) {
                idKeyword = Integer.parseInt(idKeywordParam);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Định dạng ID không hợp lệ.");
            showEditForm(request, response); // Return to form with error
            return;
        }

        existingBlog.setID_PhanLoai(idPhanLoai);
        existingBlog.setID_KeyTag(idKeyTag);
        existingBlog.setID_Keyword(idKeyword); // NEW: Set ID_Keyword

        // Handle image upload
        String newImageFileName = existingBlog.getImage(); // Keep old image by default
        try {
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                String fileName = filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "blog_images";
                
                // Delete old image if it exists
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
            showEditForm(request, response); // Return to form with error
            return;
        }
        existingBlog.setImage(newImageFileName); // Update with new image file name

        blogDAO.updateBlog(existingBlog);

        response.sendRedirect(request.getContextPath() + "/ManagePost?message=update_success");
    }

    /**
     * Handles deleting a blog post.
     */
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

        // Delete the physical image file from the server
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