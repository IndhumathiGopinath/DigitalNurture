import java.util.*;

public class LambdaSortExample {
    public static void main(String[] args) {
        
        List<String> names = Arrays.asList("John", "Alice", "Bob", "Diana");

        
        Collections.sort(names, (s1, s2) -> s1.compareTo(s2));

        
        System.out.println("Sorted list: " + names);
    }
}
