
import java.util.Scanner;
public class StringReversal{
    public static void main(String[] args){
        Scanner s = new Scanner(System.in);
        System.out.print("Enter a string:");
        String input = s.nextLine();

        for(int i = input.length() - 1; i >= 0; i--) {
            System.out.print(input.charAt(i));
        }
    }
}