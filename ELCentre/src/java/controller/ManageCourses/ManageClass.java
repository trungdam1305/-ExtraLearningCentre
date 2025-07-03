package controller.ManageCourses;

import dal.LopHocInfoDTODAO;
import dal.LopHocInfoDTODAO.AddLopHocResult;
import dal.LopHocInfoDTODAO.OperationResult;
import dal.SlotHocDAO;
import dal.PhongHocDAO;
import dal.KhoaHocDAO;
import dal.GiaoVienDAO;
import model.LopHocInfoDTO;
import model.SlotHoc;
import model.PhongHoc;
import model.KhoaHoc;
import model.GiaoVien;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.HashSet;
import java.util.UUID;

@WebServlet(name = "ManageClass", urlPatterns = {"/ManageClass"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ManageClass extends HttpServlet {

    private static final String UPLOAD_DIR = "images/class";
    private static final int MAX_SCHEDULES = 10;

    private void setCommonAttributes(HttpServletRequest request, String classCode, String tenLopHoc, Integer siSoToiDa,
                                     Integer siSoToiThieu, String ghiChu, String trangThai, String soTien, Integer order,
                                     String[] ngayHocs, String[] idSlotHocs, String[] idPhongHocs,
                                     int idKhoaHoc, int idKhoi) {
        HttpSession session = request.getSession();
        List<SlotHoc> slotHocList = (List<SlotHoc>) session.getAttribute("slotHocList");
        List<PhongHoc> phongHocList = (List<PhongHoc>) session.getAttribute("phongHocList");

        if (slotHocList == null || phongHocList == null) {
            SlotHocDAO slotHocDAO = new SlotHocDAO();
            PhongHocDAO phongHocDAO = new PhongHocDAO();
            slotHocList = slotHocDAO.getAllSlotHoc();
            phongHocList = phongHocDAO.getAllPhongHoc();
            session.setAttribute("slotHocList", slotHocList);
            session.setAttribute("phongHocList", phongHocList);
            session.setAttribute("maxInactiveInterval", 1800); // 30 phút
        }

        request.setAttribute("classCode", classCode);
        request.setAttribute("tenLopHoc", tenLopHoc);
        request.setAttribute("siSoToiDa", siSoToiDa);
        request.setAttribute("siSoToiThieu", siSoToiThieu);
        request.setAttribute("ghiChu", ghiChu);
        request.setAttribute("trangThai", trangThai);
        request.setAttribute("soTien", soTien);
        request.setAttribute("order", order);
        request.setAttribute("ngayHocs", ngayHocs);
        request.setAttribute("idSlotHocs", idSlotHocs);
        request.setAttribute("idPhongHocs", idPhongHocs);
        request.setAttribute("ID_KhoaHoc", idKhoaHoc);
        request.setAttribute("ID_Khoi", idKhoi);
        request.setAttribute("slotHocList", slotHocList);
        request.setAttribute("phongHocList", phongHocList);
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    private String validateFormData(HttpServletRequest request, boolean isUpdate, int siSoCurrent) {
        String classCode = request.getParameter("classCode");
        String tenLopHoc = request.getParameter("tenLopHoc");
        String trangThai = request.getParameter("trangThai");
        String siSoToiDaStr = request.getParameter("siSoToiDa");
        String siSoToiThieuStr = request.getParameter("siSoToiThieu");
        String soTienStr = request.getParameter("soTien");
        String orderStr = request.getParameter("order");
        String ghiChu = request.getParameter("ghiChu");
        String[] ngayHocs = request.getParameterValues("ngayHoc[]");
        String[] idSlotHocs = request.getParameterValues("idSlotHoc[]");
        String[] idPhongHocs = request.getParameterValues("idPhongHoc[]");

        // Validate classCode
        if (!isUpdate && (classCode == null || classCode.trim().isEmpty())) {
            return "Mã lớp học không được để trống!";
        }
        if (!isUpdate && (classCode != null && (classCode.length() > 20 || !classCode.matches("^[A-Za-z0-9]+$")))) {
            return "Mã lớp học chỉ được chứa chữ cái và số, tối đa 20 ký tự!";
        }

        // Validate tenLopHoc
        if (!isUpdate && (tenLopHoc == null || tenLopHoc.trim().isEmpty())) {
            return "Tên lớp học không được để trống!";
        }
        if (!isUpdate && tenLopHoc != null && tenLopHoc.length() > 100) {
            return "Tên lớp học không được dài quá 100 ký tự!";
        }

        // Validate trangThai
        if (trangThai == null || trangThai.trim().isEmpty() || !List.of("Inactive", "Active", "Finished").contains(trangThai)) {
            return "Trạng thái không hợp lệ!";
        }

        // Validate siSoToiDa
        int siSoToiDa;
        if (siSoToiDaStr == null || siSoToiDaStr.trim().isEmpty()) {
            return "Sĩ số tối đa không được để trống!";
        }
        try {
            siSoToiDa = Integer.parseInt(siSoToiDaStr);
            if (siSoToiDa <= 0) {
                return "Sĩ số tối đa phải lớn hơn 0!";
            }
            if (isUpdate && siSoToiDa < siSoCurrent) {
                return "Sĩ số tối đa phải lớn hơn hoặc bằng sĩ số hiện tại (" + siSoCurrent + ")!";
            }
        } catch (NumberFormatException e) {
            return "Sĩ số tối đa không hợp lệ!";
        }

        // Validate siSoToiThieu
        int siSoToiThieu;
        if (siSoToiThieuStr == null || siSoToiThieuStr.trim().isEmpty()) {
            return "Sĩ số tối thiểu không được để trống!";
        }
        try {
            siSoToiThieu = Integer.parseInt(siSoToiThieuStr);
            if (siSoToiThieu < 0) {
                return "Sĩ số tối thiểu không được nhỏ hơn 0!";
            }
            if (siSoToiThieu > siSoToiDa) {
                return "Sĩ số tối thiểu không được lớn hơn sĩ số tối đa!";
            }
        } catch (NumberFormatException e) {
            return "Sĩ số tối thiểu không hợp lệ!";
        }

        // Validate soTien
        int soTien;
        try {
            soTien = soTienStr != null && !soTienStr.trim().isEmpty() ? Integer.parseInt(soTienStr) : 0;
            if (soTien < 0) {
                return "Học phí không được nhỏ hơn 0!";
            }
            if (soTienStr != null && soTienStr.length() > 10) {
                return "Học phí không được dài quá 10 chữ số!";
            }
        } catch (NumberFormatException e) {
            return "Học phí không hợp lệ!";
        }

        // Validate order
        int order;
        try {
            order = orderStr != null && !orderStr.trim().isEmpty() ? Integer.parseInt(orderStr) : 0;
            if (order < 0) {
                return "Thứ tự không được nhỏ hơn 0!";
            }
        } catch (NumberFormatException e) {
            return "Thứ tự không hợp lệ!";
        }

        // Validate ghiChu
        if (ghiChu != null && ghiChu.length() > 500) {
            return "Ghi chú không được dài quá 500 ký tự!";
        }

        // Validate lịch học
        if (ngayHocs == null || idSlotHocs == null || idPhongHocs == null ||
            ngayHocs.length == 0 || idSlotHocs.length == 0 || idPhongHocs.length == 0) {
            return "Dữ liệu lịch học không được để trống!";
        }
        if (ngayHocs.length != idSlotHocs.length || ngayHocs.length != idPhongHocs.length) {
            return "Dữ liệu lịch học không đồng bộ!";
        }
        if (ngayHocs.length > MAX_SCHEDULES) {
            return "Không được thêm quá " + MAX_SCHEDULES + " lịch học!";
        }
        LocalDate today = LocalDate.now();
        for (String ngayHoc : ngayHocs) {
            if (ngayHoc == null || ngayHoc.trim().isEmpty()) {
                return "Ngày học không được để trống!";
            }
            try {
                LocalDate date = LocalDate.parse(ngayHoc);
                if (date.isBefore(today)) {
                    return "Ngày học không được trong quá khứ!";
                }
            } catch (Exception e) {
                return "Ngày học không đúng định dạng YYYY-MM-DD!";
            }
        }
        for (String idSlotHoc : idSlotHocs) {
            if (idSlotHoc == null || idSlotHoc.trim().isEmpty()) {
                return "ID slot học không được để trống!";
            }
            try {
                Integer.parseInt(idSlotHoc);
            } catch (NumberFormatException e) {
                return "ID slot học không hợp lệ!";
            }
        }
        for (String idPhongHoc : idPhongHocs) {
            if (idPhongHoc == null || idPhongHoc.trim().isEmpty()) {
                return "ID phòng học không được để trống!";
            }
            try {
                Integer.parseInt(idPhongHoc);
            } catch (NumberFormatException e) {
                return "ID phòng học không hợp lệ!";
            }
        }

        // Validate file ảnh
        try {
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String contentType = filePart.getContentType();
                if (!contentType.equals("image/jpeg") && !contentType.equals("image/png")) {
                    return "Chỉ chấp nhận file ảnh định dạng .jpg hoặc .png!";
                }
                if (filePart.getSize() > 10 * 1024 * 1024) {
                    return "File ảnh không được lớn hơn 10MB!";
                }
                String originalFileName = extractFileName(filePart);
                if (originalFileName == null || originalFileName.trim().isEmpty()) {
                    return "Tên file ảnh không hợp lệ!";
                }
            }
        } catch (IOException | ServletException e) {
            return "Lỗi khi xử lý file ảnh: " + e.getMessage();
        }

        return null; // Không có lỗi
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "ViewCourse";

        String idKhoiStr = request.getParameter("ID_Khoi");
        String idKhoaStr = request.getParameter("ID_KhoaHoc");
        if (idKhoiStr == null || idKhoiStr.trim().isEmpty() || idKhoaStr == null || idKhoaStr.trim().isEmpty()) {
            request.setAttribute("err", "Thiếu hoặc không hợp lệ tham số ID_KhoaHoc hoặc ID_Khoi.");
            request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
            return;
        }

        int idKhoi;
        int idKhoaHoc;
        try {
            idKhoi = Integer.parseInt(idKhoiStr);
            idKhoaHoc = Integer.parseInt(idKhoaStr);
        } catch (NumberFormatException e) {
            request.setAttribute("err", "ID_KhoaHoc hoặc ID_Khoi không hợp lệ.");
            request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
            return;
        }

        LopHocInfoDTODAO lopHocDAO = new LopHocInfoDTODAO();
        KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
        GiaoVienDAO giaoVienDAO = new GiaoVienDAO();

        KhoaHoc khoaHoc = khoaHocDAO.getKhoaHocById(idKhoaHoc);
        if (khoaHoc == null || khoaHoc.getID_Khoi() != idKhoi) {
            request.setAttribute("err", "Khóa học không tồn tại hoặc ID_Khoi không khớp!");
            setCommonAttributes(request, null, null, null, null, null, null, null, null, null, null, null, idKhoaHoc, idKhoi);
            request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
            return;
        }

        try {
            if ("ViewCourse".equalsIgnoreCase(action) || "filter".equalsIgnoreCase(action) || "sort".equalsIgnoreCase(action) || "filterStatus".equalsIgnoreCase(action) || "paginate".equalsIgnoreCase(action)) {
                String searchQuery = request.getParameter("searchQuery");
                String sortName = request.getParameter("sortName");
                String teacherFilter = request.getParameter("teacherFilter");
                String feeFilter = request.getParameter("feeFilter");
                String orderFilter = request.getParameter("orderFilter");
                String sortColumn = request.getParameter("sortColumn");
                String sortOrder = request.getParameter("sortOrder");
                int pageNumber = 1;
                int pageSize = 10;

                try {
                    if (request.getParameter("page") != null && !request.getParameter("page").trim().isEmpty()) {
                        pageNumber = Integer.parseInt(request.getParameter("page"));
                        if (pageNumber < 1) pageNumber = 1;
                    }
                } catch (NumberFormatException e) {
                    pageNumber = 1;
                    System.out.println("Invalid page parameter: " + e.getMessage());
                }

                // Lấy danh sách lớp học với các bộ lọc
                List<LopHocInfoDTO> danhSachLopHoc = lopHocDAO.getLopHocInfoList(searchQuery, sortName, pageNumber, pageSize, idKhoaHoc, idKhoi, sortColumn, sortOrder, teacherFilter, feeFilter, orderFilter);
                int totalItems = lopHocDAO.countClasses(searchQuery, sortName, idKhoaHoc, idKhoi, teacherFilter, feeFilter, orderFilter);
                int totalPages = (int) Math.ceil((double) totalItems / pageSize);

                // Lấy danh sách giáo viên từ cột tenGiaoVien trong danhSachLopHoc
                Set<GiaoVien> teacherList = new HashSet<>();
                for (LopHocInfoDTO lopHoc : danhSachLopHoc) {
                    if (lopHoc.getTenGiaoVien() != null && !lopHoc.getTenGiaoVien().isEmpty()) {
                        String[] teacherNames = lopHoc.getTenGiaoVien().split(", ");
                        for (String teacherName : teacherNames) {
                            GiaoVien teacher = giaoVienDAO.getGiaoVienByHoTen(teacherName.trim());
                            if (teacher != null) {
                                teacherList.add(teacher);
                            }
                        }
                    }
                }
                if (teacherList.isEmpty()) {
                    System.out.println("No teachers found in danhSachLopHoc for ID_KhoaHoc=" + idKhoaHoc);
                    request.setAttribute("err", "Không có giáo viên nào cho các lớp học hiện tại.");
                }

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
                request.setAttribute("teacherList", new ArrayList<>(teacherList));

                if (danhSachLopHoc.isEmpty()) {
                    request.setAttribute("err", "Không có lớp học nào phù hợp với bộ lọc.");
                }

                System.out.println("ViewCourse: Successfully processed - ID_KhoaHoc=" + idKhoaHoc + ", ID_Khoi=" + idKhoi +
                        ", searchQuery=" + searchQuery + ", sortName=" + sortName + ", teacherFilter=" + teacherFilter +
                        ", feeFilter=" + feeFilter + ", orderFilter=" + orderFilter + ", sortColumn=" + sortColumn +
                        ", sortOrder=" + sortOrder + ", page=" + pageNumber + ", totalItems=" + totalItems);

                request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
            } else if ("refresh".equalsIgnoreCase(action)) {
                List<LopHocInfoDTO> danhSachLopHoc = lopHocDAO.getLopHocInfoList(null, null, 1, 10, idKhoaHoc, idKhoi, null, null, null, null, null);
                int totalItems = lopHocDAO.countClasses(null, null, idKhoaHoc, idKhoi, null, null, null);
                int totalPages = (int) Math.ceil((double) totalItems / 10);

                // Lấy danh sách giáo viên từ cột tenGiaoVien trong danhSachLopHoc
                Set<GiaoVien> teacherList = new HashSet<>();
                for (LopHocInfoDTO lopHoc : danhSachLopHoc) {
                    if (lopHoc.getTenGiaoVien() != null && !lopHoc.getTenGiaoVien().isEmpty()) {
                        String[] teacherNames = lopHoc.getTenGiaoVien().split(", ");
                        for (String teacherName : teacherNames) {
                            GiaoVien teacher = giaoVienDAO.getGiaoVienByHoTen(teacherName.trim());
                            if (teacher != null) {
                                teacherList.add(teacher);
                            }
                        }
                    }
                }
                if (teacherList.isEmpty()) {
                    System.out.println("No teachers found in danhSachLopHoc for ID_KhoaHoc=" + idKhoaHoc);
                    request.setAttribute("err", "Không có giáo viên nào cho các lớp học hiện tại.");
                }

                request.setAttribute("danhSachLopHoc", danhSachLopHoc);
                request.setAttribute("totalItems", totalItems);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("page", 1);
                request.setAttribute("sortColumn", null);
                request.setAttribute("sortOrder", null);
                request.setAttribute("searchQuery", null);
                request.setAttribute("sortName", null);
                request.setAttribute("teacherFilter", null);
                request.setAttribute("feeFilter", null);
                request.setAttribute("orderFilter", null);
                request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                request.setAttribute("ID_Khoi", idKhoi);
                request.setAttribute("teacherList", new ArrayList<>(teacherList));

                if (danhSachLopHoc.isEmpty()) {
                    request.setAttribute("err", "Chưa có lớp học nào được khởi tạo cho khóa học này.");
                }

                System.out.println("Refresh: Successfully processed - ID_KhoaHoc=" + idKhoaHoc + ", ID_Khoi=" + idKhoi +
                        ", totalItems=" + totalItems);

                request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
            } else if ("showAddClass".equalsIgnoreCase(action)) {
                HttpSession session = request.getSession();
                List<SlotHoc> slotHocList = (List<SlotHoc>) session.getAttribute("slotHocList");
                List<PhongHoc> phongHocList = (List<PhongHoc>) session.getAttribute("phongHocList");
                List<GiaoVien> teacherList = giaoVienDAO.getTeachersBySpecialization(khoaHoc.getTenKhoaHoc());

                if (slotHocList == null || phongHocList == null) {
                    SlotHocDAO slotHocDAO = new SlotHocDAO();
                    PhongHocDAO phongHocDAO = new PhongHocDAO();
                    slotHocList = slotHocDAO.getAllSlotHoc();
                    phongHocList = phongHocDAO.getAllPhongHoc();
                    session.setAttribute("slotHocList", slotHocList);
                    session.setAttribute("phongHocList", phongHocList);
                    session.setAttribute("maxInactiveInterval", 1800); // 30 phút
                }

                if (slotHocList.isEmpty() || phongHocList.isEmpty()) {
                    request.setAttribute("err", slotHocList.isEmpty() ? "Không có slot học nào trong hệ thống." : "Không có phòng học nào trong hệ thống.");
                    request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                    request.setAttribute("ID_Khoi", idKhoi);
                    request.setAttribute("teacherList", teacherList);
                    request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                    return;
                }

                request.setAttribute("slotHocList", slotHocList);
                request.setAttribute("phongHocList", phongHocList);
                request.setAttribute("teacherList", teacherList);
                request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                request.setAttribute("ID_Khoi", idKhoi);
                request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
            } else if ("updateClass".equalsIgnoreCase(action)) {
                String idLopHocStr = request.getParameter("ID_LopHoc");
                if (idLopHocStr == null || idLopHocStr.trim().isEmpty()) {
                    request.setAttribute("err", "ID_LopHoc không được để trống!");
                    request.setAttribute("teacherList", giaoVienDAO.getTeachersBySpecialization(khoaHoc.getTenKhoaHoc()));
                    request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
                    return;
                }
                int idLopHoc;
                try {
                    idLopHoc = Integer.parseInt(idLopHocStr);
                } catch (NumberFormatException e) {
                    request.setAttribute("err", "ID_LopHoc không hợp lệ.");
                    request.setAttribute("teacherList", giaoVienDAO.getTeachersBySpecialization(khoaHoc.getTenKhoaHoc()));
                    request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
                    return;
                }

                LopHocInfoDTO lopHoc = lopHocDAO.getLopHocInfoById(idLopHoc);
                if (lopHoc == null) {
                    request.setAttribute("err", "Không tìm thấy lớp học!");
                    request.setAttribute("teacherList", giaoVienDAO.getTeachersBySpecialization(khoaHoc.getTenKhoaHoc()));
                    request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
                    return;
                }

                HttpSession session = request.getSession();
                List<SlotHoc> slotHocList = (List<SlotHoc>) session.getAttribute("slotHocList");
                List<PhongHoc> phongHocList = (List<PhongHoc>) session.getAttribute("phongHocList");

                if (slotHocList == null || phongHocList == null) {
                    SlotHocDAO slotHocDAO = new SlotHocDAO();
                    PhongHocDAO phongHocDAO = new PhongHocDAO();
                    slotHocList = slotHocDAO.getAllSlotHoc();
                    phongHocList = phongHocDAO.getAllPhongHoc();
                    session.setAttribute("slotHocList", slotHocList);
                    session.setAttribute("phongHocList", phongHocList);
                    session.setAttribute("maxInactiveInterval", 1800); // 30 phút
                }

                request.setAttribute("lopHoc", lopHoc);
                request.setAttribute("slotHocList", slotHocList);
                request.setAttribute("phongHocList", phongHocList);
                request.setAttribute("teacherList", giaoVienDAO.getTeachersBySpecialization(khoaHoc.getTenKhoaHoc()));
                request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                request.setAttribute("ID_Khoi", idKhoi);
                request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
            } else {
                request.setAttribute("err", "Hành động không hợp lệ!");
                request.setAttribute("teacherList", giaoVienDAO.getTeachersBySpecialization(khoaHoc.getTenKhoaHoc()));
                request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.out.println("doGet error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("err", "Lỗi xử lý yêu cầu: " + e.getMessage());
            request.setAttribute("teacherList", giaoVienDAO.getTeachersBySpecialization(khoaHoc.getTenKhoaHoc()));
            request.getRequestDispatcher("/views/admin/manageCourses.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String idKhoaStr = request.getParameter("ID_KhoaHoc");
        String idKhoiStr = request.getParameter("ID_Khoi");

        if (idKhoaStr == null || idKhoaStr.trim().isEmpty() || idKhoiStr == null || idKhoiStr.trim().isEmpty()) {
            request.setAttribute("err", "ID_KhoaHoc hoặc ID_Khoi không được để trống!");
            setCommonAttributes(request, null, null, null, null, null, null, null, null, null, null, null, -1, -1);
            request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
            return;
        }

        int idKhoaHoc;
        int idKhoi;
        try {
            idKhoaHoc = Integer.parseInt(idKhoaStr);
            idKhoi = Integer.parseInt(idKhoiStr);
        } catch (NumberFormatException e) {
            System.out.println("Invalid ID_KhoaHoc/ID_Khoi: " + e.getMessage());
            request.setAttribute("err", "ID_KhoaHoc hoặc ID_Khoi không hợp lệ.");
            setCommonAttributes(request, null, null, null, null, null, null, null, null, null, null, null, -1, -1);
            request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
            return;
        }

        LopHocInfoDTODAO lopHocDAO = new LopHocInfoDTODAO();
        KhoaHocDAO khoaHocDAO = new KhoaHocDAO();

        KhoaHoc khoaHoc = khoaHocDAO.getKhoaHocById(idKhoaHoc);
        if (khoaHoc == null || khoaHoc.getID_Khoi() != idKhoi) {
            System.out.println("Invalid course or ID_Khoi mismatch");
            request.setAttribute("err", "Khóa học không tồn tại hoặc ID_Khoi không khớp!");
            setCommonAttributes(request, null, null, null, null, null, null, null, null, null, null, null, idKhoaHoc, idKhoi);
            request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
            return;
        }

        try {
            if ("addClass".equalsIgnoreCase(action)) {
                String classCode = request.getParameter("classCode");
                String tenLopHoc = request.getParameter("tenLopHoc");
                String trangThai = request.getParameter("trangThai");
                String soTienStr = request.getParameter("soTien");
                String ghiChu = request.getParameter("ghiChu");
                String orderStr = request.getParameter("order");
                String siSoToiDaStr = request.getParameter("siSoToiDa");
                String siSoToiThieuStr = request.getParameter("siSoToiThieu");
                String[] ngayHocs = request.getParameterValues("ngayHoc[]");
                String[] idSlotHocs = request.getParameterValues("idSlotHoc[]");
                String[] idPhongHocs = request.getParameterValues("idPhongHoc[]");

                // Validate form data
                String validationError = validateFormData(request, false, 0);
                if (validationError != null) {
                    System.out.println("Validation error in addClass: " + validationError);
                    Integer siSoToiDa = siSoToiDaStr != null && !siSoToiDaStr.trim().isEmpty() ? Integer.parseInt(siSoToiDaStr) : null;
                    Integer siSoToiThieu = siSoToiThieuStr != null && !siSoToiThieuStr.trim().isEmpty() ? Integer.parseInt(siSoToiThieuStr) : null;
                    Integer order = orderStr != null && !orderStr.trim().isEmpty() ? Integer.parseInt(orderStr) : null;
                    setCommonAttributes(request, classCode, tenLopHoc, siSoToiDa, siSoToiThieu, ghiChu, trangThai, soTienStr, order, ngayHocs, idSlotHocs, idPhongHocs, idKhoaHoc, idKhoi);
                    request.setAttribute("err", validationError);
                    request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                    return;
                }

                int siSoToiDa = Integer.parseInt(siSoToiDaStr);
                int siSoToiThieu = Integer.parseInt(siSoToiThieuStr);
                int soTien = soTienStr != null && !soTienStr.trim().isEmpty() ? Integer.parseInt(soTienStr) : 0;
                int order = orderStr != null && !orderStr.trim().isEmpty() ? Integer.parseInt(orderStr) : 0;

                List<Integer> idSlotHocList = new ArrayList<>();
                List<Integer> idPhongHocList = new ArrayList<>();
                for (String idSlotHoc : idSlotHocs) {
                    idSlotHocList.add(Integer.parseInt(idSlotHoc));
                }
                for (String idPhongHoc : idPhongHocs) {
                    idPhongHocList.add(Integer.parseInt(idPhongHoc));
                }

                // Xử lý upload ảnh
                String imagePath = null;
                try {
                    Part filePart = request.getPart("image");
                    if (filePart != null && filePart.getSize() > 0) {
                        String contentType = filePart.getContentType();
                        if (!contentType.equals("image/jpeg") && !contentType.equals("image/png")) {
                            System.out.println("addClass: Invalid image format - ContentType=" + contentType);
                            request.setAttribute("err", "Chỉ chấp nhận file ảnh định dạng .jpg hoặc .png!");
                            setCommonAttributes(request, classCode, tenLopHoc, siSoToiDa, siSoToiThieu, ghiChu, trangThai, soTienStr, order, ngayHocs, idSlotHocs, idPhongHocs, idKhoaHoc, idKhoi);
                            request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                            return;
                        }

                        String originalFileName = extractFileName(filePart);
                        String safeFileName = originalFileName.replaceAll("\\s+", "_");
                        String fileName = UUID.randomUUID().toString() + "_" + safeFileName;
                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        if (!uploadDir.canWrite()) {
                            System.out.println("addClass: Cannot write to directory - Path=" + uploadPath);
                            request.setAttribute("err", "Không có quyền ghi vào thư mục lưu trữ!");
                            setCommonAttributes(request, classCode, tenLopHoc, siSoToiDa, siSoToiThieu, ghiChu, trangThai, soTienStr, order, ngayHocs, idSlotHocs, idPhongHocs, idKhoaHoc, idKhoi);
                            request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                            return;
                        }
                        String filePath = uploadPath + File.separator + fileName;
                        filePart.write(filePath);
                        imagePath = "/" + UPLOAD_DIR + "/" + fileName;
                    }
                } catch (IOException | ServletException e) {
                    System.out.println("addClass: Error saving image - " + e.getMessage());
                    request.setAttribute("err", "Lỗi khi lưu tệp hình ảnh: " + e.getMessage());
                    setCommonAttributes(request, classCode, tenLopHoc, siSoToiDa, siSoToiThieu, ghiChu, trangThai, soTienStr, order, ngayHocs, idSlotHocs, idPhongHocs, idKhoaHoc, idKhoi);
                    request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                    return;
                }

                long startTime = System.currentTimeMillis();
                AddLopHocResult result = lopHocDAO.addLopHoc(
                    tenLopHoc.trim(),
                    classCode.trim(),
                    idKhoaHoc,
                    idKhoi,
                    0,
                    idSlotHocList,
                    List.of(ngayHocs),
                    idPhongHocList,
                    ghiChu,
                    trangThai,
                    soTien,
                    imagePath,
                    siSoToiDa,
                    order,
                    siSoToiThieu
                );
                System.out.println("addLopHoc time: " + (System.currentTimeMillis() - startTime) + "ms");

                if (result.getLopHoc() != null) {
                    request.setAttribute("suc", "Thêm lớp học thành công!");
                    setCommonAttributes(request, classCode, tenLopHoc, siSoToiDa, siSoToiThieu, ghiChu, trangThai, soTienStr, order, ngayHocs, idSlotHocs, idPhongHocs, idKhoaHoc, idKhoi);
                    request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                } else {
                    System.out.println("addLopHoc failed: " + result.getErrorMessage());
                    request.setAttribute("err", result.getErrorMessage() != null ? result.getErrorMessage() : "Lỗi khi thêm lớp học!");
                    setCommonAttributes(request, classCode, tenLopHoc, siSoToiDa, siSoToiThieu, ghiChu, trangThai, soTienStr, order, ngayHocs, idSlotHocs, idPhongHocs, idKhoaHoc, idKhoi);
                    request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                }
            } else if ("deleteClass".equalsIgnoreCase(action)) {
                String csrfToken = request.getParameter("csrfToken");
                String sessionCsrfToken = (String) request.getSession().getAttribute("csrfToken");
                if (csrfToken == null || !csrfToken.equals(sessionCsrfToken)) {
                    System.out.println("Invalid CSRF token");
                    request.setAttribute("err", "Token CSRF không hợp lệ!");
                    request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                    request.setAttribute("ID_Khoi", idKhoi);
                    request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
                    return;
                }

                String idLopHocStr = request.getParameter("ID_LopHoc");
                if (idLopHocStr == null || idLopHocStr.trim().isEmpty()) {
                    System.out.println("Missing ID_LopHoc");
                    request.setAttribute("err", "ID lớp học không được để trống!");
                    request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                    request.setAttribute("ID_Khoi", idKhoi);
                    request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
                    return;
                }

                int idLopHoc;
                try {
                    idLopHoc = Integer.parseInt(idLopHocStr);
                } catch (NumberFormatException e) {
                    System.out.println("Invalid ID_LopHoc: " + e.getMessage());
                    request.setAttribute("err", "ID lớp học không hợp lệ!");
                    request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                    request.setAttribute("ID_Khoi", idKhoi);
                    request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
                    return;
                }

                long startTime = System.currentTimeMillis();
                OperationResult result = lopHocDAO.deleteLopHoc(idLopHoc);
                System.out.println("deleteLopHoc time: " + (System.currentTimeMillis() - startTime) + "ms");

                if (result.isSuccess()) {
                    request.setAttribute("suc", "Xóa lớp học thành công!");
                } else {
                    System.out.println("deleteLopHoc failed: " + result.getErrorMessage());
                    request.setAttribute("err", result.getErrorMessage() != null ? result.getErrorMessage() : "Lỗi khi xóa lớp học!");
                }
                request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                request.setAttribute("ID_Khoi", idKhoi);
                List<LopHocInfoDTO> danhSachLopHoc = lopHocDAO.getLopHocInfoList(null, null, 1, 10, idKhoaHoc, idKhoi, null, null, null, null, null);
                int totalItems = lopHocDAO.countClasses(null, null, idKhoaHoc, idKhoi, null, null, null);
                int totalPages = (int) Math.ceil((double) totalItems / 10);
                request.setAttribute("danhSachLopHoc", danhSachLopHoc);
                request.setAttribute("totalItems", totalItems);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("page", 1);
                request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
            } else if ("updateClass".equalsIgnoreCase(action)) {
                String idLopHocStr = request.getParameter("ID_LopHoc");
                if (idLopHocStr == null || idLopHocStr.trim().isEmpty()) {
                    System.out.println("Missing ID_LopHoc for update");
                    request.setAttribute("err", "ID_LopHoc không được để trống!");
                    setCommonAttributes(request, null, null, null, null, null, null, null, null, null, null, null, idKhoaHoc, idKhoi);
                    request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                    return;
                }

                int idLopHoc;
                try {
                    idLopHoc = Integer.parseInt(idLopHocStr);
                } catch (NumberFormatException e) {
                    System.out.println("Invalid ID_LopHoc for update: " + e.getMessage());
                    request.setAttribute("err", "ID_LopHoc không hợp lệ!");
                    setCommonAttributes(request, null, null, null, null, null, null, null, null, null, null, null, idKhoaHoc, idKhoi);
                    request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                    return;
                }

                LopHocInfoDTO lopHoc = lopHocDAO.getLopHocInfoById(idLopHoc);
                if (lopHoc == null) {
                    System.out.println("LopHoc not found: ID_LopHoc=" + idLopHoc);
                    request.setAttribute("err", "Không tìm thấy lớp học!");
                    request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
                    return;
                }

                String tenLopHoc = lopHoc.getTenLopHoc();
                String classCode = lopHoc.getClassCode();
                int siSo = lopHoc.getSiSo();
                String ghiChu = request.getParameter("ghiChu");
                String trangThai = request.getParameter("trangThai");
                String soTienStr = request.getParameter("soTien");
                String orderStr = request.getParameter("order");
                String siSoToiDaStr = request.getParameter("siSoToiDa");
                String siSoToiThieuStr = request.getParameter("siSoToiThieu");
                String[] ngayHocs = request.getParameterValues("ngayHoc[]");
                String[] idSlotHocs = request.getParameterValues("idSlotHoc[]");
                String[] idPhongHocs = request.getParameterValues("idPhongHoc[]");

                // Validate form data
                String validationError = validateFormData(request, true, siSo);
                if (validationError != null) {
                    System.out.println("Validation error in updateClass: " + validationError);
                    Integer siSoToiDa = siSoToiDaStr != null && !siSoToiDaStr.trim().isEmpty() ? Integer.parseInt(siSoToiDaStr) : null;
                    Integer siSoToiThieu = siSoToiThieuStr != null && !siSoToiThieuStr.trim().isEmpty() ? Integer.parseInt(siSoToiThieuStr) : null;
                    Integer order = orderStr != null && !orderStr.trim().isEmpty() ? Integer.parseInt(orderStr) : null;
                    setCommonAttributes(request, classCode, tenLopHoc, siSoToiDa, siSoToiThieu, ghiChu, trangThai, soTienStr, order, ngayHocs, idSlotHocs, idPhongHocs, idKhoaHoc, idKhoi);
                    request.setAttribute("err", validationError);
                    request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                    return;
                }

                int siSoToiDa = Integer.parseInt(siSoToiDaStr);
                int siSoToiThieu = Integer.parseInt(siSoToiThieuStr);
                int soTien = soTienStr != null && !soTienStr.trim().isEmpty() ? Integer.parseInt(soTienStr) : 0;
                int order = orderStr != null && !orderStr.trim().isEmpty() ? Integer.parseInt(orderStr) : 0;

                List<Integer> idSlotHocList = new ArrayList<>();
                List<Integer> idPhongHocList = new ArrayList<>();
                for (String idSlotHoc : idSlotHocs) {
                    idSlotHocList.add(Integer.parseInt(idSlotHoc));
                }
                for (String idPhongHoc : idPhongHocs) {
                    idPhongHocList.add(Integer.parseInt(idPhongHoc));
                }

                // Xử lý upload ảnh
                String imagePath = lopHoc.getAvatarGiaoVien();
                try {
                    Part filePart = request.getPart("image");
                    if (filePart != null && filePart.getSize() > 0) {
                        String contentType = filePart.getContentType();
                        if (!contentType.equals("image/jpeg") && !contentType.equals("image/png")) {
                            System.out.println("updateClass: Invalid image format - ContentType=" + contentType);
                            request.setAttribute("err", "Chỉ chấp nhận file ảnh định dạng .jpg hoặc .png!");
                            setCommonAttributes(request, classCode, tenLopHoc, siSoToiDa, siSoToiThieu, ghiChu, trangThai, soTienStr, order, ngayHocs, idSlotHocs, idPhongHocs, idKhoaHoc, idKhoi);
                            request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                            return;
                        }

                        // Xóa ảnh cũ nếu tồn tại
                        if (imagePath != null && !imagePath.isEmpty()) {
                            String oldImagePath = getServletContext().getRealPath("") + imagePath;
                            File oldImageFile = new File(oldImagePath);
                            if (oldImageFile.exists()) {
                                oldImageFile.delete();
                            }
                        }

                        String originalFileName = extractFileName(filePart);
                        String safeFileName = originalFileName.replaceAll("\\s+", "_");
                        String fileName = UUID.randomUUID().toString() + "_" + safeFileName;
                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        if (!uploadDir.canWrite()) {
                            System.out.println("updateClass: Cannot write to directory - Path=" + uploadPath);
                            request.setAttribute("err", "Không có quyền ghi vào thư mục lưu trữ!");
                            setCommonAttributes(request, classCode, tenLopHoc, siSoToiDa, siSoToiThieu, ghiChu, trangThai, soTienStr, order, ngayHocs, idSlotHocs, idPhongHocs, idKhoaHoc, idKhoi);
                            request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                            return;
                        }
                        String filePath = uploadPath + File.separator + fileName;
                        filePart.write(filePath);
                        imagePath = "/" + UPLOAD_DIR + "/" + fileName;
                    }
                } catch (IOException | ServletException e) {
                    System.out.println("updateClass: Error saving image - " + e.getMessage());
                    request.setAttribute("err", "Lỗi khi lưu tệp hình ảnh: " + e.getMessage());
                    setCommonAttributes(request, classCode, tenLopHoc, siSoToiDa, siSoToiThieu, ghiChu, trangThai, soTienStr, order, ngayHocs, idSlotHocs, idPhongHocs, idKhoaHoc, idKhoi);
                    request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                    return;
                }

                long startTime = System.currentTimeMillis();
                AddLopHocResult result = lopHocDAO.updateLopHoc(
                    idLopHoc,
                    tenLopHoc,
                    classCode,
                    idKhoaHoc,
                    idKhoi,
                    siSo,
                    idSlotHocList,
                    List.of(ngayHocs),
                    idPhongHocList,
                    ghiChu,
                    trangThai,
                    soTien,
                    imagePath,
                    siSoToiDa,
                    order,
                    siSoToiThieu
                );
                System.out.println("updateLopHoc time: " + (System.currentTimeMillis() - startTime) + "ms");

                if (result.getLopHoc() != null) {
                    request.setAttribute("suc", "Cập nhật lớp học thành công!");
                    setCommonAttributes(request, classCode, tenLopHoc, siSoToiDa, siSoToiThieu, ghiChu, trangThai, soTienStr, order, ngayHocs, idSlotHocs, idPhongHocs, idKhoaHoc, idKhoi);
                    request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                } else {
                    System.out.println("updateLopHoc failed: " + result.getErrorMessage());
                    request.setAttribute("err", result.getErrorMessage() != null ? result.getErrorMessage() : "Lỗi khi cập nhật lớp học!");
                    setCommonAttributes(request, classCode, tenLopHoc, siSoToiDa, siSoToiThieu, ghiChu, trangThai, soTienStr, order, ngayHocs, idSlotHocs, idPhongHocs, idKhoaHoc, idKhoi);
                    request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                }
            } else {
                System.out.println("Invalid action: " + action);
                request.setAttribute("err", "Hành động không hợp lệ!");
                setCommonAttributes(request, null, null, null, null, null, null, null, null, null, null, null, idKhoaHoc, idKhoi);
                request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.out.println("doPost error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("err", "Lỗi xử lý yêu cầu: " + e.getMessage());
            String siSoToiDaStr = request.getParameter("siSoToiDa");
            String siSoToiThieuStr = request.getParameter("siSoToiThieu");
            String orderStr = request.getParameter("order");
            Integer siSoToiDa = siSoToiDaStr != null && !siSoToiDaStr.trim().isEmpty() ? Integer.parseInt(siSoToiDaStr) : null;
            Integer siSoToiThieu = siSoToiThieuStr != null && !siSoToiThieuStr.trim().isEmpty() ? Integer.parseInt(siSoToiThieuStr) : null;
            Integer order = orderStr != null && !orderStr.trim().isEmpty() ? Integer.parseInt(orderStr) : null;
            setCommonAttributes(request, 
                               request.getParameter("classCode"), 
                               request.getParameter("tenLopHoc"), 
                               siSoToiDa, 
                               siSoToiThieu, 
                               request.getParameter("ghiChu"), 
                               request.getParameter("trangThai"), 
                               request.getParameter("soTien"), 
                               order, 
                               request.getParameterValues("ngayHoc[]"), 
                               request.getParameterValues("idSlotHoc[]"), 
                               request.getParameterValues("idPhongHoc[]"), 
                               idKhoaHoc, 
                               idKhoi);
            request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
        }
    }
}