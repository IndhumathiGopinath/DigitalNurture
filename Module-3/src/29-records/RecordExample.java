import java.util.*;
import java.util.stream.Collectors;

record Person(String name, int age) {}

public class RecordExample {
    public static void main(String[] args) {
        Person p1 = new Person("Nila", 22);
        Person p2 = new Person("Indhu", 19);
        Person p3 = new Person("Rahul", 25);

        
        List<Person> people = List.of(p1, p2, p3);

    
        List<Person> adults = people.stream()
                                   .filter(person -> person.age() >= 21)
                                   .collect(Collectors.toList());

        System.out.println("People aged 21 and above:");
        adults.forEach(System.out::println);
    }
}
