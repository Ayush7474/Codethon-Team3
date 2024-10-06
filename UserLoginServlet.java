import java.io.IOException;
import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class UserLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from the request
        String username = request.getParameter("username");
        String password = request.getParameter("password");
                String url = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your database URL
        String user = "system"; // Update with your database username
        String passworddb = "123"; // Update with your database password

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Get a connection to the database
            connection = DriverManager.getConnection(url, user, passworddb);

            // SQL query to authenticate user
            String query = "SELECT userid, username FROM users WHERE username = ? AND password = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, password);  // Password should be hashed for security

            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // User authenticated successfully
                int userid = resultSet.getInt("userid");
                String authenticatedUsername = resultSet.getString("username");

                // Retrieve inventory details for the user
                String inventoryQuery = "SELECT * FROM inventory WHERE userid = ?";
                PreparedStatement inventoryStatement = connection.prepareStatement(inventoryQuery);
                inventoryStatement.setInt(1, userid);
                ResultSet inventoryResultSet = inventoryStatement.executeQuery();

                // Assume the inventory is a list of items, you can store them as needed
                // Here we'll just store it as a list of Strings for simplicity
                List<String> inventoryItems = new ArrayList<>();
                while (inventoryResultSet.next()) {
                    String item = inventoryResultSet.getString("item_name"); // Adjust field name based on your DB
                    inventoryItems.add(item);
                }

                // Create session and store user details and inventory
                HttpSession session = request.getSession();
                session.setAttribute("username", authenticatedUsername);
                session.setAttribute("userid", userid);
                session.setAttribute("inventory", inventoryItems);

                // Redirect to the home page (home.jsp)
                response.sendRedirect("home.jsp");

            } else {
                // Invalid login, redirect to login page with error
                response.sendRedirect("login.jsp?error=invalid");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=true");
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
