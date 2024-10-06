<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Database connection parameters
    String url = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your database URL
    String user = "system"; // Update with your database username
    String password = "123"; // Update with your database password
    List<String[]> productList = new ArrayList<>();

    try {
        Class.forName("oracle.jdbc.OracleDriver");
        Connection conn = DriverManager.getConnection(url, user, password);
        String sql = "SELECT * FROM product"; // Fetching products
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            String[] product = new String[4];
            product[0] = rs.getString("product_id");
            product[1] = rs.getString("product_name");
            product[2] = String.valueOf(rs.getDouble("product_price"));
            product[3] = String.valueOf(rs.getInt("product_quantity"));
            productList.add(product);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inventory Management</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f8ff;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        h1, h2 {
            color: #007bff;
            text-align: center;
        }
        form {
            margin-bottom: 20px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        input[type="text"], input[type="number"] {
            padding: 10px;
            margin: 6px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: calc(100% - 22px);
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s, transform 0.2s;
        }
        input[type="submit"]:hover {
            background-color: #218838;
            transform: scale(1.05);
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
    </style>
</head>
<body>
    <h1>Inventory Management</h1>

    <h2>Add New Product</h2>
    <form action="InventoryServlet" method="post">
        <input type="hidden" name="action" value="add">
        <label for="productId">Product ID:</label>
        <input type="text" id="productId" name="product_id" required>
        <label for="productName">Product Name:</label>
        <input type="text" id="productName" name="product_name" required>
        <label for="price">Price:</label>
        <input type="number" id="price" name="product_price" step="0.01" required>
        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="product_quantity" required>
        <input type="submit" value="Add Product">
    </form>

    <h2>Existing Products</h2>
    <table>
        <thead>
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (String[] product : productList) {
            %>
            <tr>
                <td><%= product[0] %></td>
                <td><%= product[1] %></td>
                <td><%= product[2] %></td>
                <td><%= product[3] %></td>
                <td>
                    <form action="InventoryServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="product_id" value="<%= product[0] %>">
                        <label for="newPrice_<%= product[0] %>" style="display:none;">New Price:</label>
                        <input type="number" id="newPrice_<%= product[0] %>" name="product_price" step="0.01" required>
                        <label for="newQuantity_<%= product[0] %>" style="display:none;">New Quantity:</label>
                        <input type="number" id="newQuantity_<%= product[0] %>" name="product_quantity" required>
                        <input type="submit" value="Update">
                    </form>
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
