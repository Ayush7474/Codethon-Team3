import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InventoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        List<InventoryItem> inventoryList = new ArrayList<>();

        try {
            // Get a connection to the database
            connection = DBConnection.getConnection();

            // SQL query to get inventory data
            String query = "SELECT item_name, quantity, price FROM inventory";
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();

            // Iterate through the result set and add items to the list
            while (resultSet.next()) {
                String itemName = resultSet.getString("item_name");
                int quantity = resultSet.getInt("quantity");
                double price = resultSet.getDouble("price");

                InventoryItem item = new InventoryItem(itemName, quantity, price);
                inventoryList.add(item);
            }

            // Set the inventory list in request scope to pass it to the JSP
            request.setAttribute("inventoryList", inventoryList);

            // Forward to the inventory.jsp page
            request.getRequestDispatcher("inventory.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
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
