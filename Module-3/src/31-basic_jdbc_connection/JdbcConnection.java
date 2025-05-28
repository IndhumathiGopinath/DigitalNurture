import java.sql.*;

public class JdbcConnection {
    public static void main(String[] args) {
        final String URL = "jdbc:mysql://localhost:3306/prince1";
        final String USER = "root";
        final String PASSWORD = "Indhug18*";

        try {
            Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
            Statement stmt = connection.createStatement();
            stmt.execute("CREATE TABLE IF NOT EXISTS students (" +
                         "student_id INT PRIMARY KEY," +
                         "name VARCHAR(100) NOT NULL," +
                         "age INT," +
                         "department VARCHAR(50)," +
                         "admission_date DATE)");

            stmt.executeUpdate("INSERT INTO students VALUES (1, 'Alice', 20, 'CSE', '2023-08-01') " +
                               "ON DUPLICATE KEY UPDATE name='Alice'"); 

            ResultSet rs = stmt.executeQuery("SELECT * FROM students");
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("student_id") +
                                   ", Name: " + rs.getString("name") +
                                   ", Age: " + rs.getInt("age") +
                                   ", Department: " + rs.getString("department") +
                                   ", Admission Date: " + rs.getDate("admission_date"));
            }

            rs.close();
            stmt.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
