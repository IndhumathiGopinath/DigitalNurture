import java.sql.*;

public class StudentDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/prince1";
    private static final String USER = "root";
    private static final String PASSWORD = "Indhug18*";

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Insert a new student
    public void insertStudent(int id, String name, int age, String dept, String date) {
        String sql = "INSERT INTO students (student_id, name, age, department, admission_date) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.setString(2, name);
            pstmt.setInt(3, age);
            pstmt.setString(4, dept);
            pstmt.setDate(5, Date.valueOf(date));

            int rows = pstmt.executeUpdate();
            System.out.println(rows + " student(s) inserted.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update existing student
    public void updateStudent(int id, String name, int age) {
        String sql = "UPDATE students SET name = ?, age = ? WHERE student_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, name);
            pstmt.setInt(2, age);
            pstmt.setInt(3, id);

            int rows = pstmt.executeUpdate();
            System.out.println(rows + " student(s) updated.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
