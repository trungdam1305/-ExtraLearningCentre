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
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action specified.");
                    break;
            }
        } catch (SQLException e) {
            log("Database error in ManageMaterial doGet: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            log("Invalid number format in ManageMaterial doGet: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Invalid input format for ID.");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        } catch (Exception e) {
            log("An unexpected error occurred in ManageMaterial doGet: " + e.getMessage(), e);
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
                case "addMaterial":
                    handleAddMaterial(request, response);
                    break;
                case "updateMaterial":
                    handleUpdateMaterial(request, response);
                    break;
                case "deleteMaterial":
                    handleDeleteMaterial(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid or unsupported POST action.");
                    break;
            }
        } catch (SQLException e) {
        } 
    }

    private void handleListMaterials(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String monHocIdParam = request.getParameter("monHoc");
        String loaiTaiLieuIdParam = request.getParameter("loaiTaiLieu");
        String pageParam = request.getParameter("page");

        int currentPage = 1;
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid page parameter: " + pageParam, e);
        }
        int pageSize = 10;

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
        
        List<DangTaiLieu> materialList = materialDAO.getFilteredMaterials(keyword, filterMonHocId, filterLoaiTaiLieuId, currentPage, pageSize);
        int totalMaterials = materialDAO.countFilteredMaterials(keyword, filterMonHocId, filterLoaiTaiLieuId);
        
        List<MonHoc> allMonHoc = materialDAO.getAllMonHoc();
        List<LoaiTaiLieu> allLoaiTaiLieu = materialDAO.getAllLoaiTaiLieu();

        int totalPages = (int) Math.ceil((double) totalMaterials / pageSize);

        request.setAttribute("materialList", materialList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedMonHocId", filterMonHocId != null ? filterMonHocId : 0);
        request.setAttribute("selectedLoaiTaiLieuId", filterLoaiTaiLieuId != null ? filterLoaiTaiLieuId : 0);

        request.setAttribute("allMonHoc", allMonHoc);
        request.setAttribute("allLoaiTaiLieu", allLoaiTaiLieu);

        request.getRequestDispatcher("/views/staff/manageMaterial.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        List<MonHoc> allMonHoc = materialDAO.getAllMonHoc();
        List<LoaiTaiLieu> allLoaiTaiLieu = materialDAO.getAllLoaiTaiLieu();

        request.setAttribute("allMonHoc", allMonHoc);
        request.setAttribute("allLoaiTaiLieu", allLoaiTaiLieu);
        request.setAttribute("material", null);
        request.setAttribute("formTitle", "Thêm Tài Liệu Mới");
        request.getRequestDispatcher("/views/staff/addEditMaterial.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
            int materialId = Integer.parseInt(request.getParameter("id"));
         DangTaiLieu material = materialDAO.getMaterialById(materialId);

        if (material == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Material not found for editing.");
            return;
        }

        List<MonHoc> allMonHoc = materialDAO.getAllMonHoc();
        List<LoaiTaiLieu> allLoaiTaiLieu = materialDAO.getAllLoaiTaiLieu();

        request.setAttribute("allMonHoc", allMonHoc);
        request.setAttribute("allLoaiTaiLieu", allLoaiTaiLieu);
        request.setAttribute("material", material);
        request.setAttribute("formTitle", "Sửa Tài Liệu");
        request.getRequestDispatcher("/views/staff/addEditMaterial.jsp").forward(request, response);
    }

    private static final String UPLOAD_DIR_FILES = ""; // For actual material files (PDF, DOCX)
    private static final String UPLOAD_DIR_IMAGES = ""; // For thumbnail images

    private String getUploadedFileName(Part part, String uploadPath) throws IOException {
        String fileName = part.getSubmittedFileName();
        String fileExtension = "";
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0) {
            fileExtension = fileName.substring(dotIndex);
        }
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        part.write(new File(uploadPath, uniqueFileName).getAbsolutePath());
        return uniqueFileName;
    }

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


    private void handleAddMaterial(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        String tenTaiLieu = request.getParameter("tenTaiLieu");
        String giaTien = request.getParameter("giaTien"); // String for now, parse later if needed
        String noiDung = request.getParameter("noiDung"); // NEW: CKEditor content

        String idMonHocParam = request.getParameter("idMonHoc");
        String idLoaiTaiLieuParam = request.getParameter("idLoaiTaiLieu");

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        Integer idGiaoVien = null;
        if (user != null) {
            idGiaoVien = user.getID_TaiKhoan();
        }

        // Validate required fields
        if (tenTaiLieu == null || tenTaiLieu.trim().isEmpty() ||
            noiDung == null || noiDung.trim().isEmpty()) { // NoiDung is also required
            
            request.setAttribute("errorMessage", "Tên tài liệu và nội dung không được để trống.");
            showAddForm(request, response);
            return;
        }
        
        // --- Handle File Upload for DuongDan ---
        String duongDanFileName = null;
        try {
            Part duongDanFilePart = request.getPart("duongDanFile"); // From input type="file" name="duongDanFile"
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

        // Handle Image file upload for 'Image' field (thumbnail)
        String imageFileName = null;
        try {
            Part imageFilePart = request.getPart("image");
            if (imageFilePart != null && imageFilePart.getSize() > 0) {
                 imageFileName = getUploadedFileName(imageFilePart, 
                                            request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR_IMAGES);
            }
        } catch (Exception e) {
           // It's okay to continue if image is optional, but log the error
        }

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

        DangTaiLieu newMaterial = new DangTaiLieu();
        newMaterial.setTenTaiLieu(tenTaiLieu);
        newMaterial.setDuongDan(duongDanFileName); // Set the uploaded file name
        newMaterial.setNgayTao(LocalDateTime.now());
        newMaterial.setGiaTien(giaTien);
        newMaterial.setImage(imageFileName);
        newMaterial.setNoiDung(noiDung); // Set CKEditor content
        
        newMaterial.setID_GiaoVien(idGiaoVien);
        newMaterial.setID_MonHoc(idMonHoc);
        newMaterial.setID_LoaiTaiLieu(idLoaiTaiLieu);

        materialDAO.addMaterial(newMaterial);

        response.sendRedirect(request.getContextPath() + "/ManageMaterial?message=add_success");
    }

    private void handleUpdateMaterial(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int materialId = 0;
        try {
            materialId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid material ID for update.");
            return;
        }

        DangTaiLieu existingMaterial = materialDAO.getMaterialById(materialId);

        if (existingMaterial == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Material to update not found.");
            return;
        }

        String tenTaiLieu = request.getParameter("tenTaiLieu");
        String giaTien = request.getParameter("giaTien");
        String noiDung = request.getParameter("noiDung"); // NEW: CKEditor content

        // Validate required fields
        if (tenTaiLieu == null || tenTaiLieu.trim().isEmpty() ||
            noiDung == null || noiDung.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Tên tài liệu và nội dung không được để trống.");
            showEditForm(request, response);
            return;
        }

        existingMaterial.setTenTaiLieu(tenTaiLieu);
        existingMaterial.setGiaTien(giaTien);
        existingMaterial.setNoiDung(noiDung); // Update CKEditor content

        String idMonHocParam = request.getParameter("idMonHoc");
        String idLoaiTaiLieuParam = request.getParameter("idLoaiTaiLieu");

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
            if (duongDanFilePart != null && duongDanFilePart.getSize() > 0 && duongDanFilePart.getSubmittedFileName() != null && !duongDanFilePart.getSubmittedFileName().isEmpty()) {
                // Delete old file if a new one is uploaded
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
        existingMaterial.setDuongDan(newDuongDanFileName);


        // Handle Image file upload for 'Image' field (thumbnail)
        String newImageFileName = existingMaterial.getImage(); // Keep old image by default
        try {
            Part imageFilePart = request.getPart("image");
            if (imageFilePart != null && imageFilePart.getSize() > 0 && imageFilePart.getSubmittedFileName() != null && !imageFilePart.getSubmittedFileName().isEmpty()) {
                deleteFile(existingMaterial.getImage(), UPLOAD_DIR_IMAGES, request); // Delete old image
                newImageFileName = getUploadedFileName(imageFilePart, 
                                            request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR_IMAGES);
            }
        } catch (Exception e) {
            log("Error uploading new image for material thumbnail: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Lỗi khi tải ảnh đại diện mới lên: " + e.getMessage());
            // Log but don't stop process if thumbnail is optional
        }
        existingMaterial.setImage(newImageFileName);

        materialDAO.updateMaterial(existingMaterial);

        response.sendRedirect(request.getContextPath() + "/ManageMaterial?message=update_success");
    }

    private void handleDeleteMaterial(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int materialId = 0;
        try {
            materialId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid material ID for deletion.");
            return;
        }

        DangTaiLieu materialToDelete = materialDAO.getMaterialById(materialId);

        if (materialToDelete == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Material to delete not found.");
            return;
        }

        // Delete the physical files from the server
        deleteFile(materialToDelete.getDuongDan(), UPLOAD_DIR_FILES, request); // Delete material file
        deleteFile(materialToDelete.getImage(), UPLOAD_DIR_IMAGES, request); // Delete thumbnail image

        materialDAO.deleteMaterial(materialId); 

        response.sendRedirect(request.getContextPath() + "/ManageMaterial?message=delete_success");
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing teaching materials.";
    }
}