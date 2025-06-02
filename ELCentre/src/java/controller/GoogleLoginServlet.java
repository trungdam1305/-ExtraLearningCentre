package controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import dao.TaiKhoanDAO;
import model.TaiKhoan;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.net.HttpURLConnection;


public class GoogleLoginServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String credential = request.getParameter("credential");
        if (credential == null || credential.isEmpty()) {
            response.sendRedirect("login.jsp?error=Google login failed");
            return;
        }

        // Xác minh token với Google
        String verifyUrl = "https://oauth2.googleapis.com/tokeninfo?id_token=" + URLEncoder.encode(credential, "UTF-8");
        URL url = new URL(verifyUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        JsonObject json;
        try (InputStreamReader reader = new InputStreamReader(conn.getInputStream())) {
            json = JsonParser.parseReader(reader).getAsJsonObject();
        }

        String email = json.get("email").getAsString();
        String name = json.has("name") ? json.get("name").getAsString() : "";


        TaiKhoanDAO dao = new TaiKhoanDAO();
        TaiKhoan user = dao.getTaiKhoanByEmail(email);

        if (user == null) {
            //Tạo mới
            TaiKhoan newUser = new TaiKhoan();
            newUser.setEmail(email);
            newUser.setMatKhau("");
            newUser.setID_VaiTro(4); // Vai trò mặc định: user
            newUser.setTrangThai("Active");

            dao.insertTaiKhoan(newUser);
            user = dao.getTaiKhoanByEmail(email); 
        }

        // Lưu session & chuyển hướng
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        response.sendRedirect(request.getContextPath() + "/views/user/dashboard.jsp");
    }
}
