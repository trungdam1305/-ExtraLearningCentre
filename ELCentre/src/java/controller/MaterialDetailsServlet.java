// Author: trungdam
// Servlet: MaterialDetailsServlet
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

    /**
     * Handles GET requests to display the details of a single material.
     * It retrieves the material ID from the request, fetches the material from the database,
     * and forwards the data to the JSP for rendering.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8"); // Set content type for proper display

        // Get the material ID from the request parameter.
        String idParam = request.getParameter("id");
        
        // If the ID parameter is missing or empty, send a bad request error.
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Material ID is required.");
            return;
        }

        try {
            // Convert the ID parameter to an integer.
            int materialId = Integer.parseInt(idParam);
            
            // Create a new DangTaiLieuDAO instance to interact with the database.
            DangTaiLieuDAO dao = new DangTaiLieuDAO();
            
            // Retrieve the material by its ID.
            DangTaiLieu material = dao.getMaterialById(materialId);

            // If the material is not found, send a "not found" error.
            if (material == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Material not found.");
                return;
            }

            // Set the retrieved material object as an attribute in the request.
            request.setAttribute("material", material);
            
            // Forward the request to the JSP page responsible for displaying material details.
            request.getRequestDispatcher("/views/Home-Material/MaterialDetails-main.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // If the ID format is invalid (not a number), send a bad request error.
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Material ID format.");
        }
    }
}