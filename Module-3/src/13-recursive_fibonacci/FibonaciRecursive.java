import java.util.Scanner;
public class FibonaciRecursive {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        System.out.print("Enter a number: ");
        int n = s.nextInt(); // Example input
        System.out.println("Fibonacci of " + n + " is: " + fibonacci(n));
    }

    public static int fibonacci(int n) {
        if (n <= 1) {
            return n;
        }
        return fibonacci(n - 1) + fibonacci(n - 2);
    }
    
}
