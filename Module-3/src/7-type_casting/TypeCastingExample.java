public class TypeCastingExample {
    public static void main(String[] args) {
        
        double myDouble = 45.67;

        int myIntFromDouble = (int) myDouble;

        System.out.println("Original double value: " + myDouble);
        System.out.println("After casting to int: " + myIntFromDouble);

        int myInt = 100;

        double myDoubleFromInt = myInt;

        System.out.println("Original int value: " + myInt);
        System.out.println("After casting to double: " + myDoubleFromInt);
    }
}
