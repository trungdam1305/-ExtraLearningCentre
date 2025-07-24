// Author: trungdam
// Servlet: ManageSlider
package controller;

import dal.SliderDAO;
import dal.StaffDAO; // Needed for fetching staff info for the sidebar/header
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import model.Slider;
import model.TaiKhoan; // Assuming TaiKhoan is the user object in session

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID; // For unique file names
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for managing homepage sliders 
 */
@MultipartConfig( // Needed for image uploads
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB (for single image)
    maxRequestSize = 1024 * 1024 * 50    // 50MB (for whole request)
)
public class ManageSlider extends HttpServlet {

    private final SliderDAO sliderDAO;
    private final StaffDAO staffDAO; // To get staff info for the dashboard header

    // Directory for slider images relative to web app context
    private static final String UPLOAD_DIR_SLIDER_IMAGES = "img" + File.separator + "sliders"; 

    public ManageSlider() {
        this.sliderDAO = new SliderDAO();
        this.staffDAO = new StaffDAO(); // Initialize StaffDAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // Basic authentication check: Only authorized users (e.g., admins) can manage sliders
        if (user == null) { // Or check user.getID_VaiTro() for specific role
            response.sendRedirect(request.getContextPath() + "/views/login.jsp"); // Redirect to login
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "list"; // Default action is to list sliders
        }
        
        try {
            switch(action) {
                case "list":
                    handleListSliders(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete": // Handle delete confirmation via GET
                    handleDeleteSlider(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action specified.");
                    break;
            }
        } catch (SQLException e) {
            log("Database error in ManageSlider doGet: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            log("Invalid number format in ManageSlider doGet: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Invalid ID format.");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        } catch (Exception e) {
            log("An unexpected error occurred in ManageSlider doGet: " + e.getMessage(), e);
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
            action = ""; // Fallback
        }

        // Re-check authentication for POST requests as well
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        // Assuming role ID 1 is for admin
        if (user == null || user.getID_VaiTro() != 1) { 
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized access.");
            return;
        }

        try {
            switch (action) {
                case "addSlider":
                    handleAddSlider(request, response);
                    break;
                case "updateSlider":
                    handleUpdateSlider(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid or unsupported POST action.");
                    break;
            }
        } catch (SQLException e) {
            log("Database error in ManageSlider doPost: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "A database error occurred: " + e.getMessage());
            // If an error occurs during add/update, re-show the form with an error message
            if ("addSlider".equals(action)) {
                try {
                    showAddForm(request, response); // Go back to add form
                } catch (SQLException ex) {
                    Logger.getLogger(ManageSlider.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else if ("updateSlider".equals(action)) {
                try {
                    showEditForm(request, response); // Go back to edit form
                } catch (SQLException ex) {
                    Logger.getLogger(ManageSlider.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else {
                request.getRequestDispatcher("").forward(request, response); // General error page
            }
        } 
    }

    /**
     * Handles listing sliders with search and pagination.
     */
    private void handleListSliders(HttpServletRequest request, HttpServletResponse response)    
            throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("keyword"); // Search keyword
        String pageParam = request.getParameter("page"); // Current page parameter

        int currentPage = 1;
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid page parameter: " + pageParam, e);
        }
        int pageSize = 5; // Configurable items per page

        List<Slider> sliderList = sliderDAO.getFilteredSliders(keyword, currentPage, pageSize); // Fetch filtered sliders
        int totalSliders = sliderDAO.countFilteredSliders(keyword); // Get total count for pagination
        
        int totalPages = (int) Math.ceil((double) totalSliders / pageSize); // Calculate total pages

        request.setAttribute("sliderList", sliderList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("keyword", keyword); // Retain search term in the input field

        request.getRequestDispatcher("/views/admin/adminManageSlider.jsp").forward(request, response);
    }

    /**
     * Displays the form for adding a new slider.
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)    
            throws SQLException, ServletException, IOException {
        
        request.setAttribute("slider", null); // Indicates adding a new slider (no existing data)
        request.setAttribute("formTitle", "Thêm Slider Mới"); // Set form title
        request.getRequestDispatcher("/views/admin/addEditSlider.jsp").forward(request, response);
    }

    /**
     * Displays the form for editing an existing slider.
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)    
            throws SQLException, ServletException, IOException {
        int sliderId = 0;
        String idParam = request.getParameter("id");    
        try {
            if (idParam != null && !idParam.isEmpty()) {
                sliderId = Integer.parseInt(idParam);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID Slider không hợp lệ."); // Error if ID in URL is bad
            response.sendRedirect(request.getContextPath() + "/ManageSlider?action=list"); // Redirect to list on error
            return;
        }

        Slider slider = sliderDAO.getSliderById(sliderId); // Fetch the slider by ID

        if (slider == null) {
            request.setAttribute("errorMessage", "Không tìm thấy Slider để sửa.");
            response.sendRedirect(request.getContextPath() + "/ManageSlider?action=list"); // Redirect to list if not found
            return;
        }

        request.setAttribute("slider", slider); // Pass slider object to populate form fields
        request.setAttribute("formTitle", "Sửa Slider"); // Set form title
        request.getRequestDispatcher("/views/admin/addEditSlider.jsp").forward(request, response);
    }

    /**
     * Helper method to save uploaded files (specifically images for sliders).
     * @param part The Part object representing the uploaded file.
     * @param uploadDirectory The relative directory within the web application context where files should be saved.
     * @param request The HttpServletRequest to get the real path.
     * @return The relative path to the saved file (e.g., "img/sliders/unique-filename.jpg").
     * @throws IOException If an I/O error occurs during file writing.
     */
    private String saveUploadedFile(Part part, String uploadDirectory, HttpServletRequest request) throws IOException {
        String fileName = part.getSubmittedFileName(); // Original filename
        String fileExtension = "";
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0) {
            fileExtension = fileName.substring(dotIndex); // Extract file extension
        }
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension; // Generate a unique filename
        
        String applicationPath = request.getServletContext().getRealPath(""); // Get absolute path to web app root
        String absoluteUploadPath = applicationPath + File.separator + uploadDirectory; // Combine to get absolute upload path

        File uploadDir = new File(absoluteUploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Create directories if they don't exist
        }
        
        File targetFile = new File(absoluteUploadPath, uniqueFileName);
        part.write(targetFile.getAbsolutePath()); // Write the file to the target location
        
        // Return the relative web path for storing in the database
        return uploadDirectory.replace("\\", "/") + "/" + uniqueFileName; 
    }

    /**
     * Helper method to delete files from the server.
     * @param relativeFilePath The relative path of the file to delete (as stored in DB).
     * @param request The HttpServletRequest to get the real path.
     */
    private void deleteFile(String relativeFilePath, HttpServletRequest request) {
        if (relativeFilePath != null && !relativeFilePath.isEmpty()) {
            // Convert relative web path to absolute file system path
            String absoluteFilePath = request.getServletContext().getRealPath("") + File.separator + relativeFilePath.replace("/", File.separator);
            File fileToDelete = new File(absoluteFilePath);
            if (fileToDelete.exists()) {
                if (!fileToDelete.delete()) {
                    log("Warning: Failed to delete file: " + fileToDelete.getAbsolutePath());
                }
            }
        }
    }

    /**
     * Handles adding a new slider from form submission (POST request).
     */
    private void handleAddSlider(HttpServletRequest request, HttpServletResponse response)    
            throws SQLException, ServletException, IOException {
        
        String title = request.getParameter("title"); // Slider title
        String backLink = request.getParameter("backLink"); // Link associated with the slider

        // Validate required fields
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Tiêu đề slider không được để trống.");
            showAddForm(request, response); // Re-show form with error
            return;
        }

        String imageFileName = null;
        try {
            Part imagePart = request.getPart("image"); // Get the uploaded image file part
            // Validate image upload
            if (imagePart == null || imagePart.getSize() == 0 || imagePart.getSubmittedFileName() == null || imagePart.getSubmittedFileName().isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng chọn ảnh cho slider.");
                showAddForm(request, response);
                return;
            }
            imageFileName = saveUploadedFile(imagePart, UPLOAD_DIR_SLIDER_IMAGES, request); // Save image and get its path
        } catch (Exception e) {
            log("Error uploading slider image: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Lỗi khi tải ảnh slider lên: " + e.getMessage());
            showAddForm(request, response); // Re-show form with upload error
            return;
        }

        Slider newSlider = new Slider();
        newSlider.setTitle(title);
        newSlider.setImage(imageFileName); // Set the path to the uploaded image
        newSlider.setBackLink(backLink); // BackLink can be empty/null if DB allows

        sliderDAO.addSlider(newSlider); // Add the new slider to the database

        response.sendRedirect(request.getContextPath() + "/ManageSlider?message=add_success"); // Redirect on successful addition
    }

    /**
     * Handles updating an existing slider from form submission (POST request).
     */
    private void handleUpdateSlider(HttpServletRequest request, HttpServletResponse response)    
            throws SQLException, ServletException, IOException {
        
        int sliderId = 0;
        String idParam = request.getParameter("id");
        try {
            sliderId = Integer.parseInt(idParam); // Parse slider ID from request
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID Slider không hợp lệ để cập nhật.");
            showEditForm(request, response); // Re-show form with error if ID is bad
            return;
        }

        Slider existingSlider = sliderDAO.getSliderById(sliderId); // Fetch existing slider details

        if (existingSlider == null) {
            request.setAttribute("errorMessage", "Không tìm thấy Slider để cập nhật.");
            response.sendRedirect(request.getContextPath() + "/ManageSlider?action=list"); // Redirect if slider not found
            return;
        }

        String title = request.getParameter("title");
        String backLink = request.getParameter("backLink");

        // Validate required fields
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Tiêu đề slider không được để trống.");
            showEditForm(request, response); // Re-show form with error
            return;
        }

        existingSlider.setTitle(title);
        existingSlider.setBackLink(backLink);

        String newImageFileName = existingSlider.getImage(); // Keep old image by default
        try {
            Part imagePart = request.getPart("image");
            // Check if a new image was actually uploaded
            if (imagePart != null && imagePart.getSize() > 0 && imagePart.getSubmittedFileName() != null && !imagePart.getSubmittedFileName().isEmpty()) {
                // Delete the old image file before saving the new one
                deleteFile(existingSlider.getImage(), request); 
                newImageFileName = saveUploadedFile(imagePart, UPLOAD_DIR_SLIDER_IMAGES, request);
            }
        } catch (Exception e) {
            log("Error uploading new slider image for update: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Lỗi khi tải ảnh slider mới lên: " + e.getMessage());
            showEditForm(request, response); // Re-show form with upload error
            return;
        }
        existingSlider.setImage(newImageFileName); // Update with new (or old) image filename

        sliderDAO.updateSlider(existingSlider); // Update the slider in the database

        response.sendRedirect(request.getContextPath() + "/ManageSlider?message=update_success"); // Redirect on successful update
    }

    /**
     * Handles deleting a slider (via GET request in this design, typically for confirmation or direct deletion).
     */
    private void handleDeleteSlider(HttpServletRequest request, HttpServletResponse response)    
            throws SQLException, ServletException, IOException {
        
        int sliderId = 0;
        String idParam = request.getParameter("id");
        try {
            if (idParam != null && !idParam.isEmpty()) {
                sliderId = Integer.parseInt(idParam);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID Slider không hợp lệ để xóa.");
            handleListSliders(request, response); // Show list with error
            return;
        }

        Slider sliderToDelete = sliderDAO.getSliderById(sliderId); // Fetch slider details for file deletion

        if (sliderToDelete == null) {
            request.setAttribute("errorMessage", "Không tìm thấy Slider để xóa.");
            handleListSliders(request, response); // Show list if slider not found
            return;
        }

        deleteFile(sliderToDelete.getImage(), request); // Delete the associated image file from the server

        sliderDAO.deleteSlider(sliderId); // Delete the slider record from the database

        response.sendRedirect(request.getContextPath() + "/ManageSlider?message=delete_success"); // Redirect on successful deletion
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing homepage sliders.";
    }
}