/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.ManageCourses;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.LopHocInfoDTODAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.LopHocInfoDTODAO;
import java.io.BufferedReader;
import java.io.IOException;


/**
 *
 * @author Vuh26
 */
public class ChangeClassForStudent extends HttpServlet {
   
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
            out.println("<title>Servlet ChangeClassForStudent</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangeClassForStudent at " + request.getContextPath () + "</h1>");
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
      response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Kiểm tra CSRF token
        String csrfToken = request.getHeader("X-CSRF-Token");
        if (csrfToken == null || !csrfToken.equals(request.getSession().getAttribute("csrfToken"))) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("errorMessage", "CSRF token không hợp lệ!");
            response.getWriter().write(new Gson().toJson(json));
            return;
        }

        // Đọc dữ liệu JSON từ request
        StringBuilder jb = new StringBuilder();
        String line;
        try {
            BufferedReader reader = request.getReader();
            while ((line = reader.readLine()) != null) {
                jb.append(line);
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("errorMessage", "Lỗi khi đọc dữ liệu yêu cầu!");
            response.getWriter().write(new Gson().toJson(json));
            return;
        }

        // Parse JSON
        Gson gson = new Gson();
        JsonObject jsonObject = gson.fromJson(jb.toString(), JsonObject.class);
        int idHocSinh = jsonObject.get("idHocSinh").getAsInt();
        int idLopHocHienTai = jsonObject.get("idLopHocHienTai").getAsInt();
        int idLopHocTuongDong = jsonObject.get("idLopHocTuongDong").getAsInt();

        // Gọi DAO để thực hiện chuyển lớp
        LopHocInfoDTODAO dao = new LopHocInfoDTODAO();
        LopHocInfoDTODAO.OperationResult result = dao.changeClassForStudent(idHocSinh, idLopHocHienTai, idLopHocTuongDong);

        // Trả về kết quả
        JsonObject responseJson = new JsonObject();
        responseJson.addProperty("success", result.isSuccess());
        responseJson.addProperty("errorMessage", result.getErrorMessage() != null ? result.getErrorMessage() : "");
        response.getWriter().write(gson.toJson(responseJson));
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
