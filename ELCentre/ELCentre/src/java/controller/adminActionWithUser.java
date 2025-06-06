package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.GiaoVien;
import model.HocSinh;
import dal.HocSinhDAO;
import dal.GiaoVienDAO;
import model.PhuHuynh;
import dal.PhuHuynhDAO;
import dal.TaiKhoanChiTietDAO;
import model.TaiKhoan;
import dal.TaiKhoanDAO;
import jakarta.servlet.http.HttpSession;
import model.TaiKhoanChiTiet;

/**
 *
 * @author wrx_Chur04
 */
public class adminActionWithUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet adminActionWithUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminActionWithUser at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        PrintWriter out = response.getWriter();
        String type = request.getParameter("type");
        String id = request.getParameter("id");
        switch (action) {

            case "view":    // view detail information of user

                if (type.equalsIgnoreCase("GiaoVien")) {    //if user is teacher

                    ArrayList<GiaoVien> giaoviens = GiaoVienDAO.adminGetGiaoVienByID(id); // call method to get data from database 
                    if (giaoviens.isEmpty()) {                                              // if can not get data from database
                        request.setAttribute("message", "Không tìm thấy thông tin giáo viên này.");
                        request.getRequestDispatcher("/views/admin/adminReceiveTeacherInfor.jsp").forward(request, response); // redirect to adminReceiveTeacherInfor.jsp

                    } else {
                        request.setAttribute("giaoviens", giaoviens);   //set object is giaoviens for jsp can get this 
                        request.getRequestDispatcher("/views/admin/adminReceiveTeacherInfor.jsp").forward(request, response);   // redirect to adminReceiveTeacherInfor.jsp
                    }

                } else if (type.equalsIgnoreCase("HocSinh")) {  //if user is student
                    ArrayList<HocSinh> hocsinhs = new ArrayList<HocSinh>(); // create arraylist to save data 
                    hocsinhs = HocSinhDAO.adminGetHocSinhByID(id);  // call method to get data from database 
                    if (hocsinhs.isEmpty()) {                       // if can not get data from database
                        request.setAttribute("message", "Không tìm thấy thông tin học sinh này.");
                        request.getRequestDispatcher("/views/admin/adminReceiveStudentInfor.jsp").forward(request, response);   // redirect to adminReceiveStudentInfor.jsp
                    } else {
                        request.setAttribute("hocsinhs", hocsinhs);      //set object is hocsinhs for jsp can get this 
                        request.getRequestDispatcher("/views/admin/adminReceiveStudentInfor.jsp").forward(request, response);    // redirect to adminReceiveStudentInfor.jsp
                    }
                } else if (type.equalsIgnoreCase("PhuHuynh")) {     //if user is parent of student  
                    ArrayList<PhuHuynh> phuhuynhs = PhuHuynhDAO.adminGetPhuHuynhByID(id);       // call method to get data from database 
                    if (phuhuynhs.isEmpty()) {                                          // if can not get data from database
                        request.setAttribute("message", "Không tìm thấy thông tin phụ huyunh này.");
                        request.getRequestDispatcher("/views/admin/adminReceiveParentInfor.jsp").forward(request, response);    // redirect to adminReceiveParentInfor.jsp
                    } else {
                        request.setAttribute("phuhuynhs", phuhuynhs);             //set object is phuhuynhs for jsp can get this      
                        request.getRequestDispatcher("/views/admin/adminReceiveParentInfor.jsp").forward(request, response);    // redirect to adminReceiveParentInfor.jsp
                    }   
                }
                break;

            case "enable":      //admin enable account
                if (type.equalsIgnoreCase("GiaoVien")) {    //if user is teacher

                    boolean b2 = TaiKhoanDAO.adminEnableAccountUser(id); //admin enable in table account
                    boolean b1 = GiaoVienDAO.adminEnableGiaoVien(id);   //admin enable in table of this user
                    if (b1 == true && b2 == true) {                     //if 2 method is access
                        ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName() ;  //admin call method this to get all account after update
                        session.setAttribute("taikhoans", taikhoans);           //set object for jsp can get it again
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);      //redirect to adminReceiveUsers
                    } else {
                        request.setAttribute("message", "Không có tài khoản nào.");     

                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);      
                    }
                } else if (type.equalsIgnoreCase("HocSinh")) {       //if user is student
                    boolean b1 = TaiKhoanDAO.adminEnableAccountUser(id);        //admin enable in table account
                    boolean b2 = HocSinhDAO.adminEnableHocSinh(id);             //admin enable in table of this user
                    if (b1 == true && b2 == true) {                               //if 2 method is access
                        ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName() ;    //admin call method this to get all account after update
                        session.setAttribute("taikhoans", taikhoans);           //set object for jsp can get it again
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);       //redirect to adminReceiveUsers
                    } else {
                        request.setAttribute("message", "Không có tài khoản nào.");

                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                    }
                } else if (type.equalsIgnoreCase("PhuHuynh")) {     //if user is parent of student 
                    boolean b1 = TaiKhoanDAO.adminEnableAccountUser(id);     //admin enable in table account
                    boolean b2 = PhuHuynhDAO.adminEnablePhuHuynh(id);       //admin enable in table of this user
                    if (b1 == true && b2 == true) {                         //if 2 method is access
                       ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName() ;     //admin call method this to get all account after update
                        session.setAttribute("taikhoans", taikhoans);                       //set object for jsp can get it again
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);       //redirect to adminReceiveUsers
                    } else {
                        request.setAttribute("message", "Không có tài khoản nào.");

                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                    }
                } else if (type.equalsIgnoreCase("Staff")) {         //if user is parent of staff
                    boolean b1 = TaiKhoanDAO.adminEnableAccountUser(id);         //admin enable in table account
                    if (b1 == true) {
                        out.print("okok123");
                    } else {
                        out.print("huhuhu");
                    }
                }
                break;

            case "disable":   // admin disnable user 
                if (type.equalsIgnoreCase("GiaoVien")) {         //if user is teacher

                    boolean b2 = TaiKhoanDAO.adminDisableAccountUser(id);    //admin disnable in table account
                    boolean b1 = GiaoVienDAO.adminDisableGiaoVien(id);            //admin disnable in table of this user
                    if (b1 == true && b2 == true) {                           //if 2 method is access
                       ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName() ;   //admin call method this to get all account after update
                        session.setAttribute("taikhoans", taikhoans);            //set object for jsp can get it again
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);       //redirect to adminReceiveUsers  
                    } else {
                        out.print("huhuhu");
                    }
                } else if (type.equalsIgnoreCase("HocSinh")) {      //if user is student
                    boolean b1 = TaiKhoanDAO.adminDisableAccountUser(id);       //admin disnable in table account
                    boolean b2 = HocSinhDAO.adminDisableHocSinh(id);            //admin disnable in table of this user
                    if (b1 == true && b2 == true) {                             //if 2 method is access
                       ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName() ;        //admin call method this to get all account after update
                        session.setAttribute("taikhoans", taikhoans);               //set object for jsp can get it again
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);      //redirect to adminReceiveUsers  
                    } else {        
                        out.print("huhuhu");
                    }
                } else if (type.equalsIgnoreCase("PhuHuynh")) {          //if user is parent of student
                    boolean b1 = TaiKhoanDAO.adminDisableAccountUser(id);    //admin disnable in table account
                    boolean b2 = PhuHuynhDAO.adminDisablePhuHuynh(id);       //admin disnable in table of this user
                    if (b1 == true && b2 == true) {                       //if 2 method is access
                        ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName() ;     //admin call method this to get all account after update
                        session.setAttribute("taikhoans", taikhoans);                //set object for jsp can get it again
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);       //redirect to adminReceiveUsers  
                    } else {
                        out.print("huhuhu");
                    }
                } else if (type.equalsIgnoreCase("Staff")) {        //if user is staff
                    boolean b1 = TaiKhoanDAO.adminDisableAccountUser(id);       //admin disnable in table account
                    if (b1 == true) {
                        out.print("okok123");
                    } else {
                        out.print("huhuhu");
                    }
                }
                break;
                
                
            case "update" : 
                if (type.equalsIgnoreCase("GiaoVien")) {    //if user is teacher

                    ArrayList<GiaoVien> giaoviens = GiaoVienDAO.adminGetGiaoVienByID(id); // call method to get data from database 
                    if (giaoviens.isEmpty()) {                                              // if can not get data from database
                        request.setAttribute("message", "Không tìm thấy thông tin giáo viên này.");
                        request.getRequestDispatcher("/views/admin/adminUpdateTeacherInfor.jsp").forward(request, response); // redirect to adminReceiveTeacherInfor.jsp

                    } else {
                        request.setAttribute("giaoviens", giaoviens);   //set object is giaoviens for jsp can get this 
                        request.setAttribute("type", type);  // set type to send to the jsp and continue send to the servlet
                        request.getRequestDispatcher("/views/admin/adminUpdateTeacherInfor.jsp").forward(request, response);   // redirect to adminReceiveTeacherInfor.jsp
                    }

                } else if (type.equalsIgnoreCase("HocSinh")) {  //if user is student
                    ArrayList<HocSinh> hocsinhs = new ArrayList<HocSinh>(); // create arraylist to save data 
                    hocsinhs = HocSinhDAO.adminGetHocSinhByID(id);  // call method to get data from database 
                    if (hocsinhs.isEmpty()) {                       // if can not get data from database
                        request.setAttribute("message", "Không tìm thấy thông tin học sinh này.");
                        request.getRequestDispatcher("/views/admin/adminReceiveStudentInfor.jsp").forward(request, response);   // redirect to adminReceiveStudentInfor.jsp
                    } else {
                        request.setAttribute("hocsinhs", hocsinhs);      //set object is hocsinhs for jsp can get this 
                        request.getRequestDispatcher("/views/admin/adminReceiveStudentInfor.jsp").forward(request, response);    // redirect to adminReceiveStudentInfor.jsp
                    }
                } else if (type.equalsIgnoreCase("PhuHuynh")) {     //if user is parent of student  
                    ArrayList<PhuHuynh> phuhuynhs = PhuHuynhDAO.adminGetPhuHuynhByID(id);       // call method to get data from database 
                    if (phuhuynhs.isEmpty()) {                                          // if can not get data from database
                        request.setAttribute("message", "Không tìm thấy thông tin phụ huyunh này.");
                        request.getRequestDispatcher("/views/admin/adminReceiveParentInfor.jsp").forward(request, response);    // redirect to adminReceiveParentInfor.jsp
                    } else {
                        request.setAttribute("phuhuynhs", phuhuynhs);             //set object is phuhuynhs for jsp can get this      
                        request.getRequestDispatcher("/views/admin/adminReceiveParentInfor.jsp").forward(request, response);    // redirect to adminReceiveParentInfor.jsp
                    }   
                }
                break ; 

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type") ; 
        PrintWriter out = response.getWriter() ; 
       
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
