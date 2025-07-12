/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ManageCourses;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSerializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonSerializationContext;
import java.time.LocalDateTime;
import java.lang.reflect.Type;
import model.LopHocInfoDTO;
import dal.LopHocInfoDTODAO;

/**
 *
 * @author Vuh26
 */
public class FindSimilarClasses extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String classCode = request.getParameter("classCode");

        if (classCode != null && !classCode.trim().isEmpty()) {
            try {
                LopHocInfoDTODAO lopHocDAO = new LopHocInfoDTODAO();
                List<LopHocInfoDTO> similarClasses = lopHocDAO.findSimilarClasses(classCode);
                Gson gson = new GsonBuilder()
                    .registerTypeAdapter(LocalDateTime.class, new JsonSerializer<LocalDateTime>() {
                        @Override
                        public JsonElement serialize(LocalDateTime src, Type typeOfSrc, JsonSerializationContext context) {
                            return context.serialize(src != null ? src.toString() : null);
                        }
                    })
                    .create();
                String json = gson.toJson(similarClasses);
                response.getWriter().write(json);
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"error\": \"Đã xảy ra lỗi khi tìm lớp tương đồng: " + e.getMessage() + "\"}");
                e.printStackTrace();
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Mã lớp không hợp lệ.\"}");
        }
    }
}
