// Author: trungdam
// Servlet: StudentAssignmentServlet
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
import java.math.BigDecimal; // Not used in this snippet, can be removed if not needed elsewhere

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // Max file size in memory (2MB)
                maxFileSize = 1024 * 1024 * 10,        // Max single file size (10MB)
                maxRequestSize = 1024 * 1024 * 50)     // Max total request size (50MB)
public class StudentAssignmentServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "uploads"; // Directory for file uploads on the server
    private static final int ITEMS_PER_PAGE = 4; // Number of assignments to display per page

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(); // Get the current user session
        TaiKhoan user = (TaiKhoan) session.getAttribute("user"); // Get the logged-in user object

        // Validate if the user is logged in and has the student role (ID_VaiTro = 4)
        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp"); // Redirect to login page if not authenticated or not a student
            return;
        }

        int classId = 0;
        String classIdParam = request.getParameter("classId"); // Get the class ID from the request URL

        // Validate the classId parameter
        if (classIdParam != null && !classIdParam.isEmpty()) {
            try {
                classId = Integer.parseInt(classIdParam); // Parse class ID to an integer
            } catch (NumberFormatException e) {
                // If class ID is invalid, redirect to the student's class list page
                response.sendRedirect(request.getContextPath() + "/StudentViewClassServlet"); 
                return;
            }
        } else {
            // If no class ID is provided, redirect to the student's class list page
            response.sendRedirect(request.getContextPath() + "/StudentViewClassServlet"); 
            return;
        }

        // Fetch class details for display on the page
        LopHocDAO lopHocDAO = new LopHocDAO();
        LopHoc currentClass = lopHocDAO.getLopHocById(classId); 

        // Set class details as request attributes for the JSP
        request.setAttribute("classCode", currentClass.getClassCode()); 
        request.setAttribute("className", currentClass.getTenLopHoc()); 
        
        // Get the search query parameter from the request
        String searchQuery = request.getParameter("search");
        // Trim whitespace and set to null if empty to simplify search logic
        if (searchQuery != null && searchQuery.trim().isEmpty()) {
            searchQuery = null; 
        }
        request.setAttribute("searchQuery", searchQuery); // Set search query for JSP to maintain state

        // Pagination setup
        int currentPage = 1;
        String pageParam = request.getParameter("page"); // Get the current page number from the request
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam); // Parse the current page
            } catch (NumberFormatException e) {
                currentPage = 1; // Default to page 1 if parsing fails
            }
        }

        // Initialize DAOs for assignments and submissions
        TaiBaiTapDAO assignmentDAO = new TaiBaiTapDAO(); 
        NopBaiTapDAO submissionDAO = new NopBaiTapDAO(); 

        int totalAssignments;
        List<TaoBaiTap> assignments;

        // Fetch assignments based on whether a search query is provided
        if (searchQuery != null) {
            totalAssignments = assignmentDAO.getTotalAssignmentsByClassIdAndSearch(classId, searchQuery); // Get total assignments filtered by search
            int offset = (currentPage - 1) * ITEMS_PER_PAGE; // Calculate the starting index for pagination
            assignments = assignmentDAO.getAssignmentsByClassIdPaginatedAndSearch(classId, searchQuery, offset, ITEMS_PER_PAGE); // Get paginated filtered assignments
        } else {
            totalAssignments = assignmentDAO.getTotalAssignmentsByClassId(classId); // Get total assignments for the class
            int offset = (currentPage - 1) * ITEMS_PER_PAGE; // Calculate the starting index for pagination
            assignments = assignmentDAO.getAssignmentsByClassIdPaginated(classId, offset, ITEMS_PER_PAGE); // Get paginated assignments
        }
        
        int totalPages = (int) Math.ceil((double) totalAssignments / ITEMS_PER_PAGE); // Calculate total number of pages
        // Ensure at least 1 page if there are assignments, even if it's less than ITEMS_PER_PAGE
        if (totalPages == 0 && totalAssignments > 0) totalPages = 1; 
        
        // Handle cases where the current page is out of bounds
        if (currentPage > totalPages && totalPages > 0) {
            // Redirect to the last valid page if the requested page is too high
            response.sendRedirect(request.getContextPath() + "/StudentAssignmentServlet?classId=" + classId + "&page=" + totalPages + (searchQuery != null ? "&search=" + searchQuery : ""));
            return;
        }
        // If there are no assignments, reset current page and total pages to reflect empty state
        if (totalAssignments == 0) {
            currentPage = 1;
            totalPages = 0;
        }

        // Fetch student's submissions for the assignments currently displayed on the page
        Map<Integer, NopBaiTap> studentSubmissions = new HashMap<>(); // Map to store submissions (key: assignmentId, value: submission object)
        int studentId = user.getID_TaiKhoan(); // Get the student's account ID

        for (TaoBaiTap assignment : assignments) { // Loop through each assignment
            // Get the submission for the current student and assignment
            NopBaiTap submission = submissionDAO.getSubmissionByStudentAndAssignment(studentId, assignment.getID_BaiTap()); 
            if (submission != null) {
                studentSubmissions.put(assignment.getID_BaiTap(), submission); // Add the submission to the map if it exists
            }
        }
        request.setAttribute("studentSubmissions", studentSubmissions); // Set student submissions for JSP

        // Set remaining attributes for the JSP
        request.setAttribute("currentDate", java.time.LocalDate.now()); // Set the current date
        request.setAttribute("assignments", assignments); // The list of assignments to display
        request.setAttribute("classId", classId); // The current class ID
        request.setAttribute("currentPage", currentPage); // The current page number
        request.setAttribute("totalPages", totalPages); // The total number of pages
        request.setAttribute("totalAssignments", totalAssignments); // The total count of assignments

        // Forward the request to the student assignments JSP page
        request.getRequestDispatcher("/views/student/studentAssignments.jsp").forward(request, response); 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(); // Get the current user session
        TaiKhoan user = (TaiKhoan) session.getAttribute("user"); // Get the logged-in user object

        // Validate user session and role (must be student, ID_VaiTro = 4)
        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp"); // Redirect to login page if not authenticated or not a student
            return;
        }

        // Get parameters from the form submission
        int assignmentId = Integer.parseInt(request.getParameter("assignmentId")); // Get the ID of the assignment being submitted
        int studentId = user.getID_TaiKhoan(); // Get the student's ID from the session

        int classId = Integer.parseInt(request.getParameter("classId")); // Get the class ID to maintain context
        String searchQuery = request.getParameter("search"); // Get the search query to maintain filter state

        // Define and create the upload directory for submitted files
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY; // Get the absolute path to the upload directory
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); // Create the directory if it doesn't exist 
        }

        String fileName = null;
        try {
            Part filePart = request.getPart("submissionFile"); // Get the file part from the multipart request
            fileName = extractFileName(filePart); // Extract the original file name
            if (fileName != null && !fileName.isEmpty()) {
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName; // Create a unique file name using timestamp
                filePart.write(uploadPath + File.separator + uniqueFileName); // Save the file to the server
                fileName = uniqueFileName; // Use the unique file name for storing in the database
            }
        } catch (Exception e) { // Catch any exceptions during file upload
            e.printStackTrace(); // Print stack trace for debugging
            request.setAttribute("errorMessage", "Lỗi tải lên tệp: " + e.getMessage()); // Set an error message for the JSP
            
            // Re-fetch necessary data to re-render the page with the error message
            LopHocDAO lopHocDAO = new LopHocDAO();
            LopHoc currentClass = lopHocDAO.getLopHocById(classId);
            if(currentClass != null) {
                request.setAttribute("classCode", currentClass.getClassCode());
                request.setAttribute("className", currentClass.getTenLopHoc());
            }

            request.setAttribute("classId", classId); // Preserve class ID
            request.setAttribute("searchQuery", searchQuery); // Preserve search query

            // Re-fetch assignment data for display, typically for the first page after an error
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
            request.setAttribute("currentPage", 1); // Reset to page 1 on error
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalAssignments", totalAssignments);
            
            // Forward back to the student assignments JSP page with the error message
            request.getRequestDispatcher("/views/student/studentAssignments.jsp").forward(request, response); 
            return; // Stop further execution
        }

        // Prepare the submission data object
        NopBaiTapDAO nopBaiTapDAO = new NopBaiTapDAO(); // DAO for handling submissions
        NopBaiTap submission = new NopBaiTap();
        submission.setID_HocSinh(studentId); // Set student ID
        submission.setID_BaiTap(assignmentId); // Set assignment ID
        submission.setTepNop(fileName); // Set the name of the submitted file (path on server)
        submission.setNgayNop(LocalDate.now()); // Set the submission date to today
        submission.setDiem(null); // Initialize score as null (assignment not yet graded)
        submission.setNhanXet(null); // Initialize comment as null
        submission.setID_LopHoc(classId); // Set class ID

        try {
            // Check if a submission for this student and assignment already exists
            NopBaiTap existingSubmission = nopBaiTapDAO.getSubmissionByStudentAndAssignment(studentId, assignmentId); 
            if (existingSubmission != null) {
                // If an existing submission is found, update it
                nopBaiTapDAO.updateSubmission(submission); 
            } else {
                // Otherwise, add a new submission
                nopBaiTapDAO.addSubmission(submission); 
            }
            request.setAttribute("successMessage", "Nộp bài thành công!"); // Set a success message for the JSP
        } catch (Exception e) { // Catch any database errors during submission
            e.printStackTrace(); // Print stack trace for debugging
            request.setAttribute("errorMessage", "Lỗi khi nộp bài: " + e.getMessage()); // Set an error message for the JSP
        }

        // Redirect back to the assignment list page, maintaining class ID and search query
        String redirectUrl = request.getContextPath() + "/StudentAssignmentServlet?classId=" + classId;
        if (searchQuery != null && !searchQuery.isEmpty()) {
            redirectUrl += "&search=" + searchQuery; // Append search query if present
        }
        response.sendRedirect(redirectUrl); // Redirect to show the updated assignment list
    }

    /**
     * Helper method to extract the original file name from a `Part` object.
     * @param part The `Part` object representing the uploaded file.
     * @return The extracted file name, or null if not found.
     */
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition"); // Get the Content-Disposition header
        String[] items = contentDisp.split(";"); // Split the header by semicolon
        for (String s : items) {
            if (s.trim().startsWith("filename")) { // Find the part that contains "filename"
                // Extract and return the filename, removing quotes
                return s.substring(s.indexOf("=") + 2, s.length() - 1); 
            }
        }
        return null; // Return null if the filename could not be extracted
    }
}