
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import dao.TaiKhoanDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.TaiKhoan;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
/**
 *
 * @author vkhan
 */
public class FacebookLoginServlet extends HttpServlet {
    private final String FB_GRAPH_API = "a";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FacebookLoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FacebookLoginServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String accessToken = request.getParameter("accessToken");
            if (accessToken == null || accessToken.isEmpty()) {
                response.sendRedirect("login.jsp?error=Token%20không%20hợp%20lệ");
                return;
            }

            // Gọi Facebook API
            URL url = new URL(FB_GRAPH_API + accessToken);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            Scanner scanner = new Scanner(conn.getInputStream());
            StringBuilder jsonStr = new StringBuilder();
            while (scanner.hasNext()) {
                jsonStr.append(scanner.nextLine());
            }
            scanner.close();

            JsonObject fbUser = JsonParser.parseString(jsonStr.toString()).getAsJsonObject();
            String fbId = fbUser.get("id").getAsString();
            String fbName = fbUser.get("name").getAsString();
            String fbEmail = fbUser.has("email") ? fbUser.get("email").getAsString() : fbId + "@facebook.com";

            TaiKhoanDAO dao = new TaiKhoanDAO();
            TaiKhoan user = dao.findOrCreateFacebookUser(fbEmail, fbName);

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            response.setContentType("text/plain");
            response.getWriter().write("index.jsp"); // redirect sau khi login thành công
        }
    

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
