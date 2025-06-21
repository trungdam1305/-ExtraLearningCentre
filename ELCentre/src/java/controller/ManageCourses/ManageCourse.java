package controller.ManageCourses;

import dal.KhoaHocDAO;
import dal.LopHocDAO;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.KhoaHoc;
import model.LopHoc;

/**
 *
 * @author Vuh26
 */
public class ManageCourse extends HttpServlet {

// Danh sách tên môn học hợp lệ
    static final List<String> TEN_MON_HOC_HOP_LE = Arrays.asList(
            "Toán", "Ngữ văn", "Vật lý", "Hóa học", "Sinh học",
            "Tin học", "Lịch sử", "Địa lý", "Giáo dục công dân",
            "Tiếng Anh", "Công nghệ", "Thể dục", "Âm nhạc", "Mỹ thuật",
            "Quốc phòng và An ninh"
    ).stream()
            .flatMap(tenMon -> Stream.of("Khóa " + tenMon, "Khóa tổng ôn " + tenMon))
            .collect(Collectors.toList());

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerCourse</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerCourse at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        KhoaHocDAO dao = new KhoaHocDAO();
        String action = request.getParameter("action");
        String message = request.getParameter("message");
        request.setAttribute("message", message);

        // Danh sách các cột hợp lệ để sắp xếp
        List<String> validColumns = Arrays.asList(
                "ID_KhoaHoc", "TenKhoaHoc", "MoTa", "ThoiGianBatDau",
                "ThoiGianKetThuc", "GhiChu", "TrangThai", "NgayTao", "ID_Khoi"
        );

        // Lấy tham số từ request
        String name = request.getParameter("name");
        String sortName = request.getParameter("sortName");
        String sortColumn = request.getParameter("sortColumn");
        String sortOrder = request.getParameter("sortOrder");
        String pageParam = request.getParameter("page");

        // Log tham số để debug
        Logger.getLogger(ManageCourse.class.getName()).log(Level.INFO, "Request params: Action={0}, Name={1}, SortName={2}, SortColumn={3}, SortOrder={4}, Page={5}",
                new Object[]{action, name, sortName, sortColumn, sortOrder, pageParam});

