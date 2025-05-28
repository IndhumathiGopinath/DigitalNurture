import java.sql.*;

public class TransactionExample {

    // Database connection parameters - change as per your DB setup
    static final String JDBC_URL = "jdbc:mysql://localhost:3306/your_database";
    static final String USER = "your_username";
    static final String PASSWORD = "your_password";

    public static void transferMoney(Connection conn, int fromAccountId, int toAccountId, double amount) throws SQLException {
        try {
            // Disable auto-commit mode to start the transaction
            conn.setAutoCommit(false);

            // Debit from source account
            String debitSQL = "UPDATE accounts SET balance = balance - ? WHERE account_id = ? AND balance >= ?";
            try (PreparedStatement debitStmt = conn.prepareStatement(debitSQL)) {
                debitStmt.setDouble(1, amount);
                debitStmt.setInt(2, fromAccountId);
                debitStmt.setDouble(3, amount);
                int rowsAffected = debitStmt.executeUpdate();

                if (rowsAffected == 0) {
                    throw new SQLException("Insufficient balance or account not found for debit.");
                }
            }

            // Credit to destination account
            String creditSQL = "UPDATE accounts SET balance = balance + ? WHERE account_id = ?";
            try (PreparedStatement creditStmt = conn.prepareStatement(creditSQL)) {
                creditStmt.setDouble(1, amount);
                creditStmt.setInt(2, toAccountId);
                int rowsAffected = creditStmt.executeUpdate();

                if (rowsAffected == 0) {
                    throw new SQLException("Destination account not found for credit.");
                }
            }

            // If both succeed, commit the transaction
            conn.commit();
            System.out.println("Transaction successful: Transferred " + amount + " from account " + fromAccountId + " to account " + toAccountId);

        } catch (SQLException e) {
            // If any failure occurs, rollback the transaction
            System.out.println("Transaction failed. Rolling back.");
            conn.rollback();
            throw e;  // re-throw the exception to handle further if needed
        } finally {
            // Restore auto-commit to true for other operations
            conn.setAutoCommit(true);
        }
    }

    public static void main(String[] args) {
        try (Connection conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD)) {
            // Example usage: transfer 100.00 from account 1 to account 2
            transferMoney(conn, 1, 2, 100.00);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
