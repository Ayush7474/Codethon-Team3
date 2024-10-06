/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 *
 * @author siddh
 */
public class UpdateSuppliesServlet extends HttpServlet {

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
        String supplierId = request.getParameter("supplier_id");
        String supplierName = request.getParameter("supplier_name");
        String supplierEmail = request.getParameter("supplier_email");
        long supplierPhone = Long.parseLong(request.getParameter("supplier_phone"));

        // Database connection parameters
        String url = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your database URL
        String user = "your_username"; // Update with your database username
        String password = "your_password"; // Update with your database password

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load Oracle JDBC Driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            // Establish connection
            conn = DriverManager.getConnection(url, user, password);

            // SQL update statement
            String sql = "UPDATE suppliers SET supplier_name = ?, supplier_email = ?, supplier_phone = ? WHERE supplier_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, supplierName);
            stmt.setString(2, supplierEmail);
            stmt.setLong(3, supplierPhone);
            stmt.setString(4, supplierId);

            // Execute the update
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Clean up
            try { if (stmt != null) stmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }

        // Redirect back to suppliers.jsp after update
        response.sendRedirect("Supplier.jsp");
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
