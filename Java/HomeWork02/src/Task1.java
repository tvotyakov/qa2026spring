public class Task1 {
    public static void printMath() {
        int a = 10;
        int b = 21;

        System.out.println("a + b = " + (a + b));
        System.out.println("a - b = " + (a - b));
        System.out.println("a * b = " + (a * b));
        System.out.println("a / b = " + ((double)a / b));
        System.out.println("a % b = " + (a % b));

        boolean isAOdd = a % 2 == 0;
        boolean isBOdd = b %2 == 0;
        System.out.println("Is a (" + a + ") Odd? " + isAOdd);
        System.out.println("Is b (" + b + ") Odd? " + isBOdd);
    }
}
