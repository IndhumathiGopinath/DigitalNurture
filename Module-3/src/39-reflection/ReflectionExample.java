import java.lang.reflect.Method;

class SampleClass {
    public void greet() {
        System.out.println("Hello from greet()");
    }

    public void greetWithName(String name) {
        System.out.println("Hello, " + name);
    }
}

public class ReflectionExample {
    public static void main(String[] args) throws Exception {
        Class<?> clazz = Class.forName("SampleClass");
        Object obj = clazz.getDeclaredConstructor().newInstance();
        Method[] methods = clazz.getDeclaredMethods();

        for (Method method : methods) {
            System.out.println("Method: " + method.getName());
            System.out.println("Parameters: " + method.getParameterCount());

            if (method.getParameterCount() == 0) {
                method.invoke(obj);
            } else if (method.getParameterCount() == 1) {
                method.invoke(obj, "Indhu");
            }
        }
    }
}
