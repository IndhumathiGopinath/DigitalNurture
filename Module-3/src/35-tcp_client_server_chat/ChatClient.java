import java.io.*;
import java.net.*;

public class ChatClient {
    public static void main(String[] args) throws IOException {
        Socket socket = new Socket("localhost", 12345);
        System.out.println("Connected to server.");

        BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
        BufferedReader consoleInput = new BufferedReader(new InputStreamReader(System.in));

        String inputLine;
        while (true) {
            System.out.print("Client: ");
            String message = consoleInput.readLine();
            out.println(message);

            inputLine = in.readLine();
            System.out.println("Server: " + inputLine);
        }
    }
}
