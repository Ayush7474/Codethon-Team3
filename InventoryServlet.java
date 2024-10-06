// Change this to your actual package

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/InventoryServlet")
public class InventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("update".equals(action)) {
            updateProduct(request, response);
        } else if ("delete".equals(action)) {
            deleteProduct(request, response);
        }
        
        // To display the inventory after the action
        displayProducts(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) {
        String productId = request.getParameter("product_id");
        String productName = request.getParameter("product_name");
        String productPrice = request.getParameter("product_price");
        String productQuantity = request.getParameter("product_quantity");

        try {
            Connection conn = getConnection();
            String sql = "INSERT INTO product (product_id, product_name, product_price, product_quantity) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, productId);
            stmt.setString(2, productName);
            stmt.setDouble(3, Double.parseDouble(productPrice)); // Assuming price is a double
            stmt.setInt(4, Integer.parseInt(productQuantity)); // Assuming quantity is an integer
            stmt.executeUpdate();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) {
        String productId = request.getParameter("product_id");
        String productName = request.getParameter("product_name");
        String productPrice = request.getParameter("product_price");
        String productQuantity = request.getParameter("product_quantity");

        try {
            Connection conn = getConnection();
            String sql = "UPDATE product SET product_name = ?, product_price = ?, product_quantity = ? WHERE product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, productName);
            stmt.setDouble(2, Double.parseDouble(productPrice)); // Assuming price is a double
            stmt.setInt(3, Integer.parseInt(productQuantity)); // Assuming quantity is an integer
            stmt.setString(4, productId);
            stmt.executeUpdate();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) {
        String productId = request.getParameter("product_id");

        try {
            Connection conn = getConnection();
            String sql = "DELETE FROM product WHERE product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, productId);
            stmt.executeUpdate();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void displayProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Product> productList = new ArrayList<>();
        
        try {
            Connection conn = getConnection();
            String sql = "SELECT * FROM product";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                String productId = rs.getString("product_id");
                String productName = rs.getString("product_name");
                double productPrice = rs.getDouble("product_price");
                int productQuantity = rs.getInt("product_quantity");
                
                Product product = new Product(productId, productName, productPrice, productQuantity);
                productList.add(product);
            }
            
            request.setAttribute("productList", productList);
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("inventory.jsp").forward(request, response);
    }

    private Connection getConnection() throws Exception {
        String url = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your database URL
        String user = "system"; // Update with your database username
        String password = "123"; // Update with your database password
        Class.forName("oracle.jdbc.OracleDriver");
        return DriverManager.getConnection(url, user, password);
    }
    
    // Inner class to represent a Product
    public class Product {
        private String productId;
        private String productName;
        private double productPrice;
        private int productQuantity;

        public Product(String productId, String productName, double productPrice, int productQuantity) {
            this.productId = productId;
            this.productName = productName;
            this.productPrice = productPrice;
            this.productQuantity = productQuantity;
        }

        // Getters
        public String getProductId() {
            return productId;
        }

        public String getProductName() {
            return productName;
        }

        public double getProductPrice() {
            return productPrice;
        }

        public int getProductQuantity() {
            return productQuantity;
        }
    }
}
