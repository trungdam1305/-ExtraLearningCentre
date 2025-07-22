package controller;

import dal.TaiBaiTapDAO;
import dal.NopBaiTapDAO;
import dal.LopHocDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.TaiKhoan;
import model.TaoBaiTap;
import model.NopBaiTap;
import model.LopHoc;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.math.BigDecimal;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // Max file size in memory (2MB)
                 maxFileSize = 1024 * 1024 * 10,       // Max single file size (10MB)
                 maxRequestSize = 1024 * 1024 * 50)    // Max total request size (50MB)
public class StudentAssignmentServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "uploads"; // Directory for file uploads
    private static final int ITEMS_PER_PAGE = 4; // Number of assignments per page

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(); // Get current session
        TaiKhoan user = (TaiKhoan) session.getAttribute("user"); // Get logged-in user

        // Validate user session and role (must be student, ID_VaiTro = 4)
        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp"); // Redirect to login
            return;
        }

        int classId = 0;
        String classIdParam = request.getParameter("classId"); // Get class ID from request

        // Validate classId parameter
        if (classIdParam != null && !classIdParam.isEmpty()) {
            try {
                classId = Integer.parseInt(classIdParam); 
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/StudentViewClassServlet"); // Redirect on invalid ID
                return;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/StudentViewClassServlet"); // Redirect if no class ID
            return;
        }

        // Get Class details for display purposes
        LopHocDAO lopHocDAO = new LopHocDAO();
        LopHoc currentClass = lopHocDAO.getLopHocById(classId); 

        request.setAttribute("classCode", currentClass.getClassCode()); // Set class code for JSP
        request.setAttribute("className", currentClass.getTenLopHoc()); // Set class name for JSP
        
        // Get search query parameter
        String searchQuery = request.getParameter("search");
        if (searchQuery != null && searchQuery.trim().isEmpty()) {
            searchQuery = null; 
        }
        request.setAttribute("searchQuery", searchQuery); // Set search query for JSP

        // Pagination setup
        int currentPage = 1;
        String pageParam = request.getParameter("page"); // Get current page parameter
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam); // Parse current page
            } catch (NumberFormatException e) {
                currentPage = 1; // Default to 1 on error
            }
        }

        // Initialize DAOs
        TaiBaiTapDAO assignmentDAO = new TaiBaiTapDAO(); // DAO for assignments
        NopBaiTapDAO submissionDAO = new NopBaiTapDAO(); // DAO for submissions

        int totalAssignments;
        List<TaoBaiTap> assignments;

        // Fetch assignments based on search query or without
        if (searchQuery != null) {
            totalAssignments = assignmentDAO.getTotalAssignmentsByClassIdAndSearch(classId, searchQuery); // Get total filtered assignments
            int offset = (currentPage - 1) * ITEMS_PER_PAGE; // Calculate pagination offset
            assignments = assignmentDAO.getAssignmentsByClassIdPaginatedAndSearch(classId, searchQuery, offset, ITEMS_PER_PAGE); // Get paginated filtered assignments
        } else {
            totalAssignments = assignmentDAO.getTotalAssignmentsByClassId(classId); // Get total assignments for class
            int offset = (currentPage - 1) * ITEMS_PER_PAGE; // Calculate pagination offset
            assignments = assignmentDAO.getAssignmentsByClassIdPaginated(classId, offset, ITEMS_PER_PAGE); 
        }
        
        int totalPages = (int) Math.ceil((double) totalAssignments / ITEMS_PER_PAGE); // Calculate total pages
        if (totalPages == 0 && totalAssignments > 0) totalPages = 1; // Ensure at least 1 page if items exist
        
        if (currentPage > totalPages && totalPages > 0) {
            response.sendRedirect(request.getContextPath() + "/StudentAssignmentServlet?classId=" + classId + "&page=" + totalPages + (searchQuery != null ? "&search=" + searchQuery : ""));
            return;
        }
        if (totalAssignments == 0) {
            currentPage = 1;
            totalPages = 0;
        }

        // Fetch student's submissions for displayed assignments
        Map<Integer, NopBaiTap> studentSubmissions = new HashMap<>(); // Map to store student submissions (assignmentId -> submission)
        int studentId = user.getID_TaiKhoan(); // Get student's account ID

        for (TaoBaiTap assignment : assignments) { // Loop through assignments
            NopBaiTap submission = submissionDAO.getSubmissionByStudentAndAssignment(studentId, assignment.getID_BaiTap()); // Get submission for current assignment
            if (submission != null) {
                studentSubmissions.put(assignment.getID_BaiTap(), submission); // Add to map if submission exists
            }
        }
        request.setAttribute("studentSubmissions", studentSubmissions); // Set student submissions for JSP

        // Set attributes for JSP
        request.setAttribute("currentDate", java.time.LocalDate.now()); 
        request.setAttribute("assignments", assignments); // List of assignments
        request.setAttribute("classId", classId); // Current class ID
        request.setAttribute("currentPage", currentPage); // Current page number
        request.setAttribute("totalPages", totalPages); // Total number of pages
        request.setAttribute("totalAssignments", totalAssignments); // Total assignments count

        request.getRequestDispatcher("/views/student/studentAssignments.jsp").forward(request, response); // Forward to student assignments JSP
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(); // Get current session
        TaiKhoan user = (TaiKhoan) session.getAttribute("user"); // Get logged-in user

        // Validate user session and role (must be student, ID_VaiTro = 4)
        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp"); // Redirect to login
            return;
        }

        int assignmentId = Integer.parseInt(request.getParameter("assignmentId")); // Get assignment ID from form
        int studentId = user.getID_TaiKhoan(); // Get student's ID

        int classId = Integer.parseInt(request.getParameter("classId")); // Get class ID from form
        String searchQuery = request.getParameter("search"); // Get search query to maintain filter state

        // Setup upload directory
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY; // Get absolute upload path
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); 
        }

        String fileName = null;
        try {
            Part filePart = request.getPart("submissionFile"); // Get the submitted file part
            fileName = extractFileName(filePart); // Extract original file name
            if (fileName != null && !fileName.isEmpty()) {
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName; // Create unique file name
                filePart.write(uploadPath + File.separator + uniqueFileName); // Save file to server
                fileName = uniqueFileName; // Use unique file name for database
            }
        } catch (Exception e) { // Handle file upload errors
            e.printStackTrace(); // Log error
            request.setAttribute("errorMessage", "Lỗi tải lên tệp: " + e.getMessage()); // Set error message for JSP
            
            // Re-fetch class info and assignments to re-render the page with error message
            LopHocDAO lopHocDAO = new LopHocDAO();
            LopHoc currentClass = lopHocDAO.getLopHocById(classId);
            if(currentClass != null) {
                request.setAttribute("classCode", currentClass.getClassCode());
                request.setAttribute("className", currentClass.getTenLopHoc());
            }

            request.setAttribute("classId", classId); // Preserve class ID
            request.setAttribute("searchQuery", searchQuery); // Preserve search query

            // Re-fetch assignment data for display
            TaiBaiTapDAO assignmentDAO = new TaiBaiTapDAO();
            int totalAssignments;
            List<TaoBaiTap> assignments;
            if (searchQuery != null) {
                totalAssignments = assignmentDAO.getTotalAssignmentsByClassIdAndSearch(classId, searchQuery);
                assignments = assignmentDAO.getAssignmentsByClassIdPaginatedAndSearch(classId, searchQuery, (1 - 1) * ITEMS_PER_PAGE, ITEMS_PER_PAGE);
            } else {
                totalAssignments = assignmentDAO.getTotalAssignmentsByClassId(classId);
                assignments = assignmentDAO.getAssignmentsByClassIdPaginated(classId, (1 - 1) * ITEMS_PER_PAGE, ITEMS_PER_PAGE);
            }
            int totalPages = (int) Math.ceil((double) totalAssignments / ITEMS_PER_PAGE);

            request.setAttribute("assignments", assignments);
            request.setAttribute("currentPage", 1); // Reset page to 1 on error
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalAssignments", totalAssignments);
            
            request.getRequestDispatcher("/views/student/studentAssignments.jsp").forward(request, response); // Forward back to JSP with error
            return; // Stop execution
        }

        // Prepare submission data
        NopBaiTapDAO nopBaiTapDAO = new NopBaiTapDAO(); // DAO for submissions
        NopBaiTap submission = new NopBaiTap();
        submission.setID_HocSinh(studentId); // Set student ID
        submission.setID_BaiTap(assignmentId); // Set assignment ID
        submission.setTepNop(fileName); // Set submitted file name (path)
        submission.setNgayNop(LocalDate.now()); // Set submission date to today
        submission.setDiem(null); // Initialize score as null (not yet graded)
        submission.setNhanXet(null); // Initialize comment as null
        submission.setID_LopHoc(classId); // Set class ID

        try {
            NopBaiTap existingSubmission = nopBaiTapDAO.getSubmissionByStudentAndAssignment(studentId, assignmentId); // Check for existing submission
            if (existingSubmission != null) {
                nopBaiTapDAO.updateSubmission(submission); // Update existing submission
            } else {
                nopBaiTapDAO.addSubmission(submission); // Add new submission
            }
            request.setAttribute("successMessage", "Nộp bài thành công!"); // Set success message
        } catch (Exception e) { // Handle database submission errors
            e.printStackTrace(); // Log error
            request.setAttribute("errorMessage", "Lỗi khi nộp bài: " + e.getMessage()); // Set error message for JSP
        }

        // Redirect back to the assignment list page
        String redirectUrl = request.getContextPath() + "/StudentAssignmentServlet?classId=" + classId;
        if (searchQuery != null && !searchQuery.isEmpty()) {
            redirectUrl += "&search=" + searchQuery; // Append search query if present
        }
        response.sendRedirect(redirectUrl); // Redirect to show updated assignment list
    }

    // Helper method to extract file name from Part
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition"); // Get content-disposition header
        String[] items = contentDisp.split(";"); // Split by semicolon
        for (String s : items) {
            if (s.trim().startsWith("filename")) { // Find filename part
                return s.substring(s.indexOf("=") + 2, s.length() - 1); // Extract and return file name
            }
        }
        return null; // Return null if filename not found
    }
}