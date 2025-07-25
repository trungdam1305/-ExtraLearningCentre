// Author: trungdam
// Servlet: ManageMaterial
package controller;

import dal.DangTaiLieuDAO;
import dal.StaffDAO; // Assuming you need StaffDAO for user session
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import model.DangTaiLieu;
import model.Staff;
import model.TaiKhoan;
import model.LoaiTaiLieu;
import model.MonHoc;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 50,      // 50MB (Increased for potential larger files)
    maxRequestSize = 1024 * 1024 * 100   // 100MB
)
public class ManageMaterial extends HttpServlet {

    private final DangTaiLieuDAO materialDAO;
    private final StaffDAO staffDAO;

    public ManageMaterial() {
        this.materialDAO = new DangTaiLieuDAO();
        this.staffDAO = new StaffDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // Check if user is logged in and has the correct role (ID_VaiTro = 2, staff)
        if (user == null || user.getID_VaiTro() != 2) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        // Get staff name for the current user
        ArrayList<Staff> staffs = staffDAO.getNameStaff(user.getID_TaiKhoan());
        request.setAttribute("staffs", staffs);

        // Determine the action to perform (list, add, edit, delete)
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "list"; // Default action is to list materials
        }
        
        try {
            switch(action) {
                case "list":
                    handleListMaterials(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    handleDeleteMaterial(request, response);
                    break;
                default:
                    // Handle invalid or unsupported actions
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action specified.");
                    break;
            }
        } catch (SQLException e) {
            // Log database-related errors
            log("Database error in ManageMaterial doGet: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        } 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Determine the action for POST requests (add, update, delete material)
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = ""; // Default empty action if not specified
        }

        try {
            switch (action) {
                case "addMaterial":
                    handleAddMaterial(request, response);
                    break;
                case "updateMaterial":
                    handleUpdateMaterial(request, response);
                    break;
                case "deleteMaterial": // Note: It's generally better to handle DELETE via GET for simplicity with forms or use hidden fields
                    handleDeleteMaterial(request, response);
                    break;
                default:
                    // Handle invalid or unsupported POST actions
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid or unsupported POST action.");
                    break;
            }
        } catch (SQLException e) {
             log("Database error in ManageMaterial doPost: " + e.getMessage(), e);
             request.setAttribute("errorMessage", "A database error occurred: " + e.getMessage());
             request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        } 
    }

    /**
     * Handles listing, filtering, and pagination of materials.
     */
    private void handleListMaterials(HttpServletRequest request, HttpServletResponse response)    
            throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("keyword"); // Search keyword
        String monHocIdParam = request.getParameter("monHoc"); // Subject filter ID
        String loaiTaiLieuIdParam = request.getParameter("loaiTaiLieu"); // Material type filter ID
        String pageParam = request.getParameter("page"); // Current page number

        int currentPage = 1;
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid page parameter: " + pageParam, e);
        }
        int pageSize = 10; // Number of items per page

        Integer filterMonHocId = null;
        try {
            if (monHocIdParam != null && !monHocIdParam.isEmpty() && !monHocIdParam.equals("0")) {
                filterMonHocId = Integer.parseInt(monHocIdParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid MonHoc ID parameter: " + monHocIdParam, e);
        }

        Integer filterLoaiTaiLieuId = null;
        try {
            if (loaiTaiLieuIdParam != null && !loaiTaiLieuIdParam.isEmpty() && !loaiTaiLieuIdParam.equals("0")) {
                filterLoaiTaiLieuId = Integer.parseInt(loaiTaiLieuIdParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid LoaiTaiLieu ID parameter: " + loaiTaiLieuIdParam, e);
        }
        
        // Fetch materials based on filters and pagination
        List<DangTaiLieu> materialList = materialDAO.getFilteredMaterials(keyword, filterMonHocId, filterLoaiTaiLieuId, currentPage, pageSize);
        // Get total count of materials matching filters
        int totalMaterials = materialDAO.countFilteredMaterials(keyword, filterMonHocId, filterLoaiTaiLieuId);
        
        // Fetch all subjects and material types for filter dropdowns
        List<MonHoc> allMonHoc = materialDAO.getAllMonHoc();
        List<LoaiTaiLieu> allLoaiTaiLieu = materialDAO.getAllLoaiTaiLieu();

        // Calculate total pages for pagination
        int totalPages = (int) Math.ceil((double) totalMaterials / pageSize);

        // Set attributes for the JSP
        request.setAttribute("materialList", materialList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        
        request.setAttribute("keyword", keyword); // Retain search keyword
        request.setAttribute("selectedMonHocId", filterMonHocId != null ? filterMonHocId : 0); // Retain selected subject
        request.setAttribute("selectedLoaiTaiLieuId", filterLoaiTaiLieuId != null ? filterLoaiTaiLieuId : 0); // Retain selected material type

        request.setAttribute("allMonHoc", allMonHoc);
        request.setAttribute("allLoaiTaiLieu", allLoaiTaiLieu);

        // Forward to the manage material JSP page
        request.getRequestDispatcher("/views/staff/manageMaterial.jsp").forward(request, response);
    }

    /**
     * Displays the form for adding a new material.
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)    
            throws SQLException, ServletException, IOException {
        
        // Fetch all subjects and material types to populate dropdowns in the form
        List<MonHoc> allMonHoc = materialDAO.getAllMonHoc();
        List<LoaiTaiLieu> allLoaiTaiLieu = materialDAO.getAllLoaiTaiLieu();

        request.setAttribute("allMonHoc", allMonHoc);
        request.setAttribute("allLoaiTaiLieu", allLoaiTaiLieu);
        request.setAttribute("material", null); // No existing material for add form
        request.setAttribute("formTitle", "Thêm Tài Liệu Mới"); // Form title
        request.getRequestDispatcher("/views/staff/addEditMaterial.jsp").forward(request, response);
    }

    /**
     * Displays the form for editing an existing material.
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)    
            throws SQLException, ServletException, IOException {
            int materialId = Integer.parseInt(request.getParameter("id")); // Get material ID from request
            DangTaiLieu material = materialDAO.getMaterialById(materialId); // Fetch material details from DB

        // If material not found, send 404 error
        if (material == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Material not found for editing.");
            return;
        }

        // Fetch all subjects and material types to populate dropdowns
        List<MonHoc> allMonHoc = materialDAO.getAllMonHoc();
        List<LoaiTaiLieu> allLoaiTaiLieu = materialDAO.getAllLoaiTaiLieu();

        request.setAttribute("allMonHoc", allMonHoc);
        request.setAttribute("allLoaiTaiLieu", allLoaiTaiLieu);
        request.setAttribute("material", material); // Set the existing material object for the form
        request.setAttribute("formTitle", "Sửa Tài Liệu"); // Form title
        request.getRequestDispatcher("/views/staff/addEditMaterial.jsp").forward(request, response);
    }

    // Directory for actual material files (e.g., PDFs, DOCX)
    private static final String UPLOAD_DIR_FILES = "" + File.separator + ""; 
    // Directory for thumbnail images
    private static final String UPLOAD_DIR_IMAGES = "" + File.separator + ""; 

    /**
     * Uploads a file to the server and returns its unique generated name.
     * @param part The file part from the multipart request.
     * @param uploadPath The absolute path to the directory where the file will be saved.
     * @return The unique generated file name.
     * @throws IOException If an I/O error occurs during file writing.
     */
    private String getUploadedFileName(Part part, String uploadPath) throws IOException {
        String fileName = part.getSubmittedFileName();
        String fileExtension = "";
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0) {
            fileExtension = fileName.substring(dotIndex); // Get file extension (e.g., .pdf, .jpg)
        }
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension; // Generate a unique file name
        
        // Create upload directory if it doesn't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        // Write the file to the specified path
        part.write(new File(uploadPath, uniqueFileName).getAbsolutePath());
        return uniqueFileName;
    }

    /**
     * Deletes a file from the server.
     * @param fileName The name of the file to delete.
     * @param uploadDirectory The relative upload directory (e.g., "uploads/materials").
     * @param request The HttpServletRequest to get the real path.
     */
    private void deleteFile(String fileName, String uploadDirectory, HttpServletRequest request) {
        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + uploadDirectory;
            File fileToDelete = new File(uploadPath + File.separator + fileName);
            if (fileToDelete.exists()) {
                if (!fileToDelete.delete()) {
                    log("Warning: Failed to delete file: " + fileToDelete.getAbsolutePath());
                }
            }
        }
    }


    /**
     * Handles adding a new material to the database and uploading its associated files.
     */
    private void handleAddMaterial(HttpServletRequest request, HttpServletResponse response)    
            throws SQLException, ServletException, IOException {
        
        // Get form parameters
        String tenTaiLieu = request.getParameter("tenTaiLieu");
        String giaTien = request.getParameter("giaTien");
        String noiDung = request.getParameter("noiDung"); // Content from CKEditor

        String idMonHocParam = request.getParameter("idMonHoc");
        String idLoaiTaiLieuParam = request.getParameter("idLoaiTaiLieu");

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        Integer idGiaoVien = null;
        if (user != null) {
            idGiaoVien = user.getID_TaiKhoan(); // Get teacher ID from session
        }

        // Validate required text fields
        if (tenTaiLieu == null || tenTaiLieu.trim().isEmpty() ||
            noiDung == null || noiDung.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Tên tài liệu và nội dung không được để trống.");
            showAddForm(request, response);
            return;
        }
        
        // --- Handle File Upload for Material File (DuongDan) ---
        String duongDanFileName = null;
        try {
            Part duongDanFilePart = request.getPart("duongDanFile"); // Get the file part for the material file
            if (duongDanFilePart != null && duongDanFilePart.getSize() > 0) {
                duongDanFileName = getUploadedFileName(duongDanFilePart, 
                                                request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR_FILES);
            } else {
                request.setAttribute("errorMessage", "Đường dẫn file tài liệu không được để trống.");
                showAddForm(request, response);
                return;
            }
        } catch (Exception e) {
            log("Error uploading material file: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Lỗi khi tải file tài liệu lên: " + e.getMessage());
            showAddForm(request, response);
            return;
        }

        // --- Handle Image File Upload for 'Image' field (thumbnail) ---
        String imageFileName = null;
        try {
            Part imageFilePart = request.getPart("image"); // Get the file part for the thumbnail image
            if (imageFilePart != null && imageFilePart.getSize() > 0) {
                   imageFileName = getUploadedFileName(imageFilePart, 
                                               request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR_IMAGES);
            }
        } catch (Exception e) {
           // Log error but allow operation to continue if image is optional
           log("Error uploading material image: " + e.getMessage(), e);
        }

        // Parse subject and material type IDs
        Integer idMonHoc = null;
        Integer idLoaiTaiLieu = null;

        try {
            if (idMonHocParam != null && !idMonHocParam.isEmpty() && !idMonHocParam.equals("0")) {
                idMonHoc = Integer.parseInt(idMonHocParam);
            }
            if (idLoaiTaiLieuParam != null && !idLoaiTaiLieuParam.isEmpty() && !idLoaiTaiLieuParam.equals("0")) {
                idLoaiTaiLieu = Integer.parseInt(idLoaiTaiLieuParam);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Định dạng ID cho Môn học hoặc Loại tài liệu không hợp lệ.");
            showAddForm(request, response);
            return;
        }

        // Create a new DangTaiLieu object and set its properties
        DangTaiLieu newMaterial = new DangTaiLieu();
        newMaterial.setTenTaiLieu(tenTaiLieu);
        newMaterial.setDuongDan(duongDanFileName); // Set the uploaded material file name
        newMaterial.setNgayTao(LocalDateTime.now()); // Set current creation timestamp
        newMaterial.setGiaTien(giaTien);
        newMaterial.setImage(imageFileName); // Set the uploaded image file name
        newMaterial.setNoiDung(noiDung);     // Set the CKEditor content
        
        newMaterial.setID_GiaoVien(idGiaoVien);
        newMaterial.setID_MonHoc(idMonHoc);
        newMaterial.setID_LoaiTaiLieu(idLoaiTaiLieu);

        // Add the new material to the database
        materialDAO.addMaterial(newMaterial);

        // Redirect to the material list page with a success message
        response.sendRedirect(request.getContextPath() + "/ManageMaterial?message=add_success");
    }

    /**
     * Handles updating an existing material and its associated files.
     */
    private void handleUpdateMaterial(HttpServletRequest request, HttpServletResponse response)    
            throws SQLException, ServletException, IOException {
        
        int materialId = 0;
        try {
            materialId = Integer.parseInt(request.getParameter("id")); // Get material ID from request
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid material ID for update.");
            return;
        }

        // Fetch the existing material details from the database
        DangTaiLieu existingMaterial = materialDAO.getMaterialById(materialId);

        // If material not found, send 404 error
        if (existingMaterial == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Material to update not found.");
            return;
        }

        // Get updated form parameters
        String tenTaiLieu = request.getParameter("tenTaiLieu");
        String giaTien = request.getParameter("giaTien");
        String noiDung = request.getParameter("noiDung"); // Updated CKEditor content

        // Validate required text fields
        if (tenTaiLieu == null || tenTaiLieu.trim().isEmpty() ||
            noiDung == null || noiDung.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Tên tài liệu và nội dung không được để trống.");
            showEditForm(request, response); // Return to edit form with error
            return;
        }

        // Update material properties
        existingMaterial.setTenTaiLieu(tenTaiLieu);
        existingMaterial.setGiaTien(giaTien);
        existingMaterial.setNoiDung(noiDung); // Update CKEditor content

        String idMonHocParam = request.getParameter("idMonHoc");
        String idLoaiTaiLieuParam = request.getParameter("idLoaiTaiLieu");

        // Parse subject and material type IDs
        Integer idMonHoc = null;
        Integer idLoaiTaiLieu = null;

        try {
            if (idMonHocParam != null && !idMonHocParam.isEmpty() && !idMonHocParam.equals("0")) {
                idMonHoc = Integer.parseInt(idMonHocParam);
            }
            if (idLoaiTaiLieuParam != null && !idLoaiTaiLieuParam.isEmpty() && !idLoaiTaiLieuParam.equals("0")) {
                idLoaiTaiLieu = Integer.parseInt(idLoaiTaiLieuParam);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Định dạng ID cho Môn học hoặc Loại tài liệu không hợp lệ.");
            showEditForm(request, response);
            return;
        }

        existingMaterial.setID_MonHoc(idMonHoc);
        existingMaterial.setID_LoaiTaiLieu(idLoaiTaiLieu);

        // --- Handle File Upload for DuongDan (only if a new file is uploaded) ---
        String newDuongDanFileName = existingMaterial.getDuongDan(); // Keep old file by default
        try {
            Part duongDanFilePart = request.getPart("duongDanFile");
            // Check if a new file was actually submitted
            if (duongDanFilePart != null && duongDanFilePart.getSize() > 0 && duongDanFilePart.getSubmittedFileName() != null && !duongDanFilePart.getSubmittedFileName().isEmpty()) {
                // Delete the old file before uploading the new one
                deleteFile(existingMaterial.getDuongDan(), UPLOAD_DIR_FILES, request); 
                newDuongDanFileName = getUploadedFileName(duongDanFilePart, 
                                                request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR_FILES);
            }
        } catch (Exception e) {
            log("Error uploading new material file: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Lỗi khi tải file tài liệu mới lên: " + e.getMessage());
            showEditForm(request, response);
            return;
        }
        existingMaterial.setDuongDan(newDuongDanFileName); // Update with new (or old) file name


        // --- Handle Image file upload for 'Image' field (thumbnail) ---
        String newImageFileName = existingMaterial.getImage(); // Keep old image by default
        try {
            Part imageFilePart = request.getPart("image");
            if (imageFilePart != null && imageFilePart.getSize() > 0 && imageFilePart.getSubmittedFileName() != null && !imageFilePart.getSubmittedFileName().isEmpty()) {
                // Delete old image before uploading new one
                deleteFile(existingMaterial.getImage(), UPLOAD_DIR_IMAGES, request); 
                newImageFileName = getUploadedFileName(imageFilePart, 
                                                request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR_IMAGES);
            }
        } catch (Exception e) {
            log("Error uploading new image for material thumbnail: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Lỗi khi tải ảnh đại diện mới lên: " + e.getMessage());
            // Log but don't halt the process if thumbnail is optional
        }
        existingMaterial.setImage(newImageFileName); // Update with new (or old) image name

        // Update the material in the database
        materialDAO.updateMaterial(existingMaterial);

        // Redirect to the material list page with a success message
        response.sendRedirect(request.getContextPath() + "/ManageMaterial?message=update_success");
    }

    /**
     * Handles deleting an existing material and its associated files.
     */
    private void handleDeleteMaterial(HttpServletRequest request, HttpServletResponse response)    
            throws SQLException, ServletException, IOException {
        
        int materialId = 0;
        try {
            materialId = Integer.parseInt(request.getParameter("id")); // Get material ID from request
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid material ID for deletion.");
            return;
        }

        // Fetch the material details to get file paths before deleting from DB
        DangTaiLieu materialToDelete = materialDAO.getMaterialById(materialId);

        // If material not found, send 404 error
        if (materialToDelete == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Material to delete not found.");
            return;
        }

        // Delete the physical files from the server
        deleteFile(materialToDelete.getDuongDan(), UPLOAD_DIR_FILES, request); // Delete actual material file
        deleteFile(materialToDelete.getImage(), UPLOAD_DIR_IMAGES, request); // Delete thumbnail image

        // Delete the material record from the database
        materialDAO.deleteMaterial(materialId);    

        // Redirect to the material list page with a success message
        response.sendRedirect(request.getContextPath() + "/ManageMaterial?message=delete_success");
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing teaching materials.";
    }
}