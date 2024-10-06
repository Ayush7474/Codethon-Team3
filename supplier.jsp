<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Supplier Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        h1, h2 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        form {
            margin-top: 20px;
            background-color: #fff;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        input[type="text"], input[type="number"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Supplier Management</h1>

    <h2>Add New Supplier</h2>
    <form action="SupplierServlet" method="post">
        <input type="hidden" name="action" value="add">
        <label for="supplierId">Supplier ID:</label>
        <input type="text" id="supplierId" name="supplier_id" required>
        
        <label for="supplierName">Supplier Name:</label>
        <input type="text" id="supplierName" name="supplier_name" required>
        
        <label for="supplierPassword">Password:</label>
        <input type="text" id="supplierPassword" name="supplier_password" required>
        
        <label for="supplierEmail">Email:</label>
        <input type="text" id="supplierEmail" name="supplier_email" required>
        
        <label for="supplierPhone">Phone:</label>
        <input type="number" id="supplierPhone" name="supplier_phone" required>
        
        <input type="submit" value="Add Supplier">
    </form>

    <h2>Existing Suppliers</h2>
    <table>
        <thead>
            <tr>
                <th>Supplier ID</th>
                <th>Supplier Name</th>
                <th>Password</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<String[]> supplierList = (List<String[]>) request.getAttribute("supplierList");
                if (supplierList != null && !supplierList.isEmpty()) {
                    for (String[] supplier : supplierList) {
            %>
            <tr>
                <td><%= supplier[0] %></td>
                <td><%= supplier[1] %></td>
                <td><%= supplier[2] %></td>
                <td><%= supplier[3] %></td>
                <td><%= supplier[4] %></td>
                <td>
                    <form action="SupplierServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="supplier_id" value="<%= supplier[0] %>">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="6">No suppliers found.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
