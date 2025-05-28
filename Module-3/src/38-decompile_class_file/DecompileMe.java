public class DecompileMe {
    private int number = 42;

    public String message(String name) {
        return "Hello, " + name + "! The number is " + number;
    }

    public static void main(String[] args) {
        DecompileMe obj = new DecompileMe();
        System.out.println(obj.message("Indhu"));
    }
}
