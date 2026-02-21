import java.util.Random;

public class Task2 {
    public static void printOddOrNot() {
        Random rand = new Random();
        int a = rand.nextInt(1000);
        int b = rand.nextInt(1000);

        System.out.println("a = " + a);
        System.out.println("b = " + b);

        if ((a + b) % 2 == 0) {
            System.out.println("maybe a and b are even");
        }
        else {
            System.out.println("some variable is odd");
        }
    }
}
