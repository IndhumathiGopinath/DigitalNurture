import java.util.*;
import java.util.concurrent.*;

public class CallableExample {
    public static void main(String[] args) {
        
        ExecutorService executor = Executors.newFixedThreadPool(3);

        
        List<Future<String>> futureList = new ArrayList<>();

        
        for (int i = 1; i <= 5; i++) {
            int taskId = i;
            Callable<String> task = () -> {
                Thread.sleep(1000); // Simulate task time
                return "Task " + taskId + " completed by " + Thread.currentThread().getName();
            };
            Future<String> future = executor.submit(task);
            futureList.add(future);
        }

        for (Future<String> future : futureList) {
            try {
                System.out.println(future.get()); 
            } catch (InterruptedException | ExecutionException e) {
                System.err.println("Error occurred while retrieving task result: " + e.getMessage());
            }
        }

        
        executor.shutdown();
    }
}
