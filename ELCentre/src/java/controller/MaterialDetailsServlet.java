package controller;

import dal.DangTaiLieuDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DangTaiLieu;
import java.io.IOException;

public class MaterialDetailsServlet extends HttpServlet {

     protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Material ID is required.");
            return;
        }

        try {
            int materialId = Integer.parseInt(idParam);
            DangTaiLieuDAO dao = new DangTaiLieuDAO();
            DangTaiLieu material = dao.getMaterialById(materialId);

            if (material == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Material not found.");
                return;
            }

            request.setAttribute("material", material);
            request.getRequestDispatcher("/views/Home-Material/MaterialDetails-main.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Material ID format.");
        }
    }
}