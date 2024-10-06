<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Orders</title>

    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f2f2f2;
            color: #333;
            margin: 0;
            padding: 0;
        }

        /* Container for the main content */
        .container {
            max-width: 900px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            animation: fadeIn 0.5s ease-in-out;
        }

        /* Heading styles */
        h2 {
            font-size: 2.5rem;
            color: #007BFF;
            text-align: center;
            margin-bottom: 20px;
            font-weight: 600;
        }

        h3 {
            font-size: 1.75rem;
            color: #333;
            margin-bottom: 15px;
        }

        /* Table styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            font-size: 1rem;
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: 600;
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* Button styles */
        .button-container {
            text-align: center;
        }

        .button {
            display: inline-block;
            padding: 12px 24px;
            background-color: #007BFF;
            color: #fff;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        .button:hover {
            background-color: #0056b3;
        }

        /* Animation for fade-in */
        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(10px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive table for smaller screens */
        @media (max-width: 768px) {
            table, th, td {
                display: block;
                width: 100%;
            }

            th, td {
                text-align: right;
            }

            th::before {
                content: attr(data-title);
                float: left;
                font-weight: 600;
                color: #007BFF;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Your Orders</h2>

        <%
            // Fetch the userId from the session
            String userId = null;
            if (session != null) {
                userId = (String) session.getAttribute("userId");
            }

            // Display the orders if the user is logged in
            if (userId != null) {
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    // Establish the database connection (adjust with your DB settings)
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourDB", "username", "password");

                    // SQL query to fetch orders for the logged-in user based on userId
                    String sql = "SELECT orderId, orderStatus FROM orders WHERE userId = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, userId);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        // Display the orders in a table
                        out.println("<h3>Your Orders:</h3>");
                        out.println("<table>");
                        out.println("<tr><th>Order ID</th><th>Order Status</th></tr>");

                        do {
                            String orderId = rs.getString("orderId");
                            String orderStatus = rs.getString("orderStatus");

                            out.println("<tr>");
                            out.println("<td>" + orderId + "</td>");
                            out.println("<td>" + orderStatus + "</td>");
                            out.println("</tr>");
                        } while (rs.next());

                        out.println("</table>");
                    } else {
                        out.println("<p>You have no orders placed yet.</p>");
                    }

                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<p>You are not logged in. Please log in to view your orders.</p>");
            }
        %>

        <div class="button-container">
            <a href="myprofile.jsp" class="button">Back to Profile</a>
        </div>
    </div>
</body>
</html>