        // Xử lý phân trang
        int pageSize = 8;
        int pageNumber = 1;
        try {
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                pageNumber = Integer.parseInt(pageParam);
                if (pageNumber < 1) {
                    pageNumber = 1;
                }
            }
        } catch (NumberFormatException e) {
            pageNumber = 1;
            Logger.getLogger(ManageCourse.class.getName()).log(Level.WARNING, "Invalid page param: {0}", pageParam);
        }
        int offset = (pageNumber - 1) * pageSize;

        // Xử lý sortColumn và sortOrder
        if (sortColumn == null || sortColumn.trim().isEmpty() || !validColumns.contains(sortColumn)) {
            sortColumn = "ID_KhoaHoc"; // Mặc định sắp xếp theo ID
        }
        if (sortOrder == null || (!sortOrder.equalsIgnoreCase("asc") && !sortOrder.equalsIgnoreCase("desc"))) {
            sortOrder = "asc"; // Mặc định sắp xếp tăng dần
        }

        // Xử lý sortName (lọc trạng thái)
        String statusFilter = null;
        if ("ASCTrang".equalsIgnoreCase(sortName)) {
            statusFilter = "active";
        } else if ("DESCTrang".equalsIgnoreCase(sortName)) {
            statusFilter = "inactive";
        }

        // Chuẩn hóa name
        if (name != null && !name.trim().isEmpty()) {
            name = name.trim().replaceAll("\\s+", " ");
        }

        List<KhoaHoc> khoaHocList;
        int totalCourses;

        // Xử lý logic dựa trên action
        if ("refresh".equalsIgnoreCase(action)) {
            name = null;
            sortName = null;
            statusFilter = null;
            sortColumn = "ID_KhoaHoc";
            sortOrder = "asc";
            pageNumber = 1;
            offset = 0;
            khoaHocList = dao.getCoursesSortedPaged(sortColumn, sortOrder, name, statusFilter, pageNumber, pageSize);
            totalCourses = dao.countCourses(name, statusFilter);
        } else if ("search".equalsIgnoreCase(action)) {
            khoaHocList = dao.getCoursesSortedPaged(sortColumn, sortOrder, name, statusFilter, pageNumber, pageSize);
            totalCourses = dao.countCourses(name, statusFilter);
        } else if ("filterStatus".equalsIgnoreCase(action)) {
            khoaHocList = dao.getCoursesSortedPaged(sortColumn, sortOrder, name, statusFilter, pageNumber, pageSize);
            totalCourses = dao.countCourses(name, statusFilter);
        } else if ("sort".equalsIgnoreCase(action)) {
            khoaHocList = dao.getCoursesSortedPaged(sortColumn, sortOrder, name, statusFilter, pageNumber, pageSize);
            totalCourses = dao.countCourses(name, statusFilter);
        } else if ("paginate".equalsIgnoreCase(action)) {
            khoaHocList = dao.getCoursesSortedPaged(sortColumn, sortOrder, name, statusFilter, pageNumber, pageSize);
            totalCourses = dao.countCourses(name, statusFilter);
        } else if ("deleteCourse".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
                Logger.getLogger(ManageCourse.class.getName()).log(Level.INFO, "Delete action for ID_KhoaHoc: {0}", id);
                KhoaHoc khoaHoc = dao.getKhoaHocById(id);

                if (khoaHoc == null) {
                    Logger.getLogger(ManageCourse.class.getName()).log(Level.WARNING, "KhoaHoc with ID {0} not found", id);
                    response.sendRedirect(request.getContextPath() + "/views/admin/manageCourses.jsp?message=notFound");
                    return;
                }

                String trangThai = khoaHoc.getTrangThai();
                LocalDate ketThuc = khoaHoc.getThoiGianKetThuc();
                LocalDate today = LocalDate.now();

                Logger.getLogger(ManageCourse.class.getName()).log(Level.INFO, "KhoaHoc status: {0}, End date: {1}, Today: {2}", new Object[]{trangThai, ketThuc, today});
                if ("Inactive".equalsIgnoreCase(trangThai)
                        || ("Active".equalsIgnoreCase(trangThai) && ketThuc != null && ketThuc.isBefore(today))) {
                    KhoaHoc deleted = dao.deleteKhoaHoc(khoaHoc);
                    if (deleted != null) {
                        Logger.getLogger(ManageCourse.class.getName()).log(Level.INFO, "KhoaHoc with ID {0} deleted successfully", id);
                        request.setAttribute("suc", "Xóa khóa học với ID " + id + " thành công!");
                        // Cập nhật danh sách khóa học với trạng thái hiện tại
                        khoaHocList = dao.getCoursesSortedPaged(sortColumn, sortOrder, name, statusFilter, pageNumber, pageSize);
                        totalCourses = dao.countCourses(name, statusFilter);
                        int totalPages = totalCourses > 0 ? (int) Math.ceil((double) totalCourses / pageSize) : 1;
                        request.setAttribute("list", khoaHocList);
                        request.setAttribute("pageNumber", pageNumber);
                        request.setAttribute("totalPages", totalPages);
                        request.setAttribute("totalCourses", totalCourses);
                        request.setAttribute("sortColumn", sortColumn);
                        request.setAttribute("sortOrder", sortOrder);
                        request.setAttribute("sortName", sortName);
                        request.setAttribute("name", name);
                        request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
                    } else {
                        Logger.getLogger(ManageCourse.class.getName()).log(Level.WARNING, "Failed to delete KhoaHoc with ID {0}", id);
                        request.setAttribute("err", "Xóa thất bại! Có thể do ràng buộc dữ liệu.");
                        // Cập nhật danh sách khóa học với trạng thái hiện tại
                        khoaHocList = dao.getCoursesSortedPaged(sortColumn, sortOrder, name, statusFilter, pageNumber, pageSize);
                        totalCourses = dao.countCourses(name, statusFilter);
                        int totalPages = totalCourses > 0 ? (int) Math.ceil((double) totalCourses / pageSize) : 1;
                        request.setAttribute("list", khoaHocList);
                        request.setAttribute("pageNumber", pageNumber);
                        request.setAttribute("totalPages", totalPages);
                        request.setAttribute("totalCourses", totalCourses);
                        request.setAttribute("sortColumn", sortColumn);
                        request.setAttribute("sortOrder", sortOrder);
                        request.setAttribute("sortName", sortName);
                        request.setAttribute("name", name);
                        request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("err", "Không thể xóa khóa học vì trạng thái không phù hợp! (Chỉ được xóa khi Inactive hoặc đã kết thúc)");
                    // Cập nhật danh sách khóa học với trạng thái hiện tại
                    khoaHocList = dao.getCoursesSortedPaged(sortColumn, sortOrder, name, statusFilter, pageNumber, pageSize);
                    totalCourses = dao.countCourses(name, statusFilter);
                    int totalPages = totalCourses > 0 ? (int) Math.ceil((double) totalCourses / pageSize) : 1;
                    request.setAttribute("list", khoaHocList);
                    request.setAttribute("pageNumber", pageNumber);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("totalCourses", totalCourses);
                    request.setAttribute("sortColumn", sortColumn);
                    request.setAttribute("sortOrder", sortOrder);
                    request.setAttribute("sortName", sortName);
                    request.setAttribute("name", name);
                    request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                Logger.getLogger(ManageCourse.class.getName()).log(Level.SEVERE, "Invalid ID_KhoaHoc: {0}", request.getParameter("ID_KhoaHoc"));
                request.setAttribute("err", "ID khóa học không hợp lệ!");
                // Cập nhật danh sách khóa học với trạng thái hiện tại
                khoaHocList = dao.getCoursesSortedPaged(sortColumn, sortOrder, name, statusFilter, pageNumber, pageSize);
                totalCourses = dao.countCourses(name, statusFilter);
                int totalPages = totalCourses > 0 ? (int) Math.ceil((double) totalCourses / pageSize) : 1;
                request.setAttribute("list", khoaHocList);
                request.setAttribute("pageNumber", pageNumber);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("totalCourses", totalCourses);
                request.setAttribute("sortColumn", sortColumn);
                request.setAttribute("sortOrder", sortOrder);
                request.setAttribute("sortName", sortName);
                request.setAttribute("name", name);
                request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
            }
            return;
        } else if ("ViewCourse".equalsIgnoreCase(action)) {
            try {

                String idKhoaStr = request.getParameter("ID_KhoaHoc");
                String idKhoiStr = request.getParameter("ID_Khoi");
                if (idKhoaStr == null || idKhoiStr == null || idKhoaStr.trim().isEmpty() || idKhoiStr.trim().isEmpty()) {
                    request.setAttribute("err", "Thiếu hoặc không hợp lệ tham số ID_KhoaHoc hoặc ID_Khoi.");
                    request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
                    return;
                }

                int idKhoaHoc = Integer.parseInt(idKhoaStr);
                int idKhoi = Integer.parseInt(idKhoiStr);

                // Lưu ID_KhoaHoc và ID_Khoi làm attribute để JSP sử dụng
                request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                request.setAttribute("ID_Khoi", idKhoi);
                LopHocDAO lhd = new LopHocDAO();

                String pageStr = request.getParameter("page"); // Khai báo pageStr
                try {
                    if (pageStr != null && !pageStr.trim().isEmpty()) {
                        pageNumber = Integer.parseInt(pageStr);
                        if (pageNumber < 1) {
                            pageNumber = 1;
                        }
                    }
                } catch (NumberFormatException e) {
                    pageNumber = 1;
                    Logger.getLogger(ManageCourse.class.getName()).log(Level.WARNING, "Invalid page param for ViewCourse: {0}", pageStr);
                }

                List<LopHoc> danhSachLopHoc = lhd.getLopHocByKhoaHocAndKhoi(idKhoaHoc, idKhoi, pageNumber, pageSize);
                if (danhSachLopHoc.isEmpty() || danhSachLopHoc == null) {
                    request.setAttribute("err", "Chưa có lớp học nào được khởi tạo");
                }
                int totalItems = lhd.countClasses(null, idKhoaHoc, idKhoi);
                int totalPages = (int) Math.ceil((double) totalItems / pageSize);

                request.setAttribute("danhSachLopHoc", danhSachLopHoc);
                request.setAttribute("totalItems", totalItems);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("pageNumber", pageNumber);

                request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                request.setAttribute("err", "ID_KhoaHoc hoặc ID_Khoi không hợp lệ!");
                request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(ManageCourse.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("err", "Lỗi truy vấn cơ sở dữ liệu!");
                request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
            }
            return;
        } else if ("addKhoaHoc".equals(action)) {
            try {
                String ten = request.getParameter("TenKhoaHoc");
                String moTa = request.getParameter("MoTa");
                String batDauStr = request.getParameter("ThoiGianBatDau");
                String ketThucStr = request.getParameter("ThoiGianKetThuc");
                String ghiChu = request.getParameter("GhiChu");
                String ID_Khoi = request.getParameter("ID_Khoi");

                // Kiểm tra ID_Khoi có nhập và đúng định dạng số hay không
                int id_khoi = -1;
                try {
                    if (ID_Khoi == null || ID_Khoi.trim().isEmpty()) {
                        request.setAttribute("err", "Vui lòng nhập ID khối học.");
                        request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                        return;
                    }
                    id_khoi = Integer.parseInt(ID_Khoi.trim());
                } catch (NumberFormatException e) {
                    request.setAttribute("err", "ID khối học phải là số nguyên hợp lệ.");
                    request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                    return;
                }

                String trangThai = "Inactive";

                // Nếu là khóa tổng ôn thì ID_Khoi bắt buộc phải là 8
                if (ten != null && ten.startsWith("Khóa tổng ôn ") && id_khoi != 8) {
                    request.setAttribute("err", "Khóa tổng ôn chỉ áp dụng cho khối 8!");
                    request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra trùng tên + ID_Khoi
                if (KhoaHocDAO.isDuplicateTenKhoaHocAndIDKhoi(ten, id_khoi)) {
                    request.setAttribute("err", "Tên khóa học đã tồn tại trong cùng khối học!");
                    request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                    return;
                }

                LocalDate batDau = (batDauStr != null && !batDauStr.isEmpty()) ? LocalDate.parse(batDauStr) : null;
                LocalDate ketThuc = (ketThucStr != null && !ketThucStr.isEmpty()) ? LocalDate.parse(ketThucStr) : null;
                LocalDate today = LocalDate.now();

                if (batDau != null && batDau.isBefore(today)) {
                    request.setAttribute("err", "Ngày bắt đầu không được ở trong quá khứ!");
                    request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                    return;
                }

                if (batDau != null && ketThuc != null && !ketThuc.isAfter(batDau.plusDays(29))) {
                    request.setAttribute("err", "Ngày kết thúc phải sau ngày bắt đầu ít nhất 30 ngày!");
                    request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                    return;
                }

                // Tạo đối tượng KhoaHoc
                KhoaHoc khoaHoc = new KhoaHoc(null, ten, moTa, batDau, ketThuc, ghiChu, trangThai, LocalDateTime.now(), id_khoi);

                KhoaHoc result = dao.addKhoaHoc(khoaHoc);

                if (result != null) {
                    request.setAttribute("suc", "Thêm khóa học thành công!");
                } else {
                    request.setAttribute("err", "Thêm khóa học thất bại! Thiếu thông tin");
                }
            } catch (Exception e) {
                Logger.getLogger(ManageCourse.class.getName()).log(Level.SEVERE, null, e);
                request.setAttribute("err", "Lỗi: " + e.getMessage());
            }

            request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
            return;
        }
        if ("updateCourse".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
                KhoaHoc khoaHoc = dao.getKhoaHocById(id);

                if (khoaHoc == null) {
                    response.sendRedirect(request.getContextPath() + "/views/admin/manageCourses.jsp?message=notFound");
                    return;
                }

                String trangThai = khoaHoc.getTrangThai();
                LocalDate ketThuc = khoaHoc.getThoiGianKetThuc();
                LocalDate today = LocalDate.now();

                // Cho phép cập nhật nếu:
                // - Trạng thái là Inactive
                // - hoặc trạng thái là Active nhưng khóa học đã kết thúc
                if ("Inactive".equalsIgnoreCase(trangThai)
                        || ("Active".equalsIgnoreCase(trangThai) && ketThuc != null && ketThuc.isBefore(today))) {
                    request.setAttribute("khoaHoc", khoaHoc);
                    request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                } else {
                    request.setAttribute("err", "Không thể cập nhật khóa học vì trạng thái không phù hợp! (Chỉ được cập nhật khi khóa học ở trạng thái Inactive hoặc đã kết thúc!)");
                    khoaHocList = dao.getCoursesSortedPaged(sortColumn, sortOrder, name, statusFilter, pageNumber, pageSize);
                    totalCourses = dao.countCourses(name, statusFilter);
                    int totalPages = totalCourses > 0 ? (int) Math.ceil((double) totalCourses / pageSize) : 1;
                    request.setAttribute("list", khoaHocList);
                    request.setAttribute("pageNumber", pageNumber);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("totalCourses", totalCourses);
                    request.setAttribute("sortColumn", sortColumn);
                    request.setAttribute("sortOrder", sortOrder);
                    request.setAttribute("sortName", sortName);
                    request.setAttribute("name", name);
                    request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("err", "ID khóa học không hợp lệ!");
                request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
            }
            return;
        } else {
            khoaHocList = dao.getCoursesSortedPaged(sortColumn, sortOrder, name, statusFilter, pageNumber, pageSize);
            totalCourses = dao.countCourses(name, statusFilter);
        }

        // Xử lý lỗi
        if (khoaHocList == null || khoaHocList.isEmpty()) {
            request.setAttribute("err", "Không tìm thấy khóa học phù hợp.");
            // Thử lấy tất cả khóa học để debug
            List<KhoaHoc> allCourses = dao.getCoursesSortedPaged("ID_KhoaHoc", "asc", null, null, 1, pageSize);
            int allCoursesCount = dao.countCourses(null, null);
            if (allCourses != null && !allCourses.isEmpty()) {
                khoaHocList = allCourses;
                totalCourses = allCoursesCount;
                request.setAttribute("err", "Không tìm thấy khóa học với bộ lọc hiện tại. Có " + allCoursesCount + " khóa học trong bảng.");
            }
        }

        // Tính tổng số trang
        int totalPages = totalCourses > 0 ? (int) Math.ceil((double) totalCourses / pageSize) : 1;

        // Đặt thuộc tính cho JSP
        request.setAttribute("list", khoaHocList);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCourses", totalCourses);
        request.setAttribute("sortColumn", sortColumn);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("sortName", sortName);
        request.setAttribute("name", name);
        request.setAttribute("action", action);

        // Log các thuộc tính trước khi forward
        Logger.getLogger(ManageCourse.class.getName()).log(Level.INFO, "Attributes set: list size={0}, pageNumber={1}, totalPages={2}, totalCourses={3}, sortColumn={4}, sortOrder={5}, sortName={6}, name={7}, action={8}",
                new Object[]{khoaHocList != null ? khoaHocList.size() : 0, pageNumber, totalPages, totalCourses, sortColumn, sortOrder, sortName, name, action});

        // Chuyển tiếp đến JSP
        request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("submitUpdateCourse".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
                String ten = request.getParameter("TenKhoaHoc");
                String moTa = request.getParameter("MoTa");
                String batDauStr = request.getParameter("ThoiGianBatDau");
                String ketThucStr = request.getParameter("ThoiGianKetThuc");
                LocalDate batDau = (batDauStr != null && !batDauStr.isEmpty()) ? LocalDate.parse(batDauStr) : null;
                LocalDate ketThuc = (ketThucStr != null && !ketThucStr.isEmpty()) ? LocalDate.parse(ketThucStr) : null;
                String ghiChu = request.getParameter("GhiChu");
                String trangThai = request.getParameter("TrangThai");
                String ID_Khoi = request.getParameter("ID_Khoi");
                int id_khoi = Integer.parseInt(ID_Khoi);

                // Lấy khóa học cũ
                KhoaHocDAO dao = new KhoaHocDAO();
                KhoaHoc khoaHocCu = dao.getKhoaHocById(id);

                // Kiểm tra tên khóa học hợp lệ
                // Kiểm tra khóa tổng ôn phải thuộc khối 8
                if (ten != null && ten.startsWith("Khóa tổng ôn ") && id_khoi != 8) {
                    request.setAttribute("err", "Khóa tổng ôn chỉ áp dụng cho khối 8!");
                    request.setAttribute("khoaHoc", khoaHocCu);
                    request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                    return;
                }

                if (batDau != null && batDau.isBefore(LocalDate.now())) {
                    request.setAttribute("err", "Ngày bắt đầu không được ở trong quá khứ!");
                    request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra trùng tên và ID_Khoi
                if ((!ten.equalsIgnoreCase(khoaHocCu.getTenKhoaHoc()) || id_khoi != khoaHocCu.getID_Khoi())
                        && dao.isDuplicateTenKhoaHocAndIDKhoi(ten, id_khoi)) {
                    request.setAttribute("err", "Tên khóa học đã tồn tại với Khối học này!");
                    request.setAttribute("khoaHoc", khoaHocCu);
                    request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra trạng thái
                if (!trangThai.equalsIgnoreCase("Active") && !trangThai.equalsIgnoreCase("Inactive")) {
                    request.setAttribute("err", "Nhập lại trạng thái của khóa học (Active - Inactive)");
                    request.setAttribute("khoaHoc", khoaHocCu);
                    request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra ngày kết thúc
                if (batDau != null && ketThuc != null && !ketThuc.isAfter(batDau.plusDays(29))) {
                    request.setAttribute("err", "Ngày kết thúc phải sau ngày bắt đầu ít nhất 30 ngày!");
                    request.setAttribute("khoaHoc", khoaHocCu);
                    request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                    return;
                }

                if (!ten.matches("^[\\p{L}0-9\\s\\-]+$")) {
                    request.setAttribute("err", "Tên khóa học chỉ được chứa chữ, số và khoảng trắng.");
                    request.setAttribute("khoaHoc", khoaHocCu);
                    request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                    return;
                }

                // Tạo đối tượng khóa học mới
                KhoaHoc khoaHoc = new KhoaHoc(id, ten, moTa, batDau, ketThuc, ghiChu, trangThai, LocalDateTime.now(), id_khoi);

                // Cập nhật vào DB
                KhoaHoc khoaHocUpdated = dao.updateKhoaHoc(khoaHoc);

                if (khoaHocUpdated != null) {
                    request.setAttribute("suc", "Cập nhật thành công");
                    request.setAttribute("khoaHoc", khoaHocUpdated);
                } else {
                    request.setAttribute("err", "Cập nhật thất bại");
                    request.setAttribute("khoaHoc", khoaHoc);
                }

                request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
            } catch (Exception e) {
                Logger.getLogger(ManageCourse.class.getName()).log(Level.SEVERE, null, e);
                request.setAttribute("err", "Có lỗi xảy ra: " + e.getMessage());
                request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
            }
        } else {
            doGet(request, response); // Gọi doGet cho các action khác
        }
    }

    /**
     * Kiểm tra tên khóa học có hợp lệ không
     */
    private boolean isTenKhoaHocHopLe(String ten) {
        if (ten == null) {
            return false;
        }
        return TEN_MON_HOC_HOP_LE.stream()
                .anyMatch(mon -> mon.equalsIgnoreCase(ten.trim()));
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to manage course listing, sorting, pagination, and actions";
    }
}
