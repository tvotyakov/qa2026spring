import java.util.Arrays;

public class Task6 {

    /// Prints sum of elements in the given array
    public static void run() {
        int[] array = {9, 2, 6, 4, 5, 12, 7, 8, 6};
        var sum = 0;
        for(int el: array) {
            sum += el;
        }
        System.out.println("Сумма элементов массива " + Arrays.toString(array) + " = " + sum);
    }
}
