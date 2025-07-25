package controller;

import dal.HocPhiDAO;
import dal.PhuHuynhDAO;
import dao.TaiKhoanDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.HocPhi;
import model.HocSinh;
import model.PhuHuynh;
import model.TaiKhoan;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ParentPaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getID_VaiTro() != 5) {
            System.out.println("Chuyển hướng đến login.jsp vì user null hoặc không phải phụ huynh");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int idTaiKhoan = user.getID_TaiKhoan();
        int idPhuHuynh = PhuHuynhDAO.getPhuHuynhIdByTaiKhoanId(idTaiKhoan);
        List<HocSinh> dsCon = PhuHuynhDAO.getListCon(idPhuHuynh);
        if(dsCon != null ) {
             session.setAttribute("dsCon", dsCon);
            request.getRequestDispatcher("/views/parent/parentPayment.jsp").forward(request, response);
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị thông tin học phí của các con cho phụ huynh";
    }

}


