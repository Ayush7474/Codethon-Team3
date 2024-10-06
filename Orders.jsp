<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders Management</title>
    <style>
        body {
            background-color: #000;
            color: #fff;
            font-family: Arial, sans-serif;
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 8px;
            margin: 4px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            border-radius: 4px;
            margin-top: 10px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .edit-mode {
            display: none;
        }
    </style>
    <script>
        function toggleEdit(orderId) {
            var editFields = document.querySelectorAll('.edit-' + orderId);
            var viewFields = document.querySelectorAll('.view-' + orderId);
            editFields.forEach(field => field.style.display = 'table-cell');
            viewFields.forEach(field => field.style.display = 'none');
        }

        function toggleUpdate(orderId) {
            var editFields = document.querySelectorAll('.edit-' + orderId);
            var viewFields = document.querySelectorAll('.view-' + orderId);
            editFields.forEach(field => field.style.display = 'none');
            viewFields.forEach(field => field.style.display = 'table-cell');
        }
    </script>
</head>
<body>

<h1>Orders Management</h1>

<table>
    <tr>
        <th>Order ID</th>
        <th>Supplier ID</th>
        <th>Order Amount</th>
        <th>Payment Status</th>
        <th>Payment ID</th>
        <th>Actions</th>
    </tr>

    <%
        // Database connection parameters
        String url = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your database URL
        String user = "your_username"; // Update with your database username
        String password = "your_password"; // Update with your database password

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Load Oracle JDBC Driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            // Establish connection
            conn = DriverManager.getConnection(url, user, password);
            // Fetch existing orders
            String sql = "SELECT order_id, supplier_id, order_amount, payment_status, payment_id FROM orders";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                int supplierId = rs.getInt("supplier_id");
                double orderAmount = rs.getDouble("order_amount");
                String paymentStatus = rs.getString("payment_status");
                int paymentId = rs.getInt("payment_id");
    %>
                <tr>
                    <td class="view-<%= orderId %>"><%= orderId %></td>
                    <td class="view-<%= orderId %>"><%= supplierId %></td>
                    <td class="view-<%= orderId %>"><%= orderAmount %></td>
                    <td class="view-<%= orderId %>"><%= paymentStatus %></td>
                    <td class="view-<%= orderId %>"><%= paymentId %></td>
                    <td>
                        <button onclick="toggleEdit(<%= orderId %>)">Edit</button>
                    </td>

                    <!-- Editable fields -->
                    <td class="edit-<%= orderId %> edit-mode">
                        <form action="UpdateOrderServlet" method="post">
                            <input type="hidden" name="order_id" value="<%= orderId %>">
                            <input type="number" name="order_amount_<%= orderId %>" value="<%= orderAmount %>" required>
                            <select name="payment_status_<%= orderId %>" required>
                                <option value="Paid" <%= paymentStatus.equals("Paid") ? "selected" : "" %>>Paid</option>
                                <option value="Pending" <%= paymentStatus.equals("Pending") ? "selected" : "" %>>Pending</option>
                                <option value="Failed" <%= paymentStatus.equals("Failed") ? "selected" : "" %>>Failed</option>
                            </select>
                            <button type="submit">Update</button>
                        </form>
                    </td>
                </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Clean up
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    %>
</table>

</body>
</html>

