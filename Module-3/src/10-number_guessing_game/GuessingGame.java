import java.util.Random;
import java.util.Scanner;

public class GuessingGame {
    public static void main(String[] args) {
        Random random = new Random();
        int randomNumber = random.nextInt(100);

        Scanner s = new Scanner(System.in);
        int userinput;

        System.out.println("Guess a number between 0 and 99:");

        while (true) {
            userinput = s.nextInt();
            if (userinput < randomNumber) {
                System.out.println("Number greater than " + userinput);
            } else if (userinput > randomNumber) {
                System.out.println("Number lesser than " + userinput);
            } else {
                System.out.println("You guessed it right!");
                break;
            }
        }
    }
}
