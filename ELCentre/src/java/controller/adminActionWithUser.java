package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList ; 
import model.GiaoVien ; 
import model.HocSinh ; 
import dal.HocSinhDAO ; 
import dal.GiaoVienDAO ; 
import model.PhuHuynh ; 
import dal.PhuHuynhDAO ; 

/**
 *
 * @author wrx_Chur04
 */
public class adminActionWithUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet adminActionWithUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminActionWithUser at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        PrintWriter out = response.getWriter() ; 
        switch (action) {
            case "view":
                String type = request.getParameter("type") ; 
                String id = request.getParameter("id");
                if (type.equalsIgnoreCase("GiaoVien")) {
            
                    ArrayList<GiaoVien> giaoviens = GiaoVienDAO.adminGetGiaoVienByID(id) ; 
                    if (giaoviens.isEmpty()) {
                        out.print("huhuhuhu");
                    } else {
                        out.print("okokko");
                    }

                } else if (type.equalsIgnoreCase("HocSinh")) {
                    ArrayList<HocSinh> hocsinhs = new ArrayList<HocSinh>() ;
                    hocsinhs = HocSinhDAO.adminGetHocSinhByID(id) ; 
                    if (hocsinhs.isEmpty()){
                        out.print("huhuhu");
                    } else {
                        out.print("okokokk");
                    }
                } else if (type.equalsIgnoreCase("PhuHuynh")) {
                    ArrayList<PhuHuynh> phuhuynhs = PhuHuynhDAO.adminGetPhuHuynhByID(id) ; 
                    if (phuhuynhs.isEmpty()) {
                        out.print("huhuhuhu");
                    } else {
                        out.print("okokok");
                    }
                } else if (type.equalsIgnoreCase("Staff")) {
                    ArrayList<GiaoVien> giaoviens = GiaoVienDAO.adminGetGiaoVienByID(id);
                    if (giaoviens.isEmpty()) {
                        out.print("huhuhuhu");
                    } else {
                        out.print("okokok");    
                    }
                }
                break;

            case "disable":
                break;

            case "update":
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
