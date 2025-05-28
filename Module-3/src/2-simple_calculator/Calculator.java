import java.util.*;
public class Calculator{
    public static int calc(int a,int b,int sign){
        if(sign == 1){
            return a+b;
        } else if(sign == 2){
            return a-b;
        } else if(sign == 3){
            return a*b;
        } else if(sign == 4){
            return a/b;
        } else if(sign == 5){
            return a%b;
        } else {
            System.out.println("Unexpected Sign!");
            return -1;
        }
    }
    public static void main(String[] args){
        Scanner s = new Scanner(System.in);
        System.out.print("Enter the numbers(a and b):");
        int a = s.nextInt();
        int b = s.nextInt();
        System.out.println("Enter the number to calculate:");
        System.out.println("1.Sum\n2.Difference\n3.Product\n4.Division\n5.Remainder");

        int sign = s.nextInt();

        int result = calc(a,b,sign);
		System.out.println(result);

    }
}