import java.util.*;
public class ArraySumAvg{
public static int sum(int[] arr){
int len = arr.length;
int sum = 0;
for(int i = 0; i<len ; i++){
sum+=arr[i];
}
return sum;
}

public static float avg(int[] arr, int n){
float avg = (float)sum(arr) /n;
return avg;
}

public static void main(String[] args){
Scanner s = new Scanner(System.in);
System.out.println("Enter the number of elements:");
int n = s.nextInt();
int[] arr = new int[n];
for(int i = 0; i<n ; i++){
	arr[i] = s.nextInt();
}
System.out.println(sum(arr));
System.out.println(avg(arr,n));
}
}





