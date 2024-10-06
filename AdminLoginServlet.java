/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author siddh
 */
public class AdminLoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
        String adminId = request.getParameter("admin_id");
        String adminPassword = request.getParameter("admin_password");
        
        String url = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your database URL
        String user = "system"; // Update with your database username
        String password = "123"; // Update with your database password
        
            Class.forName("oracle.jdbc.OracleDriver");
            Connection conn = DriverManager.getConnection(url, user, password);
            String sql = "SELECT * FROM admin WHERE admin_id = ? AND admin_password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, adminId);
            stmt.setString(2, adminPassword);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("adminId", adminId); // Store admin ID in session
                response.sendRedirect("AdminDashboard.jsp"); // Redirect to dashboard
            } else {
                response.sendRedirect("AdminLogin.jsp?error=Invalid credentials"); // Redirect back with error
            }
        } catch (Exception e) {
            out.print(e);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
