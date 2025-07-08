package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.HocSinh;
import dal.HocSinhDAO;
import dal.GiaoVienDAO;
import model.PhuHuynh;
import dal.PhuHuynhDAO;
import dal.TaiKhoanChiTietDAO;
import dal.TaiKhoanDAO;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;
import model.TaiKhoanChiTiet;
import model.GiaoVien_TruongHoc;
import model.TruongHoc;
import dal.TruongHocDAO;
import dao.UserLogsDAO;
import java.time.LocalDateTime;
import model.UserLogs;
import dal.HoTroDAO ; 

/**
 * This servlet handle all the action of admin when admin click button manage account users 
 * like view details account user , disnable / enable account user or update information of account user 
 * and after handle logic , this servlet can send information to specific JSP if need
 * May 28 , 2025 11:14:38 PM
 * @author chuvv
 */
public class adminActionWithUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
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

    
    
    //This method hadle some case when admin click to hyper link view account users , disnable/enable account users , update account user 
    // In the case update , servlet send direct to update JSP and admin can change information in that JSP 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        PrintWriter out = response.getWriter();
        String type = request.getParameter("type");
        String id = request.getParameter("id");
        switch (action) {

            case "view":    // view detail information of account user
                doViewAccount(request, response) ; 
                break;

            case "enable":      //admin enable account
                if (type.equalsIgnoreCase("GiaoVien")) {   

                    boolean b2 = TaiKhoanDAO.adminEnableAccountUser(id); //admin enable in table account
                    boolean b1 = GiaoVienDAO.adminEnableGiaoVien(id);   //admin enable in table of this user
                    if (b1 == true && b2 == true) {                    
                        int ID_TaiKhoan = Integer.parseInt(id) ; 
                        UserLogs log = new UserLogs(0 , 1 , "Mở tài khoản giáo viên có ID tài khoản " + ID_TaiKhoan , LocalDateTime.now());
                                    
                        UserLogsDAO.insertLog(log);
                        ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName();  
                        session.setAttribute("taikhoans", taikhoans);           
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);      //redirect to adminReceiveUsers
                    } else {
                        request.setAttribute("message", "Không có tài khoản nào.");
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                    }
                } else if (type.equalsIgnoreCase("HocSinh")) {       //if user is student
                    boolean b1 = TaiKhoanDAO.adminEnableAccountUser(id);        //admin enable in table account
                    boolean b2 = HocSinhDAO.adminEnableHocSinh(id);             //admin enable in table of this user
                    if (b1 == true && b2 == true) {                            
                        int ID_TaiKhoan = Integer.parseInt(id) ; 
                        UserLogs log = new UserLogs(0 , 1 , "Mở tài khoản học sinh có ID tài khoản " + ID_TaiKhoan , LocalDateTime.now());
                                    
                        UserLogsDAO.insertLog(log);
                        ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName();    
                        session.setAttribute("taikhoans", taikhoans);           
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);       //redirect to adminReceiveUsers
                    } else {
                        request.setAttribute("message", "Không có tài khoản nào.");

                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                    }
                } else if (type.equalsIgnoreCase("PhuHuynh")) {     //if user is parent of student 
                    boolean b1 = TaiKhoanDAO.adminEnableAccountUser(id);     //admin enable in table account
                    boolean b2 = PhuHuynhDAO.adminEnablePhuHuynh(id);       //admin enable in table of this user
                    if (b1 == true && b2 == true) {                       
                        int ID_TaiKhoan = Integer.parseInt(id) ; 
                        UserLogs log = new UserLogs(0 , 1 , "Mở tài khoản phụ huynh có ID tài khoản " + ID_TaiKhoan , LocalDateTime.now());
                                    
                        UserLogsDAO.insertLog(log);
                        ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName();     
                        session.setAttribute("taikhoans", taikhoans);                      
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
                    if (b1 == true && b2 == true) {                         
                        int ID_TaiKhoan = Integer.parseInt(id) ; 
                        UserLogs log = new UserLogs(0 , 1 , "Vô hiệu hóa tài khoản giáo viên có ID tài khoản " + ID_TaiKhoan , LocalDateTime.now());
                                    
                        UserLogsDAO.insertLog(log);
                        ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName();  
                        session.setAttribute("taikhoans", taikhoans);            
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);      
                    } else {
                        out.print("huhuhu");
                    }
                } else if (type.equalsIgnoreCase("HocSinh")) {      //if user is student
                    boolean b1 = TaiKhoanDAO.adminDisableAccountUser(id);       //admin disnable in table account
                    boolean b2 = HocSinhDAO.adminDisableHocSinh(id);            //admin disnable in table of this user
                    if (b1 == true && b2 == true) {                            
                        int ID_TaiKhoan = Integer.parseInt(id) ; 
                        UserLogs log = new UserLogs(0 , 1 , "Vô hiệu hóa tài khoản học sinh có ID tài khoản " + ID_TaiKhoan , LocalDateTime.now());
                                    
                        UserLogsDAO.insertLog(log);
                        ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName();        
                        session.setAttribute("taikhoans", taikhoans);              
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);     
                    } else {
                        out.print("huhuhu");
                    }
                } else if (type.equalsIgnoreCase("PhuHuynh")) {          //if user is parent of student
                    boolean b1 = TaiKhoanDAO.adminDisableAccountUser(id);    //admin disnable in table account
                    boolean b2 = PhuHuynhDAO.adminDisablePhuHuynh(id);       //admin disnable in table of this user
                    if (b1 == true && b2 == true) {                      
                        int ID_TaiKhoan = Integer.parseInt(id) ; 
                        UserLogs log = new UserLogs(0 , 1 , "Vô hiệu hóa tài khoản phụ huynh có ID tài khoản " + ID_TaiKhoan , LocalDateTime.now());
                                    
                        UserLogsDAO.insertLog(log);
                        ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName();     
                        session.setAttribute("taikhoans", taikhoans);               
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);       
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

            case "update":
                if (type.equalsIgnoreCase("GiaoVien")) {    //if user is teacher

                    ArrayList<GiaoVien_TruongHoc> giaoviens = GiaoVienDAO.adminGetGiaoVienByID(id); 
                    ArrayList<TruongHoc> truonghocs = TruongHocDAO.adminGetTenTruong();
                    if (giaoviens.isEmpty()) {                                              

                        request.setAttribute("message", "Không tìm thấy thông tin giáo viên này.");
                        request.getRequestDispatcher("/views/admin/adminUpdateTeacherInfor.jsp").forward(request, response); // redirect to adminReceiveTeacherInfor.jsp

                    } else {
                        request.setAttribute("truonghocs", truonghocs);
                        request.setAttribute("giaoviens", giaoviens);   
                        request.setAttribute("type", type); 
                        request.getRequestDispatcher("/views/admin/adminUpdateTeacherInfor.jsp").forward(request, response);   // redirect to adminReceiveTeacherInfor.jsp
                    }

                } else if (type.equalsIgnoreCase("HocSinh")) {  //if user is student
                    ArrayList<HocSinh> hocsinhs = HocSinhDAO.adminGetHocSinhByID(id); 
                   

                    String sodienthoai = TaiKhoanDAO.admingetSDTTaiKhoanByID(id);  // get sdt HocSinh because table hocsinh don't have phone number
                    if (hocsinhs.isEmpty()) {                       
                        request.setAttribute("message", "Không tìm thấy thông tin học sinh này.");
                        request.getRequestDispatcher("/views/admin/adminUpdateStudentInfor.jsp").forward(request, response);   
                    } else {
                        request.setAttribute("sodienthoai", sodienthoai);
                        request.setAttribute("hocsinhs", hocsinhs);      
                        request.setAttribute("type", type);  
                        request.getRequestDispatcher("/views/admin/adminUpdateStudentInfor.jsp").forward(request, response);    // redirect to adminReceiveStudentInfor.jsp
                    }
                } else if (type.equalsIgnoreCase("PhuHuynh")) {     //if user is parent of student  
                    ArrayList<PhuHuynh> phuhuynhs = PhuHuynhDAO.adminGetPhuHuynhByID(id);        
                    List<String> name = HocSinhDAO.nameofStudentDependPH(id);   //get name son of parent
                    if (phuhuynhs.isEmpty()) {                                          
                        request.setAttribute("message", "Không tìm thấy thông tin phụ huyunh này.");
                        request.getRequestDispatcher("/views/admin/adminUpdateParentInfor.jsp").forward(request, response);   
                    } else {
                        request.setAttribute("name", name);
                        request.setAttribute("phuhuynhs", phuhuynhs);                
                        request.setAttribute("type", type);  
                        request.getRequestDispatcher("/views/admin/adminUpdateParentInfor.jsp").forward(request, response);    // redirect to adminReceiveParentInfor.jsp
                    }
                }
                break;
                
            case "danhdau" : 
                // danh dau ho tro o admin dashboard
                String id_HoTro = request.getParameter("id") ; 
                boolean ok = HoTroDAO.adminDanhDauDaDocHoTro(id_HoTro) ; 
                if (ok) {
                    request.getRequestDispatcher("/views/admin/adminDashboard.jsp").forward(request, response);
                }
                break ; 

        }
    }

    
    
     //This method handle the information from specific jsp ( update information of user JSP ) and call method handle that
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        switch (type) {
            case "GiaoVien":
                // call the medthod update teacher when admin want to update teacher
                updateTeacher(request, response);
                break;

            case "HocSinh":
                //call the method update student when admin want to update student
                updateStudent(request, response);
                break;

            case "PhuHuynh":
                //call the method update parent of student when admin want to update parent of student
                updateParentOfStudent(request, response);
                break;
        }

    }

    
    
    //medthod view detail information of account
    private void doViewAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String typeUser = request.getParameter("type");
         String ID_TaiKhoan = request.getParameter("id") ; 
         switch(typeUser) {
             case "HocSinh" : 
                    ArrayList<HocSinh> hocsinhs =  HocSinhDAO.adminGetHocSinhByID(ID_TaiKhoan);  // call method to get data from database 
                    if (hocsinhs.isEmpty()) {                       
                        request.setAttribute("message", "Không tìm thấy thông tin học sinh này.");
                        request.getRequestDispatcher("/views/admin/adminReceiveStudentInfor.jsp").forward(request, response);  
                    } else {
                        request.setAttribute("hocsinhs", hocsinhs);      
                        request.getRequestDispatcher("/views/admin/adminReceiveStudentInfor.jsp").forward(request, response);    
                    }
                 break ; 
                
             case "GiaoVien" : 
                    ArrayList<GiaoVien_TruongHoc> giaoviens = GiaoVienDAO.adminGetGiaoVienByID(ID_TaiKhoan); // call method to get data from database 
                    if (giaoviens.isEmpty()) {                                              
                        request.setAttribute("message", "Không tìm thấy thông tin giáo viên này.");
                        request.getRequestDispatcher("/views/admin/adminReceiveTeacherInfor.jsp").forward(request, response); 
                    } else {
                        request.setAttribute("giaoviens", giaoviens);   
                        request.getRequestDispatcher("/views/admin/adminReceiveTeacherInfor.jsp").forward(request, response);  
                    }
                break ; 
                 
             case "PhuHuynh": 
                    ArrayList<PhuHuynh> phuhuynhs = PhuHuynhDAO.adminGetPhuHuynhByID(ID_TaiKhoan); //get data of account is Parent
                    List<String> name = HocSinhDAO.nameofStudentDependPH(ID_TaiKhoan);      //get name son of Parent(by ID_TaiKhoanPhuHuynh )
                    if (phuhuynhs.isEmpty()) {                                         
                        request.setAttribute("message", "Không tìm thấy thông tin phụ huyunh này.");
                        request.getRequestDispatcher("/views/admin/adminReceiveParentInfor.jsp").forward(request, response);    
                    } else {
                        request.setAttribute("name", name);
                        request.setAttribute("phuhuynhs", phuhuynhs);              
                        request.getRequestDispatcher("/views/admin/adminReceiveParentInfor.jsp").forward(request, response);    
                    }
                 break ; 
         }
        
    }
    
    //medthod update teacher
    private void updateTeacher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idtaikhoan = request.getParameter("idtaikhoan");
        String idgiaovien = request.getParameter("idgiaovien");
        String SDT = request.getParameter("sdt");

        String Luong = request.getParameter("luong");
        String hot = request.getParameter("hot");
        HttpSession session = request.getSession();

        try {
            int ID_TaiKhoan = Integer.parseInt(idtaikhoan);
            int ID_GiaoVien = Integer.parseInt(idgiaovien);
            int ishot = Integer.parseInt(hot);
            if (ishot < 0) {
                throw new Exception("Độ hot phải > 0");
            }
            if (SDT.length() != 10) {
                throw new Exception("Số điện thoại phải dài 10 chữ số!");
            }

            if (!SDT.startsWith("0")) {
                throw new Exception("Số điện thoại phải bắt đầu bằng số 0!");
            }

            BigDecimal luongg = new BigDecimal(Luong);

            if (luongg.compareTo(BigDecimal.ZERO) <= 0) {
                throw new Exception("Lương phải lớn hơn 0!");
            }

            boolean s1 = GiaoVienDAO.adminUpdateInformationOfTeacher(SDT, luongg, ishot, ID_GiaoVien);
            boolean s2 = TaiKhoanDAO.adminUpdateInformationAccount(SDT, ID_TaiKhoan);

            if (s1 == true && s2 == true) {
                request.setAttribute("message", "Thay đổi thành công!");
                UserLogs log = new UserLogs(0 , 1 , "Thay đổi thông tin giáo viên có ID tài khoản " + ID_TaiKhoan , LocalDateTime.now());
                
                UserLogsDAO.insertLog(log);
                ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName();   // create arraylist to save data 
                session.setAttribute("taikhoans", taikhoans);
                request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Thất bại!");
                request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
            }

        } catch (Exception e) {

            request.setAttribute("message", e.getMessage());
            request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
        }
    }

    
     //medthod update student
    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idtaikhoan = request.getParameter("idtaikhoan");
        String idhocsinh = request.getParameter("idhocsinh");
        String DiaChi = request.getParameter("diachi");
        String sdt = request.getParameter("sdt");

        String GhiChu = request.getParameter("ghichu");
        HttpSession session = request.getSession();

        try {
            int ID_TaiKhoan = Integer.parseInt(idtaikhoan);
            int ID_HocSinh = Integer.parseInt(idhocsinh);
            if (sdt.length() != 10) {
                throw new Exception("Số điện thoại phải dài 10 chữ số!");
            }

            if (!sdt.startsWith("0")) {
                throw new Exception("Số điện thoại phải bắt đầu bằng số 0!");
            }
            
            

            boolean s1 = HocSinhDAO.adminUpdateInformationOfStudent(DiaChi, GhiChu, ID_HocSinh);
            boolean s2 = TaiKhoanDAO.adminUpdateInformationAccount(sdt, ID_TaiKhoan) ; 
            if (s1 == true && s2 == true ) {
                request.setAttribute("message", "Thay đổi thành công!");
                UserLogs log = new UserLogs(0 , 1 , "Thay đổi thông tin học sinh có ID tài khoản " + ID_TaiKhoan , LocalDateTime.now());
                
                UserLogsDAO.insertLog(log);
                ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName();   // create arraylist to save data 
                session.setAttribute("taikhoans", taikhoans);
                request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Thất bại!");
                request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
            }

        } catch (Exception e) {

            request.setAttribute("message", e.getMessage());
            request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
        }
    }

    
     //medthod update parent of student
    private void updateParentOfStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idtaikhoan = request.getParameter("idtaikhoan");
        String idphuhuynh = request.getParameter("idphuhuynh");
        String SDT = request.getParameter("sdt");
        String DiaChi = request.getParameter("diachi");

        String GhiChu = request.getParameter("ghichu");
        HttpSession session = request.getSession();

        try {
            int ID_TaiKhoan = Integer.parseInt(idtaikhoan);
            int ID_PhuHuynh = Integer.parseInt(idphuhuynh);

            if (SDT.length() != 10) {
                throw new Exception("Số điện thoại phải dài 10 chữ số!");
            }

            if (!SDT.startsWith("0")) {
                throw new Exception("Số điện thoại phải bắt đầu bằng số 0!");
            }

            boolean s1 = PhuHuynhDAO.adminUpdateInformationOfParent(SDT, DiaChi, GhiChu, ID_PhuHuynh);
            boolean s2 = TaiKhoanDAO.adminUpdateInformationAccount(SDT, ID_TaiKhoan);

            if (s1 == true && s2 == true) {
                request.setAttribute("message", "Thay đổi thành công!");
                UserLogs log = new UserLogs(0 , 1 , "Thay đổi thông tin phụ huynh có ID tài khoản " + ID_TaiKhoan , LocalDateTime.now());
                
                UserLogsDAO.insertLog(log);
                ArrayList<TaiKhoanChiTiet> taikhoans = TaiKhoanChiTietDAO.adminGetAllTaiKhoanHaveName();   // create arraylist to save data 
                session.setAttribute("taikhoans", taikhoans);
                request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Thất bại!");
                request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
            }

        } catch (Exception e) {

            request.setAttribute("message", e.getMessage());
            request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
