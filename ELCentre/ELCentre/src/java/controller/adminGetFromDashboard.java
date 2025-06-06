/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.TaiKhoan;
import dal.TaiKhoanDAO;
import model.HocSinh;
import dal.HocSinhDAO;
import model.GiaoVien;
import dal.GiaoVienDAO;
import model.HocPhi;
import dal.HocPhiDAO;
import model.ThongBao ; 
import dal.ThongBaoDAO ; 
import dal.KhoaHocDAO ; 
import model.KhoaHoc ; 
import model.TaiKhoanChiTiet ; 
import dal.TaiKhoanChiTietDAO ; 

/**
 *
 * @author wrx_Chur04
 */
public class adminGetFromDashboard extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
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
        String action = request.getParameter("action");         //get paramerter to know action with what ? 
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        switch (action) {
            case "taikhoan":            //action with account
                ArrayList<TaiKhoanChiTiet> taikhoans = new ArrayList<TaiKhoanChiTiet>();  // create arraylist to save data 
                taikhoans =    TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName() ;            //admin get All acount from database
                if (taikhoans == null ) {                                  // get database fail
                    request.setAttribute("message", "Không có tài khoản nào.");
                    request.setAttribute("taikhoans", taikhoans);
                    request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                } else {                                                     // get database success
                    session.setAttribute("taikhoans", taikhoans);       //create object is taikhoans to send data for jsp
                    request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);          //redirect to jsp
                }

                break;
                
            case "pheduyettuvan":
                ArrayList<ThongBao> tuvanList = ThongBaoDAO.getAllTuVan();
                request.setAttribute("tuvanList", tuvanList);
                request.getRequestDispatcher("/views/admin/adminApproveRegisterUser.jsp").forward(request, response);
          
                break;
                
                
            case "approveAdvice":
                int id = Integer.parseInt(request.getParameter("id"));
                ThongBao tb = ThongBaoDAO.getThongBaoById(id);
                
                String content = tb.getNoiDung();
                String name = extract(content, "Họ tên: ", ", Email:");
                String email = extract(content, "Email: ", ", SDT:");
                String phone = extract(content, "SDT: ", ", Nội dung:");
                String message = extract(content, "Nội dung: ", "");
                
                request.setAttribute("tuvanid", id);
                request.setAttribute("name", name);
                request.setAttribute("email", email);
                request.setAttribute(phone, phone);
                request.setAttribute(message, message);
                request.getRequestDispatcher("/views/admin/CreateAccountFromAdvice.jsp").forward(request, response);
                
                break;

            case "hocsinh":       //action with student
                ArrayList<HocSinh> hocsinhs = new ArrayList<HocSinh>();          // create arraylist to save data 
                hocsinhs = HocSinhDAO.adminGetAllHocSinh();                 //admin get All student from database
                if (hocsinhs.isEmpty()) {                                    // get database fail
                    request.setAttribute("message", "Không có tài khoản nào.");
                    request.setAttribute("hocsinhs", hocsinhs);
                    request.getRequestDispatcher("/views/admin/adminReceiveHocSinh.jsp").forward(request, response);
                } else {                                                    // get database success
                    request.setAttribute("hocsinhs", hocsinhs);          //create object is hocsinhs to send data for jsp
                    request.getRequestDispatcher("/views/admin/adminReceiveHocSinh.jsp").forward(request, response);          //redirect to  adminReceiveHocSinh jsp
                }

                break;

            case "giaovien":        //action with student
                ArrayList<GiaoVien> giaoviens = new ArrayList<GiaoVien>();       // create arraylist to save data 
                giaoviens = GiaoVienDAO.admminGetAllGiaoVien();          //admin get All teacher from database
                if (giaoviens == null) {                                 // get database fail
                    request.setAttribute("message", "Không có tài khoản nào.");
                    request.setAttribute("giaoviens", giaoviens);
                    request.getRequestDispatcher("/views/admin/adminReceiveGiaoVien.jsp").forward(request, response);
                } else {                                                // get database success
                    request.setAttribute("giaoviens", giaoviens);            //create object is giaoviens to send data for jsp
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
                    ArrayList<ThongBao> thongbaos = ThongBaoDAO.adminXemThongBao() ;        //admin get All notifications from database
                    if (thongbaos.isEmpty()) {                                              // get database fail
                        request.setAttribute("message", "Không có thông báo nào đã được gửi.");
                        request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);
                    } else {                     // get database success    
                        request.setAttribute("thongbaos",   thongbaos);             //create object is thongbaos to send data for jsp
                        request.getRequestDispatcher("/views/admin/adminReceiveThongBao.jsp").forward(request, response);            //redirect to adminReceiveThongBao jsp    
                    }
                    break;
                    
                    
                case "khoahoc" :         //action with course
                    ArrayList<KhoaHoc> khoahocs = KhoaHocDAO.adminGetAllKhoaHoc() ;      //admin get All course from database     
                    if (khoahocs.isEmpty()) {                                     // get database fail
                        request.setAttribute("message", "Không có thông báo nào đã được gửi.");
                        request.getRequestDispatcher("/views/admin/adminReceiveHocPhi.jsp").forward(request, response);
                    } else {                              // get database success    
                        request.setAttribute("khoahocs",   khoahocs);                //create object is thongbaos to send data for jsp
                        request.getRequestDispatcher("/views/admin/adminReceiveKhoaHoc.jsp").forward(request, response);         //redirect to adminReceiveThongBao jsp    
                    }
                    break;
                    

        }
        
        private String extract(String full, String start, String end) {
            int s = full.indexOf(start);
            if (s == -1) return "";
            s += start.length();
            int e = end.isEmpty() ? full.length() : full.indexOf(end, s);
            if (e == -1) e = full.length();
            return full.substring(s, e).trim();
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
    }// </editor-fold>

}
