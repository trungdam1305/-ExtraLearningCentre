/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.HocPhiDAO;
import dal.ThongBaoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.GiaoVien_ChiTietDay;
import model.HocPhi;
import model.TinhHocPhi;

/**
 *
 * @author wrx_Chur04
 */
public class adminActionWithTuition extends HttpServlet {
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet adminActionWithTuition</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminActionWithTuition at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "view":
                doViewInfor(request, response);
                break;

            case "kettoan":
                doKetToanThangNay(request, response);
                break;

            case "dongtien":
                doDongTien(request, response);
                break;

            case "guithongbao":
                doSendThongBao(request, response);
                break;

            case "guitgonbaotoanbo":
                doGuiThongBaoToanBo(request, response);
                break;

            case "filterClass":
                dofilterClass(request, response);
                break;
                
            case "filterHocPhi" : 
                doFilterHocPhi(request, response) ; 
                break ; 
        }
    }

    protected void doFilterHocPhi(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ID_LopHoc = request.getParameter("idLop");
        String TenLopHoc = request.getParameter("TenLopHoc");
        String thang = request.getParameter("thang") ; 
        String nam = request.getParameter("nam") ; 
        String keyword = request.getParameter("keyword") ; 
        if (keyword == null) keyword = "";

        PrintWriter out = response.getWriter();
        
        ArrayList<HocPhi> hocphis = HocPhiDAO.adminGetAllInforByThangNam(ID_LopHoc , thang , nam , keyword);

        if (hocphis != null) {
            request.getSession().setAttribute("tenlop", TenLopHoc);
            request.setAttribute("hocphis", hocphis);
            request.getRequestDispatcher("/views/admin/adminViewHocPhiTheoLopHoc.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Không có biểu học phí nào phù hợp với tìm kiếm");
            request.getRequestDispatcher("/views/admin/adminViewHocPhiTheoLopHoc.jsp").forward(request, response);
        }
    }
    
    protected void dofilterClass(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        request.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");
        String khoi = request.getParameter("khoi");
        String mon = request.getParameter("mon");
        String trangthai = request.getParameter("trangthai");

        if (keyword == null) {
            keyword = "";
        }
        if (khoi == null) {
            khoi = "";
        }
        if (mon == null) {
            mon = "";
        }
        if (trangthai == null) {
            trangthai = "";
        }
        keyword = keyword.trim();
        if (keyword.equals("") && khoi.equals("") && mon.equals("") && trangthai.equals("")) {
            ArrayList<GiaoVien_ChiTietDay> lophocs1 = HocPhiDAO.adminGetAllLopHocDangHocToSendHocPhi();
            if (lophocs1.isEmpty()) {
                request.setAttribute("message", "Không có lớp học nào để gửi học phí.");
                request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);
            } else {
                session.setAttribute("lophocs1", lophocs1);
                request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);
            }
        } else {
            ArrayList<GiaoVien_ChiTietDay> lophocs1 = HocPhiDAO.adminGetAllLopHocHocPhiByFilter(trangthai, keyword, khoi, mon);
            if (lophocs1 == null || lophocs1.isEmpty()) {
                request.setAttribute("message", "Không có lớp học nào khớp với tìm kiếm");
                request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);
            } else {
                session.setAttribute("lophocs1", lophocs1);
                request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);
            }
        }

    }

    protected void doDongTien(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ID_LopHoc = request.getParameter("idLop");
        String ID_HocSinh = request.getParameter("idHocSinh");
        String thang = request.getParameter("thang");
        String nam = request.getParameter("nam");
        String soTienDong = request.getParameter("soTienDong");
        String TenLopHoc = (String) request.getSession().getAttribute("tenlop");

        PrintWriter out = response.getWriter();

        boolean s1 = HocPhiDAO.adminDongCapNhatDongTien(ID_HocSinh, thang, nam, ID_LopHoc, soTienDong);
        if (s1 == true) {
            ArrayList<HocPhi> hocphis = HocPhiDAO.adminGetAllInforToViewHocPhi(ID_LopHoc);
            request.getSession().setAttribute("tenlop", TenLopHoc);
            request.setAttribute("hocphis", hocphis);
            request.getRequestDispatcher("/views/admin/adminViewHocPhiTheoLopHoc.jsp").forward(request, response);
        }

    }

    protected void doSendThongBao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenlop = (String) request.getSession().getAttribute("tenlop");
        String ID_TKHocSinh = request.getParameter("idTaiKhoanHocSinh");
        String sdtPhuHuynh = request.getParameter("sodienthoai");
        String thang = request.getParameter("thang");
        String nam = request.getParameter("nam");
        String soTienDong = request.getParameter("soTienDong");
        String TenHocSinh = request.getParameter("TenHocSinh");
        String ID_TKPhuHuynh = HocPhiDAO.adminGetID_TaiKhoanPHToGuiThongBao(sdtPhuHuynh);
        request.setAttribute("TenHocSinh", TenHocSinh);
        request.getSession().setAttribute("tenlop", tenlop);
        request.setAttribute("soTienDong", soTienDong);
        request.setAttribute("thang", thang);
        request.setAttribute("nam", nam);
        request.setAttribute("ID_TKPhuHuynh", ID_TKPhuHuynh);
        request.setAttribute("ID_TKHocSinh", ID_TKHocSinh);
        request.getRequestDispatcher("/views/admin/adminSendTBAOHocPhiChoPHHS.jsp").forward(request, response);

    }

    protected void doGuiThongBaoToanBo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<TinhHocPhi> hocphis = HocPhiDAO.adminGetInforToGuiThongBaoDenTatCa();
        for (TinhHocPhi hoc : hocphis) {
            String tenhocsinh = hoc.getHoTen();
            String tenlophoc = hoc.getTenLopHoc();
            int thang = hoc.getThang();
            int nam = hoc.getNam();
            int soTien = hoc.getHocPhiPhaiDong();
            int idTaiKhoanHS = hoc.getID_TaiKhoan();
            int idTaiKhoanPH = hoc.getID_TaiKhoanPH();

            String noidungPH = String.format("""
            Kính gửi quý phụ huynh,

            Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh %s – lớp %s cho tháng %d/%d như sau:

            Số tiền cần đóng: %,d VNĐ

            Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

            Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
            """, tenhocsinh, tenlophoc, thang, nam, soTien);

            String noidungHS = String.format("""
            Chào em %s,

            Đây là thông báo học phí tháng %d/%d của em tại lớp %s. Số tiền: %,d VNĐ.

            Chúc em học tập tốt và đạt kết quả cao nhé!

            – ELCENTRE –
            """, tenhocsinh, thang, nam, tenlophoc, soTien);

            boolean s1 = ThongBaoDAO.adminSendNotification(String.valueOf(idTaiKhoanHS), noidungHS, "STUDENT");

            boolean s2 = ThongBaoDAO.adminSendNotification(String.valueOf(idTaiKhoanPH), noidungPH, "PARENT");

        }
        HttpSession session = request.getSession();
        ArrayList<GiaoVien_ChiTietDay> lophocs1 = HocPhiDAO.adminGetAllLopHocDangHocToSendHocPhi();

        request.setAttribute("message", "Đã gửi thông báo học phí đến toàn bộ học sinh trong các lớp học!");
        session.setAttribute("lophocs1", lophocs1);
        request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);

    }

    protected void doViewInfor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ID_LopHoc = request.getParameter("idLop");
        String TenLopHoc = request.getParameter("TenLopHoc");
        PrintWriter out = response.getWriter();

        ArrayList<HocPhi> hocphis = HocPhiDAO.adminGetAllInforToViewHocPhi(ID_LopHoc);

        if (hocphis != null) {
            request.getSession().setAttribute("tenlop", TenLopHoc);
            request.setAttribute("hocphis", hocphis);
            request.getRequestDispatcher("/views/admin/adminViewHocPhiTheoLopHoc.jsp").forward(request, response);
        }
    }

    protected void doKetToanThangNay(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        boolean s1 = HocPhiDAO.adminKetToanThangNay();
        ArrayList<GiaoVien_ChiTietDay> lophocs1 = HocPhiDAO.adminGetAllLopHocDangHocToSendHocPhi();
        if (s1) {
            request.setAttribute("message", "Kết toán tháng này thành công!");
            session.setAttribute("lophocs1", lophocs1);
            request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Đã kết toán tháng này!");
            session.setAttribute("lophocs1", lophocs1);
            request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String ID_TKHS = request.getParameter("ID_TKHocSinh");
        String ID_TKPH = request.getParameter("ID_TKPhuHuynh");
        String contentPH = request.getParameter("contentPH");
        String contentHS = request.getParameter("contentHS");
        boolean s1 = ThongBaoDAO.adminSendNotification(ID_TKHS, contentHS, "STUDENT");
        boolean s2 = ThongBaoDAO.adminSendNotification(ID_TKPH, contentPH, "PARENT");
        if (s1 && s2) {
            ArrayList<GiaoVien_ChiTietDay> lophocs1 = HocPhiDAO.adminGetAllLopHocDangHocToSendHocPhi();
            request.setAttribute("message", "Gửi thông báo thanhg công! ");
            session.setAttribute("lophocs1", lophocs1);
            request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);

        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
