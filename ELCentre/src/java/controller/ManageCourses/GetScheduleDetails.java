/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ManageCourses;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import dal.DBContext;


/**
 *
 * @author Vuh26
 */
public class GetScheduleDetails extends HttpServlet {
    private static class ScheduleDetail {
        public String tenLopHoc;
        public String tenPhongHoc;
        public String slotThoiGian;
        public String ghiChu;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String idLopHocStr = request.getParameter("idLopHoc");
        String dayStr = request.getParameter("day");
        String monthStr = request.getParameter("month");
        String yearStr = request.getParameter("year");

        try {
            int idLopHoc = Integer.parseInt(idLopHocStr);
            int day = Integer.parseInt(dayStr);
            int month = Integer.parseInt(monthStr);
            int year = Integer.parseInt(yearStr);

            List<ScheduleDetail> schedules = new ArrayList<>();
            String sql = """
                SELECT 
                    lh.TenLopHoc,
                    p.TenPhongHoc,
                    sh.SlotThoiGian,
                    lich.GhiChu
                FROM 
                    [dbo].[LichHoc] lich
                JOIN 
                    [dbo].[LopHoc] lh ON lich.ID_LopHoc = lh.ID_LopHoc
                JOIN 
                    [dbo].[PhongHoc] p ON lich.ID_PhongHoc = p.ID_PhongHoc
                JOIN 
                    [dbo].[SlotHoc] sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
                WHERE 
                    lich.ID_LopHoc = ? 
                    AND DAY(lich.NgayHoc) = ? 
                    AND MONTH(lich.NgayHoc) = ? 
                    AND YEAR(lich.NgayHoc) = ?
            """;

            try (Connection conn = DBContext.getInstance().getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, idLopHoc);
                stmt.setInt(2, day);
                stmt.setInt(3, month);
                stmt.setInt(4, year);

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        ScheduleDetail detail = new ScheduleDetail();
                        detail.tenLopHoc = rs.getString("TenLopHoc");
                        detail.tenPhongHoc = rs.getString("TenPhongHoc");
                        detail.slotThoiGian = rs.getString("SlotThoiGian");
                        detail.ghiChu = rs.getString("GhiChu");
                        schedules.add(detail);
                    }
                }
            }

            Gson gson = new Gson();
            String json = gson.toJson(schedules);
            response.getWriter().write(json);
        } catch (NumberFormatException | SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Lỗi khi lấy chi tiết lịch học: " + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }
}
