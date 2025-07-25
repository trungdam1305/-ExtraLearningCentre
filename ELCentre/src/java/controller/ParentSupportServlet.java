package controller;

import dal.HoTroDAO;
import dal.PhuHuynhDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.HoTro;
import model.PhuHuynh;
import model.TaiKhoan;

import java.io.IOException;
import java.util.List;

public class ParentSupportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // Kiểm tra đăng nhập và vai trò phụ huynh
        if (user == null || user.getID_VaiTro() != 5) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int idTaiKhoan = user.getID_TaiKhoan();
        int idPhuHuynh = PhuHuynhDAO.getPhuHuynhIdByTaiKhoanId(idTaiKhoan);
        PhuHuynh phuHuynh = PhuHuynhDAO.getPhuHuynhById(idPhuHuynh);

        List<HoTro> danhSachHoTro = HoTroDAO.getHoTroByIdTaiKhoan(idTaiKhoan);

        request.setAttribute("phuHuynh", phuHuynh);
        request.setAttribute("dsHoTro", danhSachHoTro);
        request.getRequestDispatcher("/views/parent/parentSupport.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getID_VaiTro() != 5) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        int idTaiKhoan = user.getID_TaiKhoan();
        int idPhuHuynh = PhuHuynhDAO.getPhuHuynhIdByTaiKhoanId(idTaiKhoan);
        String ID_TaiKhoan = String.valueOf(idTaiKhoan) ; 
        
        PhuHuynh phuHuynh = PhuHuynhDAO.getPhuHuynhById(idPhuHuynh);
        
        String tenHoTro = request.getParameter("tenHoTro");
        String moTa = request.getParameter("moTa");

       
            boolean s1 = HoTroDAO.sendHoTroByIdTaiKhoan(phuHuynh.getHoTen(), tenHoTro, moTa, ID_TaiKhoan, "PhuHuynh", phuHuynh.getSDT()) ; 
        
            
        

        // Không cần truyền lại phuHuynh vì servlet sẽ redirect đến doGet
        response.sendRedirect("ParentSupportServlet");
    }

    @Override
    public String getServletInfo() {
        return "Quản lý hỗ trợ của phụ huynh";
    }
}
