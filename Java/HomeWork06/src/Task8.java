import java.util.Arrays;

public class Task8 {

    /// Prints max value in the given array of arrays
    public static void run() {
        int[][] array = {{1, 2, 3, 4, 5}, {6, 7, 8, 9}, {-1, -2, -3, -4}, {-5, -6}};

        String arrayStrRepr = "[ ";
        int maxVal = Integer.MIN_VALUE;
        for(var subArray: array) {
            arrayStrRepr += Arrays.toString(subArray) + ", ";

            for(var el: subArray) {
                if (el > maxVal) {
                    maxVal = el;
                }
            }
        }

        arrayStrRepr = arrayStrRepr.substring(0, arrayStrRepr.length() - 2) + " ]";

        System.out.println("Максимальное значение массива " + arrayStrRepr +  " равно " + maxVal);
    }
}
