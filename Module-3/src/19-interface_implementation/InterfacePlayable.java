
interface Playable {
    void play();
}

class Guitar implements Playable {
    public void play() {
        System.out.println("Playing the guitar.");
    }
}

class Piano implements Playable {
    public void play() {
        System.out.println("Playing the piano.");
    }
}

public class InterfacePlayable{
    public static void main(String[] args) {
        Playable guitar = new Guitar();
        Playable piano = new Piano();

        guitar.play();  // Output: Playing the guitar.
        piano.play();   // Output: Playing the piano.
    }
}
