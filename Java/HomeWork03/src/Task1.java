import java.util.Random;

public class Task1 {
    public static void compareAndPrint() {
        Random rand = new Random();
        int a = rand.nextInt(1000);
        int b = rand.nextInt(1000);

        System.out.println("a = " + a);
        System.out.println("b = " + b);
        if (a == b) {
            System.out.println("a == b");
        }
        else if (a < b) {
            System.out.println("a < b");
        }
        else {
            System.out.println("a > b");
        }
    }
}
