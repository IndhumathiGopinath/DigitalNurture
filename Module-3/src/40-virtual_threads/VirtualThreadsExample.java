public class VirtualThreadsExample {
    public static void main(String[] args) throws InterruptedException {
        int numberOfThreads = 100_000;

        long startTime = System.currentTimeMillis();

        for (int i = 1; i <= numberOfThreads; i++) {
            int threadNum = i;
            Thread.startVirtualThread(() -> {
                System.out.println("Hello from virtual thread #" + threadNum);
            });
        }

        long endTime = System.currentTimeMillis();
        System.out.println("Launched " + numberOfThreads + " virtual threads in " + (endTime - startTime) + " ms");

        Thread.sleep(3000);
    }
}
