package controller.ManageCourses;

import dal.LichHocDAO;
import dal.LopHocDAO;
import dal.SlotHocDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.LichHoc;
import model.LopHoc;
import model.SlotHoc;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import javax.imageio.ImageIO;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig
public class ManageClass extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        LopHocDAO lopHocDAO = new LopHocDAO();
        SlotHocDAO slotHocDAO = new SlotHocDAO();
        String action = request.getParameter("action");

        // Lấy danh sách slot học
        try {
            List<SlotHoc> slotHocList = slotHocDAO.getAllSlotHoc();
            System.out.println("doGet: slotHocList size: " + (slotHocList != null ? slotHocList.size() : "null"));
            request.setAttribute("slotHocList", slotHocList);
            if (slotHocList == null || slotHocList.isEmpty()) {
                request.setAttribute("err", "Không có slot học nào trong hệ thống. Vui lòng thêm slot học.");
            }
        } catch (SQLException e) {
            Logger.getLogger(ManageClass.class.getName()).log(Level.SEVERE, "Error loading slotHocList: " + e.getMessage(), e);
            request.setAttribute("err", "Không thể tải danh sách slot học: " + e.getMessage());
        }

        // Lấy các tham số chung
        String name = request.getParameter("name");
        if (name == null || name.isEmpty()) {
            name = null;
        }
        String filterStatus = request.getParameter("filterStatus");
        String sortColumn = request.getParameter("sortColumn");
        String sortOrder = request.getParameter("sortOrder");
        String pageStr = request.getParameter("page");
        String idKhoaStr = request.getParameter("ID_KhoaHoc");
        String idKhoiStr = request.getParameter("ID_Khoi");

        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int idKhoaHoc = (idKhoaStr != null && !idKhoaStr.isEmpty()) ? Integer.parseInt(idKhoaStr) : -1;
        int idKhoi = (idKhoiStr != null && !idKhoiStr.isEmpty()) ? Integer.parseInt(idKhoiStr) : -1;

        // Debug tham số
        System.out.println("Debug: idKhoaHoc = " + idKhoaHoc + ", idKhoi = " + idKhoi);

        if (sortColumn == null) {
            sortColumn = "TenLopHoc";
        }
        if (sortOrder == null) {
            sortOrder = "asc";
        }

        // Xử lý theo action
        try {
            if ("search".equalsIgnoreCase(action) || "filterStatus".equalsIgnoreCase(action) || action == null) {
                String sortName = request.getParameter("sortName");
                if ("ASCTrang".equalsIgnoreCase(sortName)) {
                    filterStatus = "Active";
                } else if ("DESCTrang".equalsIgnoreCase(sortName)) {
                    filterStatus = "Inactive";
                }
                List<LopHoc> danhSachLopHoc = lopHocDAO.searchAndFilterLopHoc(name, filterStatus, page, PAGE_SIZE, idKhoaHoc, idKhoi);
                int totalItems = lopHocDAO.countClasses(name, filterStatus, idKhoaHoc, idKhoi);
                int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

                System.out.println("Debug: danhSachLopHoc size = " + (danhSachLopHoc != null ? danhSachLopHoc.size() : "null"));
                request.setAttribute("danhSachLopHoc", danhSachLopHoc);
                request.setAttribute("totalItems", totalItems);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("page", page);
                request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                request.setAttribute("ID_Khoi", idKhoi);
                request.setAttribute("searchName", name);
                request.setAttribute("filterStatus", filterStatus);
                request.setAttribute("sortName", sortName);

                if (danhSachLopHoc == null || danhSachLopHoc.isEmpty()) {
                    request.setAttribute("err", "Không có lớp nào với tên và trạng thái bạn đang tìm");
                }
                request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
            } else if ("sort".equalsIgnoreCase(action)) {
                List<LopHoc> danhSachLopHoc = lopHocDAO.getClassesSortedPaged(sortColumn, sortOrder, name, page, PAGE_SIZE, idKhoaHoc, idKhoi);
                int totalItems = lopHocDAO.countClasses(name, filterStatus, idKhoaHoc, idKhoi);
                int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

                System.out.println("Debug: danhSachLopHoc size = " + (danhSachLopHoc != null ? danhSachLopHoc.size() : "null"));
                request.setAttribute("danhSachLopHoc", danhSachLopHoc);
                request.setAttribute("totalItems", totalItems);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("page", page);
                request.setAttribute("sortColumn", sortColumn);
                request.setAttribute("sortOrder", sortOrder);
                request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                request.setAttribute("ID_Khoi", idKhoi);
                request.setAttribute("searchName", name);
                request.setAttribute("filterStatus", filterStatus);
                request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
            } else if ("paginate".equalsIgnoreCase(action)) {
                List<LopHoc> danhSachLopHoc = lopHocDAO.getClassesSortedPaged(sortColumn, sortOrder, name, page, PAGE_SIZE, idKhoaHoc, idKhoi);
                int totalItems = lopHocDAO.countClasses(name, filterStatus, idKhoaHoc, idKhoi);
                int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

                System.out.println("Debug: danhSachLopHoc size = " + (danhSachLopHoc != null ? danhSachLopHoc.size() : "null"));
                request.setAttribute("danhSachLopHoc", danhSachLopHoc);
                request.setAttribute("totalItems", totalItems);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("page", page);
                request.setAttribute("sortColumn", sortColumn);
                request.setAttribute("sortOrder", sortOrder);
                request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                request.setAttribute("ID_Khoi", idKhoi);
                request.setAttribute("searchName", name);
                request.setAttribute("filterStatus", filterStatus);
                request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
            } else if ("updateClass".equalsIgnoreCase(action)) {
                int idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
                LopHoc lopHoc = lopHocDAO.getLopHocById(idLopHoc);
                if (lopHoc != null) {
                    request.setAttribute("lopHoc", lopHoc);
                    request.setAttribute("idKhoaHoc", idKhoaHoc);
                    request.setAttribute("idKhoi", idKhoi);
                    request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/ManageClass?message=notFound&ID_KhoaHoc=" + idKhoaHoc + "&ID_Khoi=" + idKhoi);
                }
            } else if ("refresh".equalsIgnoreCase(action)) {
                List<LopHoc> danhSachLopHoc = lopHocDAO.getClassesSortedPaged(sortColumn, sortOrder, name, page, PAGE_SIZE, idKhoaHoc, idKhoi);
                int totalItems = lopHocDAO.countClasses(name, filterStatus, idKhoaHoc, idKhoi);
                int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

                System.out.println("Debug: danhSachLopHoc size = " + (danhSachLopHoc != null ? danhSachLopHoc.size() : "null"));
                request.setAttribute("danhSachLopHoc", danhSachLopHoc);
                request.setAttribute("totalItems", totalItems);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("page", page);
                request.setAttribute("sortColumn", sortColumn);
                request.setAttribute("sortOrder", sortOrder);
                request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                request.setAttribute("ID_Khoi", idKhoi);
                request.setAttribute("searchName", name);
                request.setAttribute("filterStatus", filterStatus);
                request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
            } else if ("showAddClass".equalsIgnoreCase(action)) {
                request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                request.setAttribute("ID_Khoi", idKhoi);
                request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
            } else if ("viewClass".equalsIgnoreCase(action)) {
                int idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
                LopHoc lopHoc = lopHocDAO.getLopHocById(idLopHoc);
                if (lopHoc != null) {
                    // Lấy lịch học liên quan nếu có
                    LichHocDAO lichHocDAO = new LichHocDAO();
                    LichHoc lichHoc = null;
                    if (lopHoc.getID_Schedule() > 0) {
                        lichHoc = lichHocDAO.getLichHocById(lopHoc.getID_Schedule());
                    }
                    request.setAttribute("lopHoc", lopHoc);
                    request.setAttribute("lichHoc", lichHoc);
                    request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                    request.setAttribute("ID_Khoi", idKhoi);
                    request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/ManageClass?message=notFound&ID_KhoaHoc=" + idKhoaHoc + "&ID_Khoi=" + idKhoi);
                }
            }
        } catch (Exception e) {
            Logger.getLogger(ManageClass.class.getName()).log(Level.SEVERE, "Error in doGet: " + e.getMessage(), e);
            throw new ServletException("Lỗi xử lý yêu cầu: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        LopHocDAO lopHocDAO = new LopHocDAO();
        LichHocDAO lichHocDAO = new LichHocDAO();
        SlotHocDAO slotHocDAO = new SlotHocDAO();
        String action = request.getParameter("action");

        // Lấy danh sách slot học
        try {
            List<SlotHoc> slotHocList = slotHocDAO.getAllSlotHoc();
            System.out.println("doPost: slotHocList size: " + (slotHocList != null ? slotHocList.size() : "null"));
            request.setAttribute("slotHocList", slotHocList);
            if (slotHocList == null || slotHocList.isEmpty()) {
                request.setAttribute("err", "Không có slot học nào trong hệ thống. Vui lòng thêm slot học.");
            }
        } catch (SQLException e) {
            Logger.getLogger(ManageClass.class.getName()).log(Level.SEVERE, "Error loading slotHocList: " + e.getMessage(), e);
            request.setAttribute("err", "Không thể tải danh sách slot học: " + e.getMessage());
        }

        if ("deleteClass".equalsIgnoreCase(action)) {
            try {
                int idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
                String idKhoaStr = request.getParameter("ID_KhoaHoc");
                String idKhoiStr = request.getParameter("ID_Khoi");
                int idKhoaHoc = (idKhoaStr != null && !idKhoaStr.isEmpty()) ? Integer.parseInt(idKhoaStr) : -1;
                int idKhoi = (idKhoiStr != null && !idKhoiStr.isEmpty()) ? Integer.parseInt(idKhoiStr) : -1;

                // Lấy các tham số chung
                String name = request.getParameter("name");
                if (name == null || name.isEmpty()) {
                    name = null;
                }
                String filterStatus = request.getParameter("filterStatus");
                String sortColumn = request.getParameter("sortColumn");
                String sortOrder = request.getParameter("sortOrder");
                String pageStr = request.getParameter("page");
                int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;

                if (sortColumn == null) {
                    sortColumn = "TenLopHoc";
                }
                if (sortOrder == null) {
                    sortOrder = "asc";
                }

                LopHoc lopHoc = lopHocDAO.getLopHocById(idLopHoc);
                if (lopHoc == null) {
                    response.sendRedirect(request.getContextPath() + "/ManageClass?message=notFound&ID_KhoaHoc=" + idKhoaHoc + "&ID_Khoi=" + idKhoi);
                    return;
                }

                String trangThai = lopHoc.getTrangThai();
                if ("Inactive".equalsIgnoreCase(trangThai)) {
                    // Xóa lịch học liên quan
                    int idSchedule = lopHoc.getID_Schedule();
                    if (idSchedule > 0) { // Kiểm tra idSchedule hợp lệ
                        boolean deletedLichHoc = lichHocDAO.deleteLichHoc(idSchedule);
                        if (!deletedLichHoc) {
                            throw new SQLException("Không thể xóa lịch học liên quan.");
                        }
                    }

                    // Xóa lớp học
                    LopHoc deleted = lopHocDAO.deleteLopHoc(lopHoc);
                    if (deleted != null) {
                        int totalItems = lopHocDAO.countClasses(name, filterStatus, idKhoaHoc, idKhoi);
                        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
                        List<LopHoc> danhSachLopHoc = lopHocDAO.getClassesSortedPaged(sortColumn, sortOrder, name, page, PAGE_SIZE, idKhoaHoc, idKhoi);

                        request.setAttribute("danhSachLopHoc", danhSachLopHoc);
                        request.setAttribute("totalItems", totalItems);
                        request.setAttribute("totalPages", totalPages);
                        request.setAttribute("page", page);
                        request.setAttribute("sortColumn", sortColumn);
                        request.setAttribute("sortOrder", sortOrder);
                        request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                        request.setAttribute("ID_Khoi", idKhoi);
                        request.setAttribute("searchName", name);
                        request.setAttribute("filterStatus", filterStatus);
                        request.setAttribute("suc", "Xóa lớp học thành công!");
                        request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
                    } else {
                        throw new SQLException("Không thể xóa lớp học.");
                    }
                } else {
                    int totalItems = lopHocDAO.countClasses(name, filterStatus, idKhoaHoc, idKhoi);
                    int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
                    List<LopHoc> danhSachLopHoc = lopHocDAO.getClassesSortedPaged(sortColumn, sortOrder, name, page, PAGE_SIZE, idKhoaHoc, idKhoi);

                    request.setAttribute("danhSachLopHoc", danhSachLopHoc);
                    request.setAttribute("totalItems", totalItems);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("page", page);
                    request.setAttribute("sortColumn", sortColumn);
                    request.setAttribute("sortOrder", sortOrder);
                    request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                    request.setAttribute("ID_Khoi", idKhoi);
                    request.setAttribute("searchName", name);
                    request.setAttribute("filterStatus", filterStatus);
                    request.setAttribute("Notdelete", "Không thể xóa do trạng thái hoặc có tham số không phù hợp!");
                    request.getRequestDispatcher("/views/admin/manageClass.jsp").forward(request, response);
                }
            } catch (Exception e) {
                Logger.getLogger(ManageClass.class.getName()).log(Level.SEVERE, "Error in deleteClass action: " + e.getMessage(), e);
                String idKhoaStr = request.getParameter("ID_KhoaHoc");
                String idKhoiStr = request.getParameter("ID_Khoi");
                int idKhoaHoc = (idKhoaStr != null && !idKhoaStr.isEmpty()) ? Integer.parseInt(idKhoaStr) : -1;
                int idKhoi = (idKhoiStr != null && !idKhoiStr.isEmpty()) ? Integer.parseInt(idKhoiStr) : -1;
                response.sendRedirect(request.getContextPath() + "/ManageClass?message=error&ID_KhoaHoc=" + idKhoaHoc + "&ID_Khoi=" + idKhoi);
            }
        } else if ("addClass".equalsIgnoreCase(action)) {
            String tenLopHoc = request.getParameter("TenLopHoc");
            String idSlotHocStr = request.getParameter("ID_SlotHoc");
            String ngayHoc = request.getParameter("NgayHoc");
            String siSoToiDaStr = request.getParameter("SiSoToiDa");
            String ghiChu = request.getParameter("GhiChu");
            String idKhoaHoc = request.getParameter("ID_KhoaHoc");
            String idKhoi = request.getParameter("ID_Khoi");

            // Lưu các giá trị đã nhập để hiển thị lại trong form
            request.setAttribute("tenLopHoc", tenLopHoc);
            request.setAttribute("idSlotHoc", idSlotHocStr);
            request.setAttribute("ngayHoc", ngayHoc);
            request.setAttribute("siSoToiDa", siSoToiDaStr);
            request.setAttribute("ghiChu", ghiChu);
            request.setAttribute("ID_KhoaHoc", idKhoaHoc);
            request.setAttribute("ID_Khoi", idKhoi);

            // Kiểm tra các trường bắt buộc
            if (tenLopHoc == null || tenLopHoc.trim().isEmpty()) {
                request.setAttribute("err", "Vui lòng nhập tên lớp học.");
                request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                return;
            }
            if (idKhoaHoc == null || idKhoaHoc.isEmpty()) {
                request.setAttribute("err", "Thiếu thông tin khóa học (ID_KhoaHoc).");
                request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                return;
            }
            if (idSlotHocStr == null || idSlotHocStr.isEmpty()) {
                request.setAttribute("err", "Vui lòng chọn thời gian học.");
                request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                return;
            }
            if (ngayHoc == null || ngayHoc.isEmpty()) {
                request.setAttribute("err", "Vui lòng chọn ngày học.");
                request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                return;
            }
            if (siSoToiDaStr == null || siSoToiDaStr.isEmpty()) {
                request.setAttribute("err", "Vui lòng nhập sĩ số tối đa.");
                request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                return;
            }

            try {
                int idKhoaHocInt = Integer.parseInt(idKhoaHoc);
                int idSlotHoc = Integer.parseInt(idSlotHocStr);
                int siSoToiDa = Integer.parseInt(siSoToiDaStr);

                // Kiểm tra ngày học không được trước ngày hiện tại
                LocalDate ngayHocDate = LocalDate.parse(ngayHoc);
                LocalDate currentDate = LocalDate.now();
                if (ngayHocDate.isBefore(currentDate)) {
                    request.setAttribute("err", "Ngày học không được trước ngày hiện tại (" + currentDate + ").");
                    request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra tên lớp không trùng
                List<LopHoc> existingClasses = lopHocDAO.getLopHocByKhoaHocAndKhoi(idKhoaHocInt, Integer.parseInt(idKhoi));
                for (LopHoc existingClass : existingClasses) {
                    if (existingClass.getTenLopHoc().equalsIgnoreCase(tenLopHoc)) {
                        request.setAttribute("err", "Tên lớp '" + tenLopHoc + "' đã tồn tại trong khóa học và khối này.");
                        request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                        return;
                    }
                }

                // Kiểm tra ID_SlotHoc hợp lệ
                SlotHoc slotHoc = slotHocDAO.getSlotHocById(idSlotHoc);
                if (slotHoc == null) {
                    request.setAttribute("err", "Thời gian học không hợp lệ.");
                    request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                    return;
                }

                // Xử lý ảnh
                Part filePart = request.getPart("Image");
                String imagePath = "";
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    BufferedImage image = ImageIO.read(filePart.getInputStream());
                    if (image == null) {
                        request.setAttribute("err", "Tệp tải lên không phải là ảnh hợp lệ.");
                        request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                        return;
                    }
                    int width = image.getWidth();
                    int height = image.getHeight();
                    double ratio = (double) height / width;
                    if (ratio < 1.25 || ratio > 1.40) {
                        request.setAttribute("err", "Ảnh phải có tỷ lệ gần 3x4 (VD: 300x400). Kích thước hiện tại: " + width + "x" + height);
                        request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
                        return;
                    }
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "avatar";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    String filePath = uploadPath + File.separator + fileName;
                    filePart.write(filePath);
                    imagePath = "img/avatar/" + fileName;
                }

                // Thêm lớp học
                LopHoc newClass = lopHocDAO.addLopHoc(tenLopHoc, idKhoaHocInt, 0, idSlotHoc, ngayHoc, ghiChu, "Inactive", "0", imagePath, siSoToiDa);
                if (newClass != null) {
                    request.setAttribute("suc", "Thêm lớp học thành công!");
                    // Tải lại danh sách để hiển thị ngay
                    List<LopHoc> danhSachLopHoc = lopHocDAO.getClassesSortedPaged("TenLopHoc", "asc", null, 1, PAGE_SIZE, idKhoaHocInt, Integer.parseInt(idKhoi));
                    int totalItems = lopHocDAO.countClasses(null, null, idKhoaHocInt, Integer.parseInt(idKhoi));
                    int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
                    request.setAttribute("danhSachLopHoc", danhSachLopHoc);
                    request.setAttribute("totalItems", totalItems);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("page", 1);
                    request.setAttribute("sortColumn", "TenLopHoc");
                    request.setAttribute("sortOrder", "asc");
                    request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                    request.setAttribute("ID_Khoi", idKhoi);
                    request.removeAttribute("tenLopHoc");
                    request.removeAttribute("idSlotHoc");
                    request.removeAttribute("ngayHoc");
                    request.removeAttribute("siSoToiDa");
                    request.removeAttribute("ghiChu");
                } else {
                    request.setAttribute("err", "Thêm lớp học thất bại.");
                }
                request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
            } catch (Exception e) {
                Logger.getLogger(ManageClass.class.getName()).log(Level.SEVERE, "Error in addClass action: " + e.getMessage(), e);
                request.setAttribute("err", "Có lỗi xảy ra: " + e.getMessage());
                request.getRequestDispatcher("/views/admin/addClass.jsp").forward(request, response);
            }
        } else if ("submitUpdateClass".equalsIgnoreCase(action)) {
            try {
                int idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
                int idKhoaHoc = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
                int idKhoi = Integer.parseInt(request.getParameter("ID_Khoi"));
                String tenLopHoc = request.getParameter("TenLopHoc");
                String idSlotHocStr = request.getParameter("ID_SlotHoc");
                String ngayHoc = request.getParameter("NgayHoc");
                String siSoStr = request.getParameter("SiSo");
                String siSoToiDaStr = request.getParameter("SiSoToiDa");
                String ghiChu = request.getParameter("GhiChu");
                String trangThai = request.getParameter("TrangThai");

                // Kiểm tra các trường bắt buộc
                if (tenLopHoc == null || tenLopHoc.trim().isEmpty()) {
                    request.setAttribute("err", "Vui lòng nhập tên lớp học.");
                    request.setAttribute("lopHoc", lopHocDAO.getLopHocById(idLopHoc));
                    request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                    return;
                }
                if (idSlotHocStr == null || idSlotHocStr.isEmpty()) {
                    request.setAttribute("err", "Vui lòng chọn thời gian học.");
                    request.setAttribute("lopHoc", lopHocDAO.getLopHocById(idLopHoc));
                    request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                    return;
                }
                if (ngayHoc == null || ngayHoc.isEmpty()) {
                    request.setAttribute("err", "Vui lòng chọn ngày học.");
                    request.setAttribute("lopHoc", lopHocDAO.getLopHocById(idLopHoc));
                    request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                    return;
                }
                if (siSoStr == null || siSoStr.isEmpty()) {
                    request.setAttribute("err", "Vui lòng nhập sĩ số.");
                    request.setAttribute("lopHoc", lopHocDAO.getLopHocById(idLopHoc));
                    request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                    return;
                }
                if (siSoToiDaStr == null || siSoToiDaStr.isEmpty()) {
                    request.setAttribute("err", "Vui lòng nhập sĩ số tối đa.");
                    request.setAttribute("lopHoc", lopHocDAO.getLopHocById(idLopHoc));
                    request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                    return;
                }

                int idSlotHoc = Integer.parseInt(idSlotHocStr);
                int siSo = Integer.parseInt(siSoStr);
                int siSoToiDa = Integer.parseInt(siSoToiDaStr);

                // Kiểm tra ID_SlotHoc hợp lệ
                SlotHoc slotHoc = slotHocDAO.getSlotHocById(idSlotHoc);
                if (slotHoc == null) {
                    request.setAttribute("err", "Thời gian học không hợp lệ.");
                    request.setAttribute("lopHoc", lopHocDAO.getLopHocById(idLopHoc));
                    request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                    return;
                }

                // Lấy thông tin lớp học hiện tại
                LopHoc oldData = lopHocDAO.getLopHocById(idLopHoc);
                String imagePath = oldData.getImage();

                // Xử lý ảnh
                Part filePart = request.getPart("Image");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    BufferedImage image = ImageIO.read(filePart.getInputStream());
                    if (image == null) {
                        request.setAttribute("err", "Tệp tải lên không phải là ảnh hợp lệ.");
                        request.setAttribute("lopHoc", oldData);
                        request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                        return;
                    }
                    int width = image.getWidth();
                    int height = image.getHeight();
                    double ratio = (double) height / width;
                    if (ratio < 1.25 || ratio > 1.40) {
                        request.setAttribute("err", "Ảnh phải có tỷ lệ gần 3x4 (VD: 300x400). Kích thước hiện tại: " + width + "x" + height);
                        request.setAttribute("lopHoc", oldData);
                        request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                        return;
                    }
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "avatar";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    String filePath = uploadPath + File.separator + fileName;
                    filePart.write(filePath);
                    imagePath = "img/avatar/" + fileName;
                }

                // Cập nhật lịch học
                int idSchedule = oldData.getID_Schedule();
                if (idSchedule <= 0) {
                    LichHoc lichHoc = lichHocDAO.addLichHoc(LocalDate.parse(ngayHoc), idSlotHoc, ghiChu);
                    if (lichHoc == null) {
                        request.setAttribute("err", "Không thể tạo lịch học.");
                        request.setAttribute("lopHoc", oldData);
                        request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                        return;
                    }
                    idSchedule = lichHoc.getIdSchedule();
                } else {
                    boolean updatedLichHoc = lichHocDAO.updateLichHoc(idSchedule, LocalDate.parse(ngayHoc), idSlotHoc, ghiChu);
                    if (!updatedLichHoc) {
                        request.setAttribute("err", "Không thể cập nhật lịch học.");
                        request.setAttribute("lopHoc", oldData);
                        request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
                        return;
                    }
                }

                // Cập nhật lớp học
                LopHoc updated = lopHocDAO.updateLopHoc(idLopHoc, tenLopHoc, idKhoaHoc, siSo, idSchedule, ghiChu, trangThai, "0", imagePath, siSoToiDa);
                if (updated != null) {
                    request.setAttribute("suc", "Cập nhật thành công!");
                    // Tải lại danh sách để hiển thị ngay
                    List<LopHoc> danhSachLopHoc = lopHocDAO.getClassesSortedPaged("TenLopHoc", "asc", null, 1, PAGE_SIZE, idKhoaHoc, idKhoi);
                    int totalItems = lopHocDAO.countClasses(null, null, idKhoaHoc, idKhoi);
                    int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
                    request.setAttribute("danhSachLopHoc", danhSachLopHoc);
                    request.setAttribute("totalItems", totalItems);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("page", 1);
                    request.setAttribute("sortColumn", "TenLopHoc");
                    request.setAttribute("sortOrder", "asc");
                    request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                    request.setAttribute("ID_Khoi", idKhoi);
                } else {
                    request.setAttribute("err", "Cập nhật thất bại.");
                    request.setAttribute("lopHoc", oldData);
                }
                request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
            } catch (Exception e) {
                Logger.getLogger(ManageClass.class.getName()).log(Level.SEVERE, "Error in submitUpdateClass action: " + e.getMessage(), e);
                request.setAttribute("err", "Lỗi hệ thống: " + e.getMessage());
                request.getRequestDispatcher("/views/admin/updateClass.jsp").forward(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing classes";
    }
}