public class MethodOverloading {
    
    public int add(int a, int b) {
        return a + b;
    }

    public int add(int a, int b, int c) {
        return a + b + c;
    }
    public double add(double a, double b) {
        return a + b;
    }

    public static void main(String[] args) {
        MethodOverloading mo = new MethodOverloading();
        
        System.out.println("Sum of 5 and 10: " + mo.add(5, 10)); 
        System.out.println("Sum of 5, 10 and 15: " + mo.add(5, 10, 15)); 
        System.out.println("Sum of 5.5 and 10.5: " + mo.add(5.5, 10.5));
    }
}
