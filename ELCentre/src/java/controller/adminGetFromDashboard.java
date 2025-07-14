package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import dal.GiaoVienDAO;
import model.HocPhi;
import dal.HocPhiDAO;
import model.ThongBao;
import dal.ThongBaoDAO;
import dal.KhoaHocDAO;
import model.KhoaHoc;
import model.TaiKhoanChiTiet;
import dal.TaiKhoanChiTietDAO;
import model.GiaoVien_TruongHoc;
import model.HocSinh_SDT;
import dal.HocSinh_SDTDAO;
import model.GiaoVien_ChiTietDay;

/**
 * Created on:May 24 , 2025 11:48:56 PM
 *
 * @author: chuvv This servlet do all action admin do in dashboard , like when
 * admin click in manage Users or all thing in admin dashboard , servlet can
 * create ArrayList to save data from database and send this data to specific
 * JSP to show for admin
 */
public class adminGetFromDashboard extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet adminGetFromDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminGetFromDashboard at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");       //get paramerter from adminDashboard
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        switch (action) {
            case "taikhoan":            //action with account
                ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName();    //admin get All acount from database

                if (taikhoans == null) {
                    request.setAttribute("message", "Không có tài khoản nào.");
                    request.setAttribute("taikhoans", taikhoans);
                    request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                } else {
                    session.setAttribute("taikhoans", taikhoans);       //create object is taikhoans to send data for jsp
                    request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);          //redirect to jsp
                }

                break;

            case "hocsinh":       //action with student
                ArrayList<HocSinh_SDT> hocsinhs = new ArrayList<HocSinh_SDT>();          // create arraylist to save data 
                hocsinhs = HocSinh_SDTDAO.adminGetSoDienThoaiHocSinh();                //admin get All student from database
                if (hocsinhs == null) {                                    // get database fail
                    request.setAttribute("message", "Không có tài khoản nào.");
                    request.setAttribute("hocsinhs", hocsinhs);
                    request.getRequestDispatcher("/views/admin/adminReceiveHocSinh.jsp").forward(request, response);

                } else {                                                    // get database success
                    session.setAttribute("hocsinhs", hocsinhs);          //create object is hocsinhs to send data for jsp
                    request.getRequestDispatcher("/views/admin/adminReceiveHocSinh.jsp").forward(request, response);          //redirect to  adminReceiveHocSinh jsp
                }

                break;

            case "giaovien":        //action with teacher 
                ArrayList<GiaoVien_TruongHoc> giaoviens = new ArrayList<GiaoVien_TruongHoc>();
                giaoviens = GiaoVienDAO.admminGetAllGiaoVien();

                if (giaoviens == null) {                                 // get database fail
                    request.setAttribute("message", "Không có tài khoản nào.");
                    request.setAttribute("giaoviens", giaoviens);
                    request.getRequestDispatcher("/views/admin/adminReceiveGiaoVien.jsp").forward(request, response);
                } else {                                                // get database success
                    session.setAttribute("giaoviens", giaoviens);            //create object is giaoviens to send data for jsp
                    request.getRequestDispatcher("/views/admin/adminReceiveGiaoVien.jsp").forward(request, response);      //redirect to adminReceiveGiaoVien jsp
                }

                break;

            case "hocphi":       //action with tuition
                ArrayList<HocPhi> hocphis = HocPhiDAO.adminGetHocPhi();          //admin get All tuition from database
                if (hocphis.isEmpty()) {                // get database fail
                    request.setAttribute("message", "Không có biểu học phí nào.");
                    request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);
                } else {                                 // get database success
                    request.setAttribute("hocphis", hocphis);            //create object is hocphis to send data for jsp
                    request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);      //redirect to adminReceiveHocPhi jsp
                }
                break;
            case "thongbao":            //action with notifications
                ArrayList<GiaoVien_ChiTietDay> lophocs = ThongBaoDAO.adminGetAllLopHocDangHocToSendThongBao();        //admin get All notifications from database
                if (lophocs.isEmpty()) {
                    request.setAttribute("message", "Không có lớp học nào để gử thông báo.");
                    request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);
                } else {
                    session.setAttribute("lophocs", lophocs);
                    request.getRequestDispatcher("/views/admin/adminReceiveThongBao.jsp").forward(request, response);            //redirect to adminReceiveThongBao jsp    
                }
                break;

            case "khoahoc":         //action with course
                ArrayList<KhoaHoc> khoahocs = KhoaHocDAO.adminGetAllKhoaHoc();      //admin get All course from database     
                if (khoahocs.isEmpty()) {                                     // get database fail
                    request.setAttribute("message", "Không có thông báo nào đã được gửi.");
                    request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);
                } else {                              // get database success    
                    request.setAttribute("khoahocs", khoahocs);                //create object is thongbaos to send data for jsp
                    request.getRequestDispatcher("/views/admin/adminReceiveKhoaHoc.jsp").forward(request, response);         //redirect to adminReceiveThongBao jsp    
                }
                break;

            case "yeucautuvan": //action xử lý phê duyệt yêu cầu
                ArrayList<ThongBao> listTuVan = ThongBaoDAO.getAllTuVan();
                if (listTuVan == null || listTuVan.isEmpty()) {
                    request.setAttribute("message", "Không có yêu cầu tư vấn nào.");
                    request.getRequestDispatcher("/views/admin/adminApproveRegisterUser.jsp").forward(request, response);
                } else {
                    request.setAttribute("listTuVan", listTuVan);
                    request.getRequestDispatcher("/views/admin/adminApproveRegisterUser.jsp").forward(request, response);

                }
                break;

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
