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
import model.TaiKhoan;
import dal.TaiKhoanDAO;
import jakarta.servlet.http.HttpSession;

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

            case "view":

                if (type.equalsIgnoreCase("GiaoVien")) {

                    ArrayList<GiaoVien> giaoviens = GiaoVienDAO.adminGetGiaoVienByID(id);
                    if (giaoviens.isEmpty()) {
                        request.setAttribute("message", "Không tìm thấy thông tin giáo viên này.");
                        request.getRequestDispatcher("/views/admin/adminReceiveTeacherInfor.jsp").forward(request, response);

                    } else {
                        request.setAttribute("giaoviens", giaoviens);
                        request.getRequestDispatcher("/views/admin/adminReceiveTeacherInfor.jsp").forward(request, response);
                    }

                } else if (type.equalsIgnoreCase("HocSinh")) {
                    ArrayList<HocSinh> hocsinhs = new ArrayList<HocSinh>();
                    hocsinhs = HocSinhDAO.adminGetHocSinhByID(id);
                    if (hocsinhs.isEmpty()) {
                        request.setAttribute("message", "Không tìm thấy thông tin học sinh này.");
                        request.getRequestDispatcher("/views/admin/adminReceiveTeacherInfor.jsp").forward(request, response);
                    } else {
                        request.setAttribute("hocsinhs", hocsinhs);
                        request.getRequestDispatcher("/views/admin/adminReceiveStudentInfor.jsp").forward(request, response);
                    }
                } else if (type.equalsIgnoreCase("PhuHuynh")) {
                    ArrayList<PhuHuynh> phuhuynhs = PhuHuynhDAO.adminGetPhuHuynhByID(id);
                    if (phuhuynhs.isEmpty()) {
                        request.setAttribute("message", "Không tìm thấy thông tin phụ huyunh này.");
                        request.getRequestDispatcher("/views/admin/adminReceiveParentInfor.jsp").forward(request, response);
                    } else {
                        request.setAttribute("phuhuynhs", phuhuynhs);
                        request.getRequestDispatcher("/views/admin/adminReceiveParentInfor.jsp").forward(request, response);
                    }
                }
                break;

            case "enable":
                if (type.equalsIgnoreCase("GiaoVien")) {

                    boolean b2 = TaiKhoanDAO.adminEnableAccountUser(id);
                    boolean b1 = GiaoVienDAO.adminEnableGiaoVien(id);
                    if (b1 == true && b2 == true) {
                        ArrayList<TaiKhoan> taikhoans = TaiKhoanDAO.adminGetAllTaiKhoan();
                        session.setAttribute("taikhoans", taikhoans);
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "Không có tài khoản nào.");

                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                    }
                } else if (type.equalsIgnoreCase("HocSinh")) {
                    boolean b1 = TaiKhoanDAO.adminEnableAccountUser(id);
                    boolean b2 = HocSinhDAO.adminEnableHocSinh(id);
                    if (b1 == true && b2 == true) {
                        ArrayList<TaiKhoan> taikhoans = TaiKhoanDAO.adminGetAllTaiKhoan();
                        session.setAttribute("taikhoans", taikhoans);
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "Không có tài khoản nào.");

                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                    }
                } else if (type.equalsIgnoreCase("PhuHuynh")) {
                    boolean b1 = TaiKhoanDAO.adminEnableAccountUser(id);
                    boolean b2 = PhuHuynhDAO.adminEnablePhuHuynh(id);
                    if (b1 == true && b2 == true) {
                        ArrayList<TaiKhoan> taikhoans = TaiKhoanDAO.adminGetAllTaiKhoan();
                        session.setAttribute("taikhoans", taikhoans);
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "Không có tài khoản nào.");

                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                    }
                } else if (type.equalsIgnoreCase("Staff")) {
                    boolean b1 = TaiKhoanDAO.adminEnableAccountUser(id);
                    if (b1 == true) {
                        out.print("okok123");
                    } else {
                        out.print("huhuhu");
                    }
                }
                break;

            case "disable":
                if (type.equalsIgnoreCase("GiaoVien")) {

                    boolean b2 = TaiKhoanDAO.adminDisableAccountUser(id);
                    boolean b1 = GiaoVienDAO.adminDisableGiaoVien(id);
                    if (b1 == true && b2 == true) {
                        ArrayList<TaiKhoan> taikhoans = TaiKhoanDAO.adminGetAllTaiKhoan();
                        session.setAttribute("taikhoans", taikhoans);
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                    } else {
                        out.print("huhuhu");
                    }
                } else if (type.equalsIgnoreCase("HocSinh")) {
                    boolean b1 = TaiKhoanDAO.adminDisableAccountUser(id);
                    boolean b2 = HocSinhDAO.adminDisableHocSinh(id);
                    if (b1 == true && b2 == true) {
                        ArrayList<TaiKhoan> taikhoans = TaiKhoanDAO.adminGetAllTaiKhoan();
                        session.setAttribute("taikhoans", taikhoans);
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                    } else {
                        out.print("huhuhu");
                    }
                } else if (type.equalsIgnoreCase("PhuHuynh")) {
                    boolean b1 = TaiKhoanDAO.adminDisableAccountUser(id);
                    boolean b2 = PhuHuynhDAO.adminDisablePhuHuynh(id);
                    if (b1 == true && b2 == true) {
                        ArrayList<TaiKhoan> taikhoans = TaiKhoanDAO.adminGetAllTaiKhoan();
                        session.setAttribute("taikhoans", taikhoans);
                        request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                    } else {
                        out.print("huhuhu");
                    }
                } else if (type.equalsIgnoreCase("Staff")) {
                    boolean b1 = TaiKhoanDAO.adminDisableAccountUser(id);
                    if (b1 == true) {
                        out.print("okok123");
                    } else {
                        out.print("huhuhu");
                    }
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
    }// </editor-fold>

}
