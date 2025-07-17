package controller;

import dal.TaiBaiTapDAO;
import dal.NopBaiTapDAO;
import dal.LopHocDAO; // Import LopHocDAO
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.TaiKhoan;
import model.TaoBaiTap;
import model.NopBaiTap;
import model.LopHoc; // Import LopHoc model

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.math.BigDecimal;

@WebServlet(name = "StudentAssignmentServlet", urlPatterns = {"/StudentAssignmentServlet"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class StudentAssignmentServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "uploads";
    private static final int ITEMS_PER_PAGE = 4;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int classId = 0;
        String classIdParam = request.getParameter("classId");
        if (classIdParam != null && !classIdParam.isEmpty()) {
            try {
                classId = Integer.parseInt(classIdParam);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/StudentViewClassServlet");
                return;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/StudentViewClassServlet");
            return;
        }

        // --- NEW: Get Class details for "Back" button and header display ---
        LopHocDAO lopHocDAO = new LopHocDAO();
        LopHoc currentClass = lopHocDAO.getLopHocById(classId); // Assuming you have getLopHocById in LopHocDAO

        if (currentClass == null) {
            response.sendRedirect(request.getContextPath() + "/StudentViewClassServlet"); // Class not found
            return;
        }
        request.setAttribute("classCode", currentClass.getClassCode()); // Pass classCode for back button
        request.setAttribute("className", currentClass.getTenLopHoc()); // Pass class name for header
        // --- End NEW ---

        String searchQuery = request.getParameter("search");
        if (searchQuery != null && searchQuery.trim().isEmpty()) {
            searchQuery = null;
        }
        request.setAttribute("searchQuery", searchQuery);

        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        TaiBaiTapDAO assignmentDAO = new TaiBaiTapDAO();
        NopBaiTapDAO submissionDAO = new NopBaiTapDAO();

        int totalAssignments;
        List<TaoBaiTap> assignments;

        if (searchQuery != null) {
            totalAssignments = assignmentDAO.getTotalAssignmentsByClassIdAndSearch(classId, searchQuery);
            int offset = (currentPage - 1) * ITEMS_PER_PAGE;
            assignments = assignmentDAO.getAssignmentsByClassIdPaginatedAndSearch(classId, searchQuery, offset, ITEMS_PER_PAGE);
        } else {
            totalAssignments = assignmentDAO.getTotalAssignmentsByClassId(classId);
            int offset = (currentPage - 1) * ITEMS_PER_PAGE;
            assignments = assignmentDAO.getAssignmentsByClassIdPaginated(classId, offset, ITEMS_PER_PAGE);
        }
        
        int totalPages = (int) Math.ceil((double) totalAssignments / ITEMS_PER_PAGE);
        if (totalPages == 0 && totalAssignments > 0) totalPages = 1;
        
        if (currentPage > totalPages && totalPages > 0) {
            response.sendRedirect(request.getContextPath() + "/StudentAssignmentServlet?classId=" + classId + "&page=" + totalPages + (searchQuery != null ? "&search=" + searchQuery : ""));
            return;
        }
        if (totalAssignments == 0) {
            currentPage = 1;
            totalPages = 0;
        }

        Map<Integer, NopBaiTap> studentSubmissions = new HashMap<>();
        int studentId = user.getID_TaiKhoan();

        for (TaoBaiTap assignment : assignments) {
            NopBaiTap submission = submissionDAO.getSubmissionByStudentAndAssignment(studentId, assignment.getID_BaiTap());
            if (submission != null) {
                studentSubmissions.put(assignment.getID_BaiTap(), submission);
            }
        }
        request.setAttribute("studentSubmissions", studentSubmissions);

        request.setAttribute("assignments", assignments);
        request.setAttribute("classId", classId);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalAssignments", totalAssignments);

        request.getRequestDispatcher("/views/student/studentAssignments.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
        int studentId = user.getID_TaiKhoan();

        int classId = Integer.parseInt(request.getParameter("classId"));
        String searchQuery = request.getParameter("search"); // Get search query to pass back

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        String fileName = null;
        try {
            Part filePart = request.getPart("submissionFile");
            fileName = extractFileName(filePart);
            if (fileName != null && !fileName.isEmpty()) {
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                filePart.write(uploadPath + File.separator + uniqueFileName);
                fileName = uniqueFileName;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải lên tệp: " + e.getMessage());
            // Re-fetch class info for error display
            LopHocDAO lopHocDAO = new LopHocDAO();
            LopHoc currentClass = lopHocDAO.getLopHocById(classId);
            if(currentClass != null) {
                request.setAttribute("classCode", currentClass.getClassCode());
                request.setAttribute("className", currentClass.getTenLopHoc());
            }

            request.setAttribute("classId", classId);
            request.setAttribute("searchQuery", searchQuery); // Preserve search query
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
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalAssignments", totalAssignments);
            request.getRequestDispatcher("/views/student/studentAssignments.jsp").forward(request, response);
            return;
        }

        NopBaiTapDAO nopBaiTapDAO = new NopBaiTapDAO();
        NopBaiTap submission = new NopBaiTap();
        submission.setID_HocSinh(studentId);
        submission.setID_BaiTap(assignmentId);
        submission.setTepNop(fileName);
        submission.setNgayNop(LocalDate.now());
        submission.setDiem(null);
        submission.setNhanXet(null);
        submission.setID_LopHoc(classId);

        try {
            NopBaiTap existingSubmission = nopBaiTapDAO.getSubmissionByStudentAndAssignment(studentId, assignmentId);
            if (existingSubmission != null) {
                nopBaiTapDAO.updateSubmission(submission);
            } else {
                nopBaiTapDAO.addSubmission(submission);
            }
            request.setAttribute("successMessage", "Nộp bài thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi nộp bài: " + e.getMessage());
        }

        String redirectUrl = request.getContextPath() + "/StudentAssignmentServlet?classId=" + classId;
        if (searchQuery != null && !searchQuery.isEmpty()) {
            redirectUrl += "&search=" + searchQuery;
        }
        response.sendRedirect(redirectUrl);
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return null;
    }
}