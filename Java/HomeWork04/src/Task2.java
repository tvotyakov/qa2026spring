public class Task2 {
    public static void printPowersOf5() {
        for(int i = 1, pow = 5; pow < 10000; i++, pow *= 5) {
            System.out.println("5 ^ " + i + " = " + pow);
        }
    }
}
