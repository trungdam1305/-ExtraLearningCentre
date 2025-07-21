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

        // Basic authentication check: Only admins can manage sliders
        // Assuming your TaiKhoan model has a getRole() method and "admin" is the role.
        if (user == null) {
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
                 request.getRequestDispatcher("/views/error.jsp").forward(request, response); // General error page
            }
        } 
    }

    /**
     * Handles listing sliders with search and pagination
     */
    private void handleListSliders(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String pageParam = request.getParameter("page");

        int currentPage = 1;
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid page parameter: " + pageParam, e);
        }
        int pageSize = 5; // Configurable items per page

        List<Slider> sliderList = sliderDAO.getFilteredSliders(keyword, currentPage, pageSize);
        int totalSliders = sliderDAO.countFilteredSliders(keyword);
        
        int totalPages = (int) Math.ceil((double) totalSliders / pageSize);

        request.setAttribute("sliderList", sliderList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("keyword", keyword); // Retain search term

        request.getRequestDispatcher("/views/admin/adminManageSlider.jsp").forward(request, response);
    }

    /**
     * Displays the form for adding a new slider (for addEditSlider.jsp)
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        request.setAttribute("slider", null); // Indicates adding new slider
        request.setAttribute("formTitle", "Thêm Slider Mới");
        request.getRequestDispatcher("/views/admin/addEditSlider.jsp").forward(request, response);
    }

    /**
     * Displays the form for editing an existing slider (for addEditSlider.jsp)
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
            response.sendRedirect(request.getContextPath() + "/ManageSlider?action=list"); // Redirect to list
            return;
        }

        Slider slider = sliderDAO.getSliderById(sliderId);

        if (slider == null) {
            request.setAttribute("errorMessage", "Không tìm thấy Slider để sửa.");
            response.sendRedirect(request.getContextPath() + "/ManageSlider?action=list"); // Redirect to list
            return;
        }

        request.setAttribute("slider", slider); // Pass slider object to populate form fields
        request.setAttribute("formTitle", "Sửa Slider");
        request.getRequestDispatcher("/views/admin/addEditSlider.jsp").forward(request, response);
    }

    // Helper method to save uploaded files (image for slider)
    private String saveUploadedFile(Part part, String uploadDirectory, HttpServletRequest request) throws IOException {
        String fileName = part.getSubmittedFileName();
        String fileExtension = "";
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0) {
            fileExtension = fileName.substring(dotIndex);
        }
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
        
        String applicationPath = request.getServletContext().getRealPath("");
        String absoluteUploadPath = applicationPath + File.separator + uploadDirectory;

        File uploadDir = new File(absoluteUploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        File targetFile = new File(absoluteUploadPath, uniqueFileName);
        part.write(targetFile.getAbsolutePath());
        
        return uploadDirectory.replace("\\", "/") + "/" + uniqueFileName; // Return relative web path
    }

    // Helper method to delete files
    private void deleteFile(String relativeFilePath, HttpServletRequest request) {
        if (relativeFilePath != null && !relativeFilePath.isEmpty()) {
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
     * Handles adding a new slider from form submission (POST)
     */
    private void handleAddSlider(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        String title = request.getParameter("title");
        String backLink = request.getParameter("backLink");

        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Tiêu đề slider không được để trống.");
            showAddForm(request, response); // Re-show form with error
            return;
        }

        String imageFileName = null;
        try {
            Part imagePart = request.getPart("image"); // "image" is the name of the file input
            if (imagePart == null || imagePart.getSize() == 0 || imagePart.getSubmittedFileName() == null || imagePart.getSubmittedFileName().isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng chọn ảnh cho slider.");
                showAddForm(request, response);
                return;
            }
            imageFileName = saveUploadedFile(imagePart, UPLOAD_DIR_SLIDER_IMAGES, request);
        } catch (Exception e) {
            log("Error uploading slider image: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Lỗi khi tải ảnh slider lên: " + e.getMessage());
            showAddForm(request, response);
            return;
        }

        Slider newSlider = new Slider();
        newSlider.setTitle(title);
        newSlider.setImage(imageFileName);
        newSlider.setBackLink(backLink); // BackLink can be empty/null if DB allows

        sliderDAO.addSlider(newSlider);

        response.sendRedirect(request.getContextPath() + "/ManageSlider?message=add_success");
    }

    /**
     * Handles updating an existing slider from form submission (POST)
     */
    private void handleUpdateSlider(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int sliderId = 0;
        String idParam = request.getParameter("id");
        try {
            sliderId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID Slider không hợp lệ để cập nhật.");
            showEditForm(request, response); // Re-show form with error
            return;
        }

        Slider existingSlider = sliderDAO.getSliderById(sliderId);

        if (existingSlider == null) {
            request.setAttribute("errorMessage", "Không tìm thấy Slider để cập nhật.");
            response.sendRedirect(request.getContextPath() + "/ManageSlider?action=list");
            return;
        }

        String title = request.getParameter("title");
        String backLink = request.getParameter("backLink");

        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Tiêu đề slider không được để trống.");
            showEditForm(request, response);
            return;
        }

        existingSlider.setTitle(title);
        existingSlider.setBackLink(backLink);

        String newImageFileName = existingSlider.getImage(); // Keep old image by default
        try {
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0 && imagePart.getSubmittedFileName() != null && !imagePart.getSubmittedFileName().isEmpty()) {
                // A new image was uploaded. Delete the old one.
                deleteFile(existingSlider.getImage(), request);
                newImageFileName = saveUploadedFile(imagePart, UPLOAD_DIR_SLIDER_IMAGES, request);
            }
        } catch (Exception e) {
            log("Error uploading new slider image for update: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Lỗi khi tải ảnh slider mới lên: " + e.getMessage());
            showEditForm(request, response);
            return;
        }
        existingSlider.setImage(newImageFileName);

        sliderDAO.updateSlider(existingSlider);

        response.sendRedirect(request.getContextPath() + "/ManageSlider?message=update_success");
    }

    /**
     * Handles deleting a slider (via GET in this design)
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

        Slider sliderToDelete = sliderDAO.getSliderById(sliderId);

        if (sliderToDelete == null) {
            request.setAttribute("errorMessage", "Không tìm thấy Slider để xóa.");
            handleListSliders(request, response);
            return;
        }

        deleteFile(sliderToDelete.getImage(), request); 

        sliderDAO.deleteSlider(sliderId);

        response.sendRedirect(request.getContextPath() + "/ManageSlider?message=delete_success");
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing homepage sliders.";
    }
}