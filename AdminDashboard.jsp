<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding-bottom: 80px;
        }

        /* Navbar styling */
        .navbar {
            background-color: #004aad;
            padding: 15px;
        }

        .navbar-brand, .nav-link {
            color: white !important;
        }

        .navbar-brand {
            font-size: 26px;
            font-weight: bold;
        }

        .container {
            margin-top: 40px;
        }

        .section-title {
            font-size: 24px;
            margin-bottom: 20px;
            color: #004aad;
            font-weight: bold;
        }

        /* Card styling */
        .card {
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .card-body {
            padding: 20px;
        }

        .card-title {
            font-size: 20px;
            font-weight: bold;
        }

        .card-text {
            font-size: 16px;
        }

        /* Footer styling */
        footer {
            background-color: #004aad;
            color: white;
            padding: 15px;
            position: fixed;
            bottom: 0;
            width: 100%;
            text-align: center;
        }

        /* Admin details section styling */
        .admin-details {
            background-color: #e9ecef;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .admin-details h5 {
            font-size: 22px;
            font-weight: bold;
            color: #004aad;
        }

        .admin-details p {
            font-size: 16px;
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light">
        <a class="navbar-brand" href="#">Admin Dashboard</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#">Inventory</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Suppliers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Orders</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="logout.jsp">Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <!-- Admin Details Section -->
        <div class="admin-details">
            <h5>Admin Details</h5>
            <p><strong>Admin Name:</strong> John Doe</p>
            <p><strong>Email:</strong> johndoe@example.com</p>
            <p><strong>Last Login:</strong> 6th October 2024, 10:00 AM</p>
        </div>

        <hr>

        <!-- Dashboard Section -->
        <h2 class="section-title">Dashboard</h2>
        <p>Welcome, Admin! Use the sections below to manage the Civil Supplies Corporation.</p>

        <div class="row">
            <!-- Inventory Section -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Inventory Management</h5>
                        <p class="card-text">View and manage current stock levels.</p>
                        <a href="inventory.jsp" class="btn btn-primary">Go to Inventory</a>
                         
                    </div>
                </div>
            </div>

            <!-- Suppliers Section -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Suppliers Details</h5>
                        <p class="card-text">View and manage supplier information.</p>
                        <a href="supplier.jsp" class="btn btn-primary">Go to Suppliers</a>
                    </div>
                </div>
            </div>

            <!-- Orders Section -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Orders</h5>
                        <p class="card-text">View and process orders from users.</p>
                        <a href="Orders.jsp" class="btn btn-primary">Go to Orders</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        © 2024 Civil Supplies Corporation Automation
    </footer>

</body>
</html>
