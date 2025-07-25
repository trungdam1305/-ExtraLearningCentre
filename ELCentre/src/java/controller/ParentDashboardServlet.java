package controller;

import dal.*;
import model.*;
import java.io.IOException;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class ParentDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // Kiểm tra login và vai trò phụ huynh
        if (user == null || user.getID_VaiTro() != 5) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int idTaiKhoan = user.getID_TaiKhoan();
        
        // Lấy thông tin phụ huynh
        PhuHuynh phuHuynh = PhuHuynhDAO.getPhuHuynhByTaiKhoanId(idTaiKhoan);
        String sdtPhuHuynh = phuHuynh.getSDT(); // Giả sử sdt không null

        // Lấy danh sách học sinh con liên kết với phụ huynh
        List<HocSinh> dsCon = HocSinhDAO.getHocSinhByPhuHuynhPhone(sdtPhuHuynh);

        for (HocSinh hs : dsCon) {
            List<LopHoc> dsLop = HocSinh_LopHocDAO.getLopHocDaDangKyByHocSinhId(hs.getID_HocSinh());
            hs.setLopDaDangKy(dsLop); // Bổ sung field này vào model HocSinh để phục vụ hiển thị
        }
        
        List<LichHoc> lichHocSapToi = new ArrayList<>();
        for (HocSinh hs : dsCon) {
            List<LichHoc> lichCuaCon = LichHocDAO.getUpcomingScheduleByHocSinhId(hs.getID_HocSinh());
            for (LichHoc lh : lichCuaCon) {
                lh.setTenHocSinh(hs.getHoTen()); // 👈 cần thêm thuộc tính này vào model `LichHoc`
            }
            lichHocSapToi.addAll(lichCuaCon);
        }



        // Lấy thông báo dành cho phụ huynh
        List<ThongBao> dsThongBao = ThongBaoDAO.getThongBaoByTaiKhoanId(idTaiKhoan);

        // Truyền dữ liệu qua JSP
        request.setAttribute("lichHocSapToi", lichHocSapToi);
        request.setAttribute("phuHuynhInfo", phuHuynh);
        request.setAttribute("dsCon", dsCon);
        request.setAttribute("dsThongBao", dsThongBao);

        request.getRequestDispatcher("/views/parent/parentDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet hiển thị dashboard phụ huynh";
    }
}
