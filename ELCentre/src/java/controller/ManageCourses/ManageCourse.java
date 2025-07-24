/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ManageCourses;

import dal.GiaoVienDAO;
import dal.KhoaHocDAO;
import dal.LichHocDAO;
import dal.LopHocDAO;
import dal.LopHocInfoDTODAO;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.UUID;
import model.GiaoVien;
import model.KhoaHoc;
import model.LichHoc;
import model.LopHoc;
import java.text.Normalizer;
import model.LopHocInfoDTO;

/**
 * Servlet to manage course listing, sorting, pagination, and actions.
 *
 * @author Vuh26
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ManageCourse extends HttpServlet {

    // Danh sách tên môn học hợp lệ
    static final List<String> TEN_MON_HOC_HOP_LE = Stream.concat(
            Arrays.asList(
                    "Toán", "Ngữ văn", "Vật lý", "Hóa học", "Sinh học",
                    "Tin học", "Lịch sử", "Địa lý", "Giáo dục công dân",
                    "Tiếng Anh", "Công nghệ", "Thể dục", "Âm nhạc", "Mỹ thuật",
                    "Quốc phòng và An ninh"
            ).stream(),
            Arrays.asList(
                    "Toán", "Ngữ văn", "Vật lý", "Hóa học", "Sinh học",
                    "Tin học", "Lịch sử", "Địa lý", "Giáo dục công dân",
                    "Tiếng Anh", "Công nghệ", "Thể dục", "Âm nhạc", "Mỹ thuật",
                    "Quốc phòng và An ninh"
            ).stream().map(tenMon -> "Khóa tổng ôn " + tenMon)
    ).collect(Collectors.toList());

    /**
     * Loại bỏ dấu tiếng Việt từ chuỗi.
     *
     * @param str Chuỗi đầu vào
     * @return Chuỗi đã loại bỏ dấu
     */
    private String removeDiacritics(String str) {
        return Normalizer.normalize(str, Normalizer.Form.NFD).replaceAll("[\\p{M}]", "");
    }

    /**
     * Sinh mã khóa học dựa trên tên môn học và ID khối học.
     *
     * @param tenKhoaHoc Tên khóa học
     * @param idKhoi ID khối học
     * @return Mã khóa học (CourseCode)
     */
    private String generateCourseCode(String tenKhoaHoc, int idKhoi) {
        if (tenKhoaHoc == null || tenKhoaHoc.trim().isEmpty()) {
            return null;
        }
        tenKhoaHoc = tenKhoaHoc.trim();
        if (tenKhoaHoc.startsWith("Khóa tổng ôn ")) {
            String subject = tenKhoaHoc.replace("Khóa tổng ôn ", "");
            subject = removeDiacritics(subject).toUpperCase();
            return "TONG" + subject.replaceAll("\\s", "");
        } else {
            String prefix = removeDiacritics(tenKhoaHoc).length() >= 3
                    ? removeDiacritics(tenKhoaHoc).substring(0, 3).toUpperCase()
                    : removeDiacritics(tenKhoaHoc).toUpperCase();
            String khoiStr = String.format("%02d", idKhoi + 5);
            return prefix + khoiStr;
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
     * Thiết lập các thuộc tính cho danh sách khóa học
     */
    private void setCourseListAttributes(HttpServletRequest request, List<KhoaHoc> khoaHocList, int totalCourses,
            int pageNumber, String sortColumn, String sortOrder, String statusFilter,
            String khoiFilter, String orderFilter, String startDate, String endDate, String name) {
        int pageSize = 15;
        int totalPages = totalCourses > 0 ? (int) Math.ceil((double) totalCourses / pageSize) : 1;
        request.setAttribute("list", khoaHocList);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCourses", totalCourses);
        request.setAttribute("sortColumn", sortColumn);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("khoiFilter", khoiFilter);
        request.setAttribute("orderFilter", orderFilter);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("name", name);
        request.setAttribute("action", "filterByStatusAndName");
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageCourse</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageCourse at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Handles the HTTP <code>GET</code> method.
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
                "ID_KhoaHoc", "CourseCode", "TenKhoaHoc", "MoTa", "ThoiGianBatDau",
                "ThoiGianKetThuc", "GhiChu", "TrangThai", "NgayTao", "ID_Khoi", "Order"
        );

        // Lấy tham số từ request
        String name = request.getParameter("name");
        String statusFilter = request.getParameter("statusFilter");
        String khoiFilter = request.getParameter("khoiFilter");
        String orderFilter = request.getParameter("orderFilter");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String sortColumn = request.getParameter("sortColumn");
        String sortOrder = request.getParameter("sortOrder");
        String pageParam = request.getParameter("page");

        // Xử lý phân trang
        int pageSize = 15;
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
        }
        int offset = (pageNumber - 1) * pageSize;

        // Xử lý sortColumn và sortOrder
        if (sortColumn == null || sortColumn.trim().isEmpty() || !validColumns.contains(sortColumn)) {
            sortColumn = "ID_KhoaHoc";
        }
        if (sortOrder == null || (!sortOrder.equalsIgnoreCase("asc") && !sortOrder.equalsIgnoreCase("desc"))) {
            sortOrder = "asc";
        }

        // Chuẩn hóa name
        if (name != null && !name.trim().isEmpty()) {
            name = name.trim().replaceAll("\\s+", " ");
        } else {
            name = "";
        }

        // Chuẩn hóa khoiFilter
        Integer idKhoi = null;
        if (khoiFilter != null && !khoiFilter.trim().isEmpty()) {
            try {
                idKhoi = Integer.parseInt(khoiFilter);
            } catch (NumberFormatException e) {
                idKhoi = null;
            }
        }

        // Chuẩn hóa orderFilter
        Integer order = null;
        if (orderFilter != null && !orderFilter.trim().isEmpty()) {
            try {
                order = Integer.parseInt(orderFilter);
            } catch (NumberFormatException e) {
                order = null;
            }
        }

        // Chuẩn hóa ngày
        LocalDate start = null;
        LocalDate end = null;
        try {
            if (startDate != null && !startDate.trim().isEmpty()) {
                start = LocalDate.parse(startDate);
            }
            if (endDate != null && !endDate.trim().isEmpty()) {
                end = LocalDate.parse(endDate);
            }
        } catch (Exception e) {
            start = null;
            end = null;
        }

        // Ánh xạ trạng thái từ giao diện sang cơ sở dữ liệu
        String dbStatusFilter = statusFilter;
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            switch (statusFilter) {
                case "Đang hoạt động":
                    dbStatusFilter = "Đang hoạt động";
                    break;
                case "Chưa hoạt động":
                    dbStatusFilter = "Chưa hoạt động";
                    break;
                case "Chưa bắt đầu":
                    dbStatusFilter = "Chưa bắt đầu";
                    break;
                case "Đã kết thúc":
                    dbStatusFilter = "Đã kết thúc";
                    break;
                default:
                    dbStatusFilter = "";
                    break;
            }
        }

        List<KhoaHoc> khoaHocList = null;
        int totalCourses = 0;

        // Xử lý logic dựa trên action
        try {
            if ("refresh".equalsIgnoreCase(action)) {
                name = "";
                statusFilter = "";
                dbStatusFilter = "";
                khoiFilter = "";
                orderFilter = "";
                startDate = "";
                endDate = "";
                sortColumn = "ID_KhoaHoc";
                sortOrder = "asc";
                pageNumber = 1;
                offset = 0;
                khoaHocList = dao.getCoursesByFilters("", "", null, null, null, null, offset, pageSize);
                totalCourses = dao.getTotalCoursesByFilters("", "", null, null, null, null);
            } else if ("filterByStatusAndName".equalsIgnoreCase(action)) {
                khoaHocList = dao.getCoursesByFilters(name, dbStatusFilter, idKhoi, order, start, end, offset, pageSize);
                totalCourses = dao.getTotalCoursesByFilters(name, dbStatusFilter, idKhoi, order, start, end);
            } else if ("sort".equalsIgnoreCase(action)) {
                khoaHocList = dao.getCoursesSortedPaged(sortColumn, sortOrder, name, dbStatusFilter, idKhoi, order, start, end, pageNumber, pageSize);
                totalCourses = dao.getTotalCoursesByFilters(name, dbStatusFilter, idKhoi, order, start, end);
            } else if ("paginate".equalsIgnoreCase(action)) {
                khoaHocList = dao.getCoursesByFilters(name, dbStatusFilter, idKhoi, order, start, end, offset, pageSize);
                totalCourses = dao.getTotalCoursesByFilters(name, dbStatusFilter, idKhoi, order, start, end);
            } else if ("deleteCourse".equalsIgnoreCase(action)) {
                try {
                    int id = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
                    KhoaHoc khoaHoc = dao.getKhoaHocById(id);
                    if (khoaHoc == null) {
                        request.setAttribute("err", "Không tìm thấy khóa học với ID: " + id);
                    } else {
                        String trangThai = khoaHoc.getTrangThai();
                        LocalDate ketThuc = khoaHoc.getThoiGianKetThuc();
                        LocalDate today = LocalDate.now();

                        if ("Chưa bắt đầu".equalsIgnoreCase(trangThai) || "Đã kết thúc".equalsIgnoreCase(trangThai)
                                || ("Đang hoạt động".equalsIgnoreCase(trangThai) && ketThuc != null && ketThuc.isBefore(today))) {
                            KhoaHoc deleted = dao.deleteKhoaHoc(khoaHoc);
                            if (deleted != null) {
                                request.setAttribute("suc", "Xóa khóa học với ID " + id + " thành công!");
                            } else {
                                request.setAttribute("err", "Xóa thất bại! Có thể do ràng buộc dữ liệu.");
                            }
                        } else {
                            request.setAttribute("err", "Không thể xóa khóa học vì trạng thái không phù hợp! (Chỉ được xóa khi Chưa hoạt động, Chưa bắt đầu hoặc đã kết thúc)");
                        }
                    }
                    khoaHocList = dao.getCoursesByFilters(name, dbStatusFilter, idKhoi, order, start, end, offset, pageSize);
                    totalCourses = dao.getTotalCoursesByFilters(name, dbStatusFilter, idKhoi, order, start, end);
                    int totalPages = totalCourses > 0 ? (int) Math.ceil((double) totalCourses / pageSize) : 1;
                    setCourseListAttributes(request, khoaHocList, totalCourses, pageNumber, sortColumn, sortOrder,
                            statusFilter, khoiFilter, orderFilter, startDate, endDate, name);
                    request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
                    return;
                } catch (NumberFormatException e) {
                    request.setAttribute("err", "ID khóa học không hợp lệ!");
                    khoaHocList = dao.getCoursesByFilters(name, dbStatusFilter, idKhoi, order, start, end, offset, pageSize);
                    totalCourses = dao.getTotalCoursesByFilters(name, dbStatusFilter, idKhoi, order, start, end);
                }
            } else if ("ViewCourse".equalsIgnoreCase(action)) {
                try {
                    String idKhoiStr = request.getParameter("ID_Khoi");
                    String idKhoaStr = request.getParameter("ID_KhoaHoc");

                    if (idKhoiStr == null || idKhoiStr.trim().isEmpty() || idKhoaStr == null || idKhoaStr.trim().isEmpty()) {
                        request.setAttribute("err", "Thiếu hoặc không hợp lệ tham số ID_KhoaHoc hoặc ID_Khoi.");
                        request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
                        return;
                    }

                    idKhoi = Integer.parseInt(idKhoiStr);
                    int idKhoaHoc = Integer.parseInt(idKhoaStr);
                    LopHocInfoDTODAO lopHocDAO = new LopHocInfoDTODAO();
                    GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
                    KhoaHoc khoaHoc = dao.getKhoaHocById(idKhoaHoc);

                    if (khoaHoc == null || khoaHoc.getID_Khoi() != idKhoi) {
                        request.setAttribute("err", "Khóa học không tồn tại hoặc ID_Khoi không khớp!");
                        request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
                        return;
                    }

                    String searchQuery = request.getParameter("searchQuery");
                    String sortName = request.getParameter("sortName");
                    String teacherFilter = request.getParameter("teacherFilter");
                    String feeFilter = request.getParameter("feeFilter");
                    orderFilter = request.getParameter("orderFilter");
                    sortColumn = request.getParameter("sortColumn");
                    sortOrder = request.getParameter("sortOrder");
                    pageNumber = 1;
                    pageSize = 10;

                    try {
                        if (request.getParameter("page") != null && !request.getParameter("page").trim().isEmpty()) {
                            pageNumber = Integer.parseInt(request.getParameter("page"));
                            if (pageNumber < 1) {
                                pageNumber = 1;
                            }
                        }
                    } catch (NumberFormatException e) {
                        pageNumber = 1;
                    }

                    // Sử dụng hàm getLopHocInfoList để lấy danh sách lớp học với các bộ lọc
                    List<LopHocInfoDTO> danhSachLopHoc = lopHocDAO.getLopHocInfoList(searchQuery, sortName, pageNumber, pageSize, idKhoaHoc, idKhoi, sortColumn, sortOrder, teacherFilter, feeFilter, orderFilter);
                    int totalItems = lopHocDAO.countClasses(searchQuery, sortName, idKhoaHoc, idKhoi, teacherFilter, feeFilter, orderFilter);
                    int totalPages = (int) Math.ceil((double) totalItems / pageSize);

                    // Lấy danh sách giáo viên dựa trên chuyên môn của khóa học
                    List<GiaoVien> teacherList = giaoVienDAO.getTeachersBySpecialization(khoaHoc.getTenKhoaHoc());
                    if (teacherList == null || teacherList.isEmpty()) {
                        request.setAttribute("err", "Không có giáo viên nào có chuyên môn phù hợp với khóa học.");
                    }

                    // Đặt các thuộc tính vào request để gửi tới JSP
                    request.setAttribute("danhSachLopHoc", danhSachLopHoc);
                    request.setAttribute("totalItems", totalItems);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("page", pageNumber);
                    request.setAttribute("sortColumn", sortColumn);
                    request.setAttribute("sortOrder", sortOrder);
                    request.setAttribute("searchQuery", searchQuery);
                    request.setAttribute("sortName", sortName);
                    request.setAttribute("teacherFilter", teacherFilter);
                    request.setAttribute("feeFilter", feeFilter);
                    request.setAttribute("orderFilter", orderFilter);
                    request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                    request.setAttribute("ID_Khoi", idKhoi);
                    request.setAttribute("teacherList", teacherList);

                    if (danhSachLopHoc.isEmpty()) {
                        request.setAttribute("err", "Chưa có lớp học nào được khởi tạo cho khóa học này.");
                    }


                    request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
                    return;
                } catch (NumberFormatException e) {
                    request.setAttribute("err", "ID_KhoaHoc hoặc ID_Khoi không hợp lệ!");
                    e.printStackTrace();
                    request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
                    return;
                } catch (Exception e) {
                    request.setAttribute("err", "Lỗi xử lý yêu cầu: " + e.getMessage());
                    e.printStackTrace();
                    request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
                    return;
                }
            } else if ("updateCourse".equalsIgnoreCase(action)) {
                try {
                    int id = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
                    KhoaHoc khoaHoc = dao.getKhoaHocById1(id);

                    if (khoaHoc == null) {
                        request.setAttribute("err", "Không tìm thấy khóa học với ID: " + id);
                        request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
                        return;
                    }

                    request.setAttribute("khoaHoc", khoaHoc);
                    request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                    return;
                } catch (NumberFormatException e) {
                    request.setAttribute("err", "ID khóa học không hợp lệ!");
                    request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
                    return;
                }
            } else {
                // Mặc định hiển thị tất cả khóa học
                khoaHocList = dao.getCoursesByFilters("", "", null, null, null, null, offset, pageSize);
                totalCourses = dao.getTotalCoursesByFilters("", "", null, null, null, null);
            }

            if (khoaHocList == null) {
                request.setAttribute("err", "Không thể lấy danh sách khóa học từ cơ sở dữ liệu.");
                khoaHocList = new ArrayList<>();
                totalCourses = 0;
            } else if (khoaHocList.isEmpty()) {
                request.setAttribute("err", "Không tìm thấy khóa học nào phù hợp với bộ lọc.");
            }

            int totalPages = totalCourses > 0 ? (int) Math.ceil((double) totalCourses / pageSize) : 1;

            setCourseListAttributes(request, khoaHocList, totalCourses, pageNumber, sortColumn, sortOrder,
                    statusFilter, khoiFilter, orderFilter, startDate, endDate, name);
            request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addKhoaHoc".equals(action)) {
            try {
                String ten = request.getParameter("TenKhoaHoc");
                String moTa = request.getParameter("MoTa");
                String batDauStr = request.getParameter("ThoiGianBatDau");
                String ketThucStr = request.getParameter("ThoiGianKetThuc");
                String ghiChu = request.getParameter("GhiChu");
                String ID_Khoi = request.getParameter("ID_Khoi");
                String orderStr = request.getParameter("Order");
                Part imagePart = request.getPart("Image");

                if (ten == null || ten.trim().isEmpty()) {
                    request.setAttribute("err", "Vui lòng nhập tên khóa học.");
                    request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                    return;
                }
                ten = ten.trim();
                if (!ten.matches("^[\\p{L}0-9\\s]+$")) {
                    request.setAttribute("err", "Tên khóa học chỉ được chứa chữ, số và khoảng trắng.");
                    request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                    return;
                }
                if (!isTenKhoaHocHopLe(ten)) {
                    request.setAttribute("err", "Tên khóa học không hợp lệ. Phải thuộc danh sách môn học cho phép.");
                    request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                    return;
                }

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

                if (ten.startsWith("Khóa tổng ôn ") && id_khoi != 8) {
                    request.setAttribute("err", "Khóa tổng ôn chỉ áp dụng cho khối 8!");
                    request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                    return;
                }

                KhoaHocDAO dao = new KhoaHocDAO();
                if (dao.isDuplicateTenKhoaHocAndIDKhoi(ten, id_khoi)) {
                    request.setAttribute("err", "Tên khóa học đã tồn tại trong cùng khối học!");
                    request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                    return;
                }

                String courseCode = generateCourseCode(ten, id_khoi);
                if (courseCode == null || courseCode.length() > 20 || !courseCode.matches("^[A-Za-z0-9]+$")) {
                    request.setAttribute("err", "Mã khóa học không hợp lệ, quá dài hoặc chứa ký tự không cho phép!");
                    request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                    return;
                }

                if (dao.isDuplicateCourseCode(courseCode)) {
                    request.setAttribute("err", "Mã khóa học " + courseCode + " đã tồn tại!");
                    request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                    return;
                }

                int order = 0;
                if (orderStr != null && !orderStr.trim().isEmpty()) {
                    try {
                        order = Integer.parseInt(orderStr);
                        if (order < 0) {
                            request.setAttribute("err", "Thứ tự phải là số không âm.");
                            request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                            return;
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("err", "Thứ tự phải là số nguyên hợp lệ.");
                        request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                        return;
                    }
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

                String imagePath = null;
                if (imagePart != null && imagePart.getSize() > 0) {
                    String contentType = imagePart.getContentType();
                    if (!contentType.equals("image/jpeg") && !contentType.equals("image/png")) {
                        request.setAttribute("err", "Chỉ chấp nhận file ảnh định dạng .jpg hoặc .png!");
                        request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                        return;
                    }

                    String originalFileName = imagePart.getSubmittedFileName();
                    String safeFileName = originalFileName.replaceAll("\\s+", "_");
                    String fileName = UUID.randomUUID().toString() + "_" + safeFileName;
                    String uploadPath = getServletContext().getRealPath("/images/course");
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    String filePath = uploadPath + File.separator + fileName;
                    try {
                        imagePart.write(filePath);
                        imagePath = "img/avatar/" + fileName;
                    } catch (IOException e) {
                        request.setAttribute("err", "Lỗi khi lưu tệp hình ảnh: " + e.getMessage());
                        request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                        return;
                    }
                }

                String trangThai = "Chưa bắt đầu"; // Ánh xạ sang giá trị cơ sở dữ liệu
                KhoaHoc khoaHoc = new KhoaHoc(null, courseCode, ten, moTa, batDau, ketThuc, ghiChu, trangThai, LocalDateTime.now(), id_khoi, imagePath, order);

                KhoaHoc result = dao.addKhoaHoc(khoaHoc);

                if (result != null) {
                    request.setAttribute("suc", "Thêm khóa học thành công!");
                } else {
                    request.setAttribute("err", "Thêm khóa học thất bại! Thiếu thông tin hoặc mã khóa học đã tồn tại.");
                }
                request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("err", "Lỗi: " + e.getMessage());
                request.getRequestDispatcher("/views/admin/addCourse.jsp").forward(request, response);
                return;
            }
         } else if ("submitUpdateCourse".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
                String ten = request.getParameter("TenKhoaHoc");
                String moTa = request.getParameter("MoTa");
                String batDauStr = request.getParameter("ThoiGianBatDau");
                String ketThucStr = request.getParameter("ThoiGianKetThuc");
                String ghiChu = request.getParameter("GhiChu");
                String trangThai = request.getParameter("TrangThai");
                String ID_Khoi = request.getParameter("ID_Khoi");
                String orderStr = request.getParameter("Order");
                String courseCode = request.getParameter("CourseCode");
                Part imagePart = request.getPart("Image");

                KhoaHocDAO dao = new KhoaHocDAO();
                KhoaHoc khoaHocCu = dao.getKhoaHocById(id);

                if (khoaHocCu == null) {
                    request.setAttribute("err", "Không tìm thấy khóa học với ID: " + id);
                    request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                    return;
                }

                // Giữ nguyên TenKhoaHoc, ID_Khoi, CourseCode từ bản ghi hiện tại vì chúng không thể chỉnh sửa
                ten = khoaHocCu.getTenKhoaHoc();
                int id_khoi = khoaHocCu.getID_Khoi();
                courseCode = khoaHocCu.getCourseCode();

                int order = 0;
                if (orderStr != null && !orderStr.trim().isEmpty()) {
                    try {
                        order = Integer.parseInt(orderStr);
                        if (order < 0) {
                            request.setAttribute("err", "Thứ tự phải là số không âm.");
                            request.setAttribute("khoaHoc", khoaHocCu);
                            request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                            return;
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("err", "Thứ tự phải là số nguyên hợp lệ.");
                        request.setAttribute("khoaHoc", khoaHocCu);
                        request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                        return;
                    }
                }

                // Ánh xạ trạng thái từ giao diện sang cơ sở dữ liệu
                String dbTrangThai = trangThai;
                if (trangThai != null && !trangThai.trim().isEmpty()) {
                    switch (trangThai) {
                        case "Đang hoạt động":
                            dbTrangThai = "Đang hoạt động";
                            break;
                        case "Chưa hoạt động":
                            dbTrangThai = "Chưa hoạt động";
                            break;
                        case "Chưa bắt đầu":
                            dbTrangThai = "Chưa bắt đầu";
                            break;
                        case "Đã kết thúc":
                            dbTrangThai = "Đã kết thúc";
                            break;
                        default:
                            request.setAttribute("err", "Trạng thái không hợp lệ!");
                            request.setAttribute("khoaHoc", khoaHocCu);
                            request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                            return;
                    }
                }

                LocalDate batDau = (batDauStr != null && !batDauStr.isEmpty()) ? LocalDate.parse(batDauStr) : null;
                LocalDate ketThuc = (ketThucStr != null && !ketThucStr.isEmpty()) ? LocalDate.parse(ketThucStr) : null;
                LocalDate today = LocalDate.now();

                if (batDau != null && batDau.isBefore(today)) {
                    request.setAttribute("err", "Ngày bắt đầu không được ở trong quá khứ!");
                    request.setAttribute("khoaHoc", khoaHocCu);
                    request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                    return;
                }

                if (batDau != null && ketThuc != null && !ketThuc.isAfter(batDau.plusDays(29))) {
                    request.setAttribute("err", "Ngày kết thúc phải sau ngày bắt đầu ít nhất 30 ngày!");
                    request.setAttribute("khoaHoc", khoaHocCu);
                    request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                    return;
                }

                String imagePath = khoaHocCu.getImage();
                if (imagePart != null && imagePart.getSize() > 0) {
                    String contentType = imagePart.getContentType();
                    if (!contentType.equals("image/jpeg") && !contentType.equals("image/png")) {
                        request.setAttribute("err", "Chỉ chấp nhận file ảnh định dạng .jpg hoặc .png!");
                        request.setAttribute("khoaHoc", khoaHocCu);
                        request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                        return;
                    }

                    String originalFileName = imagePart.getSubmittedFileName();
                    String safeFileName = originalFileName.replaceAll("\\s+", "_");
                    String fileName = UUID.randomUUID().toString() + "_" + safeFileName;
                    String uploadPath = getServletContext().getRealPath("/images/course");
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    String filePath = uploadPath + File.separator + fileName;
                    try {
                        imagePart.write(filePath);
                        imagePath = "/images/course/" + fileName;
                    } catch (IOException e) {
                        request.setAttribute("err", "Lỗi khi lưu tệp hình ảnh: " + e.getMessage());
                        request.setAttribute("khoaHoc", khoaHocCu);
                        request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                        return;
                    }
                }

                KhoaHoc khoaHoc = new KhoaHoc(id, courseCode, ten, moTa, batDau, ketThuc, ghiChu, dbTrangThai, LocalDateTime.now(), id_khoi, imagePath, order);

                KhoaHoc khoaHocUpdated = dao.updateKhoaHoc(khoaHoc);

                if (khoaHocUpdated != null) {
                    request.setAttribute("suc", "Cập nhật thành công");
                    request.setAttribute("khoaHoc", khoaHocUpdated);
                } else {
                    request.setAttribute("err", "Cập nhật thất bại!");
                    request.setAttribute("khoaHoc", khoaHoc);
                }

                request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("err", "Có lỗi xảy ra: " + e.getMessage());
                request.getRequestDispatcher("/views/admin/updateCourse.jsp").forward(request, response);
                return;
            }
        } else {
            doGet(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Servlet to manage course listing, sorting, pagination, and actions";
    }
}