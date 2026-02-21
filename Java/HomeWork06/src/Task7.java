import java.util.Arrays;

public class Task7 {

    // Prints sum of all elements in the given array of arrays
    public static void run() {
        int[][] arr =  {
                {1, 2, 3, 4, 5},
                {6, 7, 8, 9},
                {-1, -2, -3, -4},
                {-5, -6}
        };
        int sum = 0;
        String arrayStrRepr = "[ ";
        for(var subArray : arr) {
            arrayStrRepr += Arrays.toString(subArray) + ", ";

            for(var el: subArray) {
                sum += el;
            }
        }
        arrayStrRepr = arrayStrRepr.substring(0, arrayStrRepr.length() - 2) + " ]";

        System.out.println("Сумма элементов 2D массива " + arrayStrRepr +  "= " + sum);
    }
}
