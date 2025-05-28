import MessageThread;

package Thread;
class MessageThread extends Thread {
    private String message;

    public MessageThread(String message) {
        this.message = message;
    }

    public void run() {
        for (int i = 1; i <= 5; i++) {
            System.out.println(message + " - " + i);
        }
    }

    public static void main(String[] args) {
        MessageThread t1 = new MessageThread("Thread 1");
        MessageThread t2 = new MessageThread("Thread 2");
        t1.start();
        t2.start();
    }
}
