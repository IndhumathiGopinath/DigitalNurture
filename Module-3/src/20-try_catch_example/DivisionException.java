import java.util.Scanner;

public class DivisionException {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter the first integer (numerator): ");
        int numerator = scanner.nextInt();

        System.out.print("Enter the second integer (denominator): ");
        int denominator = scanner.nextInt();

        try {
            int result = numerator / denominator;
            System.out.println("Result: " + result);
        } catch (ArithmeticException e) {
            System.out.println("Error: " + e.getMessage());
            System.out.println("Cannot divide by zero.");
        }
    }
}
