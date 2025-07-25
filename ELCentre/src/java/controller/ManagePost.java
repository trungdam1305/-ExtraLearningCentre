// Author: trungdam
// Servlet: ManagePost
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
    private final StaffDAO staffDAO; // Retained for header information

    public ManagePost() {
        this.blogDAO = new BlogDAO();
        this.staffDAO = new StaffDAO(); // Initialize
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        // Redirect to login if no user is in session
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        // Get staff information for the header display
        ArrayList<Staff> staffs = staffDAO.getNameStaff(user.getID_TaiKhoan());
        request.setAttribute("staffs", staffs);

        // Determine the action based on the 'action' parameter, default to "list"
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
            // Log and display any unexpected errors
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
        // Check if user is logged in for POST actions
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
            // Log and display any unexpected errors during POST operations
            log("Error in ManagePost doPost", e);
            request.setAttribute("errorMessage", "Đã xảy ra lỗi không mong muốn: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    /**
     * Handles listing, filtering, and paginating blog posts.
     */
    private void handleListBlogs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve and parse filter and pagination parameters
        int filterKeywordId = parseIntegerParameter(request.getParameter("keywordId"));
        int filterKeytagId = parseIntegerParameter(request.getParameter("keytagId"));
        int currentPage = parseIntegerParameter(request.getParameter("page"));
        if (currentPage == 0) currentPage = 1; // Default to page 1

        int pageSize = 5; // Number of blogs per page

        // Fetch filtered blog posts and their total count
        List<Blog> blogList = blogDAO.getFilteredBlogs(filterKeywordId, filterKeytagId, currentPage, pageSize);
        int totalBlogs = blogDAO.countFilteredBlogs(filterKeywordId, filterKeytagId);
        int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);

        // Fetch data for filter dropdowns
        request.setAttribute("allKeywords", blogDAO.getAllKeywords());
        request.setAttribute("allKeytags", blogDAO.getAllKeyTags());

        // Set attributes for the JSP
        request.setAttribute("blogList", blogList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("selectedKeywordId", filterKeywordId);
        request.setAttribute("selectedKeytagId", filterKeytagId);
        
        // Forward to the manage post JSP page
        request.getRequestDispatcher("/views/staff/managePost.jsp").forward(request, response);
    }

    /**
     * Displays the form for adding a new blog post.
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadDropdownData(request); // Load data for dropdowns (categories, tags, keywords)
        request.setAttribute("formTitle", "Thêm Bài Viết Mới");
        request.setAttribute("formAction", "addBlog"); // Action for the form submission
        request.getRequestDispatcher("/views/staff/addEditPost.jsp").forward(request, response);
    }

    /**
     * Displays the form for editing an existing blog post.
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int blogId = parseIntegerParameter(request.getParameter("id"));
        if (blogId == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID bài viết không hợp lệ.");
            return;
        }

        Blog blog = blogDAO.getBlogById(blogId); // Fetch blog details by ID
        if (blog == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy bài viết.");
            return;
        }

        loadDropdownData(request); // Load data for dropdowns
        request.setAttribute("blog", blog); // Set the blog object for editing
        request.setAttribute("formTitle", "Chỉnh Sửa Bài Viết");
        request.setAttribute("formAction", "updateBlog"); // Action for the form submission
        request.getRequestDispatcher("/views/staff/addEditPost.jsp").forward(request, response);
    }
    
    /**
     * Handles adding a new blog post to the database, including image upload.
     */
    private void handleAddBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String blogTitle = request.getParameter("blogTitle");
        String blogDescription = request.getParameter("blogDescription");
        String noiDung = request.getParameter("noiDung"); // Content from CKEditor
        
        // Validate required fields
        if (blogTitle == null || blogTitle.trim().isEmpty() ||
            blogDescription == null || blogDescription.trim().isEmpty() ||
            noiDung == null || noiDung.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Tiêu đề, mô tả và nội dung không được để trống.");
            showAddForm(request, response); // Return to add form with error message
            return;
        }
        
        Blog newBlog = new Blog();
        newBlog.setBlogTitle(blogTitle);
        newBlog.setBlogDescription(blogDescription);
        newBlog.setNoiDung(noiDung);
        newBlog.setBlogDate(LocalDateTime.now()); // Set current timestamp as creation date
        
        // Parse and set IDs for categories, keytags, and keywords
        newBlog.setID_PhanLoai(parseIntegerParameter(request.getParameter("idPhanLoai")));
        newBlog.setID_KeyTag(parseIntegerParameter(request.getParameter("idKeyTag")));
        newBlog.setID_Keyword(parseIntegerParameter(request.getParameter("idKeyword")));

        // Handle image upload
        String imageFileName = uploadImage(request);
        newBlog.setImage(imageFileName); // Set the uploaded image filename
        
        blogDAO.addBlog(newBlog); // Add the new blog post to the database
        response.sendRedirect(request.getContextPath() + "/ManagePost?message=add_success"); // Redirect on success
    }

    /**
     * Handles updating an existing blog post, including re-uploading an image if provided.
     */
    private void handleUpdateBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int blogId = parseIntegerParameter(request.getParameter("id"));
        Blog existingBlog = blogDAO.getBlogById(blogId); // Fetch existing blog details

        if (existingBlog == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy bài viết để cập nhật.");
            return;
        }

        // Update blog properties from form parameters
        existingBlog.setBlogTitle(request.getParameter("blogTitle"));
        existingBlog.setBlogDescription(request.getParameter("blogDescription"));
        existingBlog.setNoiDung(request.getParameter("noiDung"));

        // Update IDs for categories, keytags, and keywords
        existingBlog.setID_PhanLoai(parseIntegerParameter(request.getParameter("idPhanLoai")));
        existingBlog.setID_KeyTag(parseIntegerParameter(request.getParameter("idKeyTag")));
        existingBlog.setID_Keyword(parseIntegerParameter(request.getParameter("idKeyword")));

        // Handle image update: upload new image if provided, and delete old one
        String newImageFileName = uploadImage(request);
        if (newImageFileName != null) {
            deleteOldImage(existingBlog.getImage(), request); // Delete the old image file
            existingBlog.setImage(newImageFileName); // Set the new image filename
        }

        blogDAO.updateBlog(existingBlog); // Update the blog post in the database
        response.sendRedirect(request.getContextPath() + "/ManagePost?message=update_success"); // Redirect on success
    }

    /**
     * Handles deleting a blog post and its associated image file.
     */
    private void handleDeleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int blogId = parseIntegerParameter(request.getParameter("id"));
        if (blogId == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID bài viết không hợp lệ.");
            return;
        }

        Blog blogToDelete = blogDAO.getBlogById(blogId); // Fetch blog details for file deletion
        if (blogToDelete != null) {
            deleteOldImage(blogToDelete.getImage(), request); // Delete the associated image file
            blogDAO.deleteBlog(blogId); // Delete the blog record from the database
            response.sendRedirect(request.getContextPath() + "/ManagePost?message=delete_success"); // Redirect on success
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy bài viết để xóa.");
        }
    }
    
    // --- HELPER METHODS ---
    /**
     * Loads data for dropdown menus (blog categories, key tags, keywords) and sets them as request attributes.
     */
    private void loadDropdownData(HttpServletRequest request) {
        request.setAttribute("phanLoaiList", blogDAO.getAllPhanLoaiBlog());
        request.setAttribute("availableKeyTags", blogDAO.getAllKeyTags());
        request.setAttribute("availableKeywords", blogDAO.getAllKeywords());
    }

    /**
     * Uploads an image file to the server and returns its unique generated name.
     * @param request The HttpServletRequest containing the multipart file.
     * @return The unique generated file name, or null if no file was uploaded.
     * @throws IOException If an I/O error occurs during file writing.
     * @throws ServletException If the request is not a multipart request.
     */
    private String uploadImage(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("image"); // Get the file part named "image"
        if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
            String originalFileName = filePart.getSubmittedFileName();
            String extension = "";
            int lastDotIndex = originalFileName.lastIndexOf('.');
            if (lastDotIndex > 0) {
                extension = originalFileName.substring(lastDotIndex); // Extract file extension
            }
            String newFileName = UUID.randomUUID().toString() + extension; // Generate a unique filename
            String uploadPath = getServletContext().getRealPath("") + File.separator + "" + File.separator + ""; // Define upload directory
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs(); // Create directory if it doesn't exist
            filePart.write(uploadPath + File.separator + newFileName); // Write the file to disk
            return newFileName;
        }
        return null; // Return null if no file was uploaded
    }

    /**
     * Deletes an old image file from the server.
     * @param fileName The name of the file to delete.
     * @param request The HttpServletRequest to get the real path.
     */
    private void deleteOldImage(String fileName, HttpServletRequest request) {
        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "" + File.separator + "";
            File imageFile = new File(uploadPath + File.separator + fileName);
            if (imageFile.exists()) imageFile.delete(); // Delete the file if it exists
        }
    }

    /**
     * Parses a string parameter into an integer, returning 0 if the parameter is null, empty, or not a valid number.
     * @param param The string parameter to parse.
     * @return The parsed integer, or 0 if parsing fails.
     */
    private int parseIntegerParameter(String param) {
        if (param == null || param.trim().isEmpty()) return 0;
        try {
            return Integer.parseInt(param);
        } catch (NumberFormatException e) {
            return 0; // Return 0 for invalid number format
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing blog posts (CRUD operations).";
    }
}