public class Task2 {
    public static void swapAndPrint() {
        int a = 200;
        int b = 4234;

        System.out.println("Before: a = " + a + ", b = " + b);

        int t = a;
        a = b;
        b = t;

        System.out.println("After: a = " + a + ", b = " + b);
    }
}
