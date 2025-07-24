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
        PhuHuynh phuHuynh = PhuHuynhDAO.getPhuHuynhById(idPhuHuynh);
        List<HocSinh> dsCon = PhuHuynhDAO.getListCon(idPhuHuynh);

        List<HocPhi> dsHocPhi = new ArrayList<>();
        long tongHocPhi = 0;
        long tongDaDong = 0;
        long tongConThieu = 0;

        for (HocSinh con : dsCon) {
            List<HocPhi> hocPhiCuaCon = HocPhiDAO.getHocPhiByHocSinhId(con.getID_HocSinh());
            for (HocPhi hp : hocPhiCuaCon) {
                hp.setHoTenHocSinh(con.getHoTen()); // để hiển thị trong JSP
                tongHocPhi += hp.getTongHocPhi() != null ? hp.getTongHocPhi() : 0;
                tongDaDong += hp.getSoTienDaDong() != null ? hp.getSoTienDaDong() : 0;
                tongConThieu += hp.getConThieu() != null ? hp.getConThieu() : 0;
                dsHocPhi.add(hp);
            }
        }

        request.setAttribute("phuHuynh", phuHuynh);
        request.setAttribute("dsHocPhi", dsHocPhi);
        request.setAttribute("tongHocPhi", tongHocPhi);
        request.setAttribute("tongDaDong", tongDaDong);
        request.setAttribute("tongConThieu", tongConThieu);

        request.getRequestDispatcher("/views/parent/parentPayment.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị thông tin học phí của các con cho phụ huynh";
    }
    
    public static void main(String[] args) throws Exception {
    TaiKhoan user = TaiKhoanDAO.login("phuhuynh1@example.com", "phupass1");
    int idPhuHuynh = PhuHuynhDAO.getPhuHuynhIdByTaiKhoanId(user.getID_TaiKhoan());
    List<HocSinh> dsCon = PhuHuynhDAO.getListCon(idPhuHuynh);

    for (HocSinh con : dsCon) {
        System.out.println("👶 Học sinh: " + con.getHoTen());
        List<HocPhi> hocPhis = HocPhiDAO.getHocPhiByHocSinhId(con.getID_HocSinh());
        for (HocPhi hp : hocPhis) {
            System.out.println(" - Môn: " + hp.getMonHoc() + " | Đóng: " + hp.getSoTienDaDong());
        }
    }
}

}
