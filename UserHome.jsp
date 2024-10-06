<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Home - Product List</title>
    <style>
        /* Basic CSS styles for readability and elegance */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 960px;
            margin: 40px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        td {
            color: #333;
        }

        input[type="number"] {
            width: 60px;
            padding: 5px;
        }

        .button {
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            text-align: center;
        }

        .button:hover {
            background-color: #0056b3;
        }

        .place-order-button {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 12px;
            background-color: #28a745;
            color: white;
            text-align: center;
            border-radius: 5px;
            border: none;
            font-size: 16px;
        }

        .place-order-button:hover {
            background-color: #218838;
        }

        .profile-link {
            text-align: right;
            margin-top: 20px;
        }

    </style>
</head>
<body>
    <div class="container">
        <h2>Available Products</h2>

        <form action="PlaceOrderServlet" method="POST">
            <table>
                <thead>
                    <tr>
                        <th>Product Name</th>
                        <th>Price ($)</th>
                        <th>Available Quantity</th>
                        <th>Order Quantity</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    // Establish a database connection
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourDB", "username", "password");

                        // Query to fetch product details from the database
                        String sql = "SELECT productId, productName, productPrice, productQuantity FROM products";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();

                        // Check if there are products available
                        if (rs.next()) {
                            do {
                                String productId = rs.getString("productId");
                                String productName = rs.getString("productName");
                                String productPrice = rs.getString("productPrice");
                                String productQuantity = rs.getString("productQuantity");
                %>
                    <tr>
                        <td><%= productName %></td>
                        <td><%= productPrice %></td>
                        <td><%= productQuantity %></td>
                        <td>
                            <!-- Text field to input desired order quantity -->
                            <input type="hidden" name="productId_<%= productId %>" value="<%= productId %>">
                            <input type="number" name="orderQuantity_<%= productId %>" value="1" min="1" max="<%= productQuantity %>">
                        </td>
                    </tr>
                <%
                            } while (rs.next());
                        } else {
                            out.println("<tr><td colspan='4'>No products available.</td></tr>");
                        }

                    } catch (Exception e) {
                        out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    }
                %>
                </tbody>
            </table>

            <!-- Place Order Button -->
            <button type="submit" class="place-order-button">Place Order</button>
        </form>

        <!-- Profile Link -->
        <div class="profile-link">
            <a href="myprofile.jsp" class="button">My Profile</a>
        </div>
    </div>
</body>
</html>
