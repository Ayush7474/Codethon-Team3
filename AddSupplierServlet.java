package com.supplier;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddSupplierServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String supplierId = request.getParameter("supplierId");
        String supplierName = request.getParameter("supplierName");
        String contactNumber = request.getParameter("contactNumber");
        String email = request.getParameter("email");

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DBConnection.getConnection();
            String query = "INSERT INTO Supplier (supplierId, supplierName, contactNumber, email) VALUES (?, ?, ?, ?)";
            statement = connection.prepareStatement(query);

            statement.setString(1, supplierId);
            statement.setString(2, supplierName);
            statement.setString(3, contactNumber);
            statement.setString(4, email);

            statement.executeUpdate();

            // Redirect to the SupplierServlet to refresh the list
            response.sendRedirect("SupplierServlet");

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
