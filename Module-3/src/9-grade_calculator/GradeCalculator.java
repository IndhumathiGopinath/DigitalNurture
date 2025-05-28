import java.util.*;
public class GradeCalculator{
public char grade(int marks){
if(marks <= 100 && marks >= 90){
return 'A';
}
else if(marks <= 89 && marks >= 80){
return 'B';
}
else if(marks <= 79 && marks >= 70){
return 'C';
}
else if(marks <= 69 && marks >= 60){
return 'D';
}
else{
return 'F';
}
}
public static void main(String[] args){
GradeCalculator g = new GradeCalculator();
Scanner s = new Scanner(System.in);
int marks = s.nextInt();
char result = g.grade(marks);
System.out.println("Grade: " + result);
}
}
