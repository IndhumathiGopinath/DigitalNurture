package Thread;
class MessageRunnable implements Runnable {
    private String message;

    public MessageRunnable(String message) {
        this.message = message;
    }

    public void run() {
        for (int i = 1; i <= 5; i++) {
            System.out.println(message + " - " + i);
        }
    }

    public static void main(String[] args) {
        Thread t1 = new Thread(new MessageRunnable("Thread 1"));
        Thread t2 = new Thread(new MessageRunnable("Thread 2"));
        t1.start();
        t2.start();
    }
}
