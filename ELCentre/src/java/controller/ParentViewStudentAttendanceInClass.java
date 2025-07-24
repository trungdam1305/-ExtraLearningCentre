// Author: trungdam
// Servlet: ParentViewStudentAttendanceInClassServlet
package controller;

import dal.DiemDanhDAO;
import dal.HocSinhDAO;
import dal.LichHocDAO;
import dal.LopHocDAO;
import dal.PhuHuynhDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList; // Needed for studentListForJSP
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.DiemDanh;
import model.HocSinh;
import model.LichHoc;
import model.LopHoc;
import model.PhuHuynh;
import model.TaiKhoan;

public class ParentViewStudentAttendanceInClass extends HttpServlet {

    // Instantiate DAOs (consider dependency injection for larger applications)
    private LopHocDAO lopHocDAO;
    private HocSinhDAO hocSinhDAO;
    private LichHocDAO lichHocDAO;
    private DiemDanhDAO diemDanhDAO;
    private PhuHuynhDAO phuHuynhDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize DAOs once when the servlet starts
        lopHocDAO = new LopHocDAO();
        hocSinhDAO = new HocSinhDAO();
        lichHocDAO = new LichHocDAO();
        diemDanhDAO = new DiemDanhDAO();
        phuHuynhDAO = new PhuHuynhDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // 1. Authenticate Parent
        if (user == null || user.getID_VaiTro() != 5) { // ID_VaiTro = 5 for Parent
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int idTaiKhoanPhuHuynh = user.getID_TaiKhoan();
        PhuHuynh phuHuynh = phuHuynhDAO.getPhuHuynhByTaiKhoanId(idTaiKhoanPhuHuynh);
        request.setAttribute("phuHuynh", phuHuynh); // Set parent info for the JSP header/sidebar

        // 2. Get idHocSinh and idLopHoc from request parameters
        String idHocSinhParam = request.getParameter("idHocSinh");
        String idLopHocParam = request.getParameter("idLopHoc");

        if (idHocSinhParam == null || idHocSinhParam.isEmpty() ||
            idLopHocParam == null || idLopHocParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing student ID or class ID parameters.");
            return;
        }

        try {
            int idHocSinh = Integer.parseInt(idHocSinhParam);
            int idLopHoc = Integer.parseInt(idLopHocParam);

            // 3. Validate if the student belongs to the parent (security check)
            List<HocSinh> childrenList = hocSinhDAO.getHocSinhByPhuHuynhPhone(phuHuynh.getSDT());
            boolean isChildOfParent = false;
            for (HocSinh child : childrenList) {
                if (child.getID_HocSinh() == idHocSinh) {
                    isChildOfParent = true;
                    break;
                }
            }

            if (!isChildOfParent) {
                System.err.println("Unauthorized access attempt: Parent " + user.getEmail() + " tried to view schedule for student ID " + idHocSinh);
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xem thông tin của học sinh này.");
                return;
            }

            // Call the private method to handle data fetching and forwarding
            showParentStudentAttendanceReport(request, response, idHocSinh, idLopHoc);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Định dạng ID học sinh hoặc lớp không hợp lệ.");
        } 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for parents to view a specific student's attendance report for a class.";
    }

    /**
     * Helper method to fetch and set attributes for the attendance report JSP.
     * This encapsulates the logic similar to your provided method.
     */
    private void showParentStudentAttendanceReport(HttpServletRequest request, HttpServletResponse response, int idHocSinh, int idLopHoc)
            throws ServletException, IOException {
        
        // Fetch specific student and class information
        HocSinh hocSinh = hocSinhDAO.getHocSinhById(idHocSinh);
        LopHoc lopHoc = lopHocDAO.getLopHocById(idLopHoc);

        if (hocSinh == null || lopHoc == null) {
            request.setAttribute("errorMessage", "Không tìm thấy thông tin học sinh hoặc lớp học.");
            request.getRequestDispatcher("/views/parent/parentDashboard.jsp").forward(request, response); // Redirect to a safe page
            return;
        }

        // Get all schedules for this specific class
        List<LichHoc> scheduleList = lichHocDAO.getLichHocByLopHoc(idLopHoc);

        // Get attendance records for this specific student in this specific class
        List<DiemDanh> attendanceRecords = lichHocDAO.getDiemDanhByHocSinhAndLopHoc(idHocSinh, idLopHoc);

        // Create a map for easy lookup of attendance status (Key: "ID_HocSinh-ID_Schedule")
        Map<String, DiemDanh> attendanceMap = new HashMap<>();
        for (DiemDanh dd : attendanceRecords) {
            attendanceMap.put(dd.getID_HocSinh() + "-" + dd.getID_Schedule(), dd);
        }

        // Prepare a single-student list for the JSP (as the JSP expects a list)
        List<HocSinh> studentListForJSP = new ArrayList<>();
        studentListForJSP.add(hocSinh);

        // Set attributes for the JSP
        request.setAttribute("hocSinh", hocSinh);           // The specific student being viewed
        request.setAttribute("lopHoc", lopHoc);             // The specific class being viewed
        request.setAttribute("studentList", studentListForJSP); // A list containing only the selected student
        request.setAttribute("scheduleList", scheduleList); // All schedules for the selected class
        request.setAttribute("attendanceMap", attendanceMap); // Attendance data for the student in these schedules

        // Forward to the parent-specific attendance report JSP
        request.getRequestDispatcher("/views/parent/parentClassAttendanceReport.jsp").forward(request, response);
    }
}