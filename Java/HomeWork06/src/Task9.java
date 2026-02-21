import java.util.Arrays;

public class Task9 {

    /// Prints count of integer values in the given array of integer arrays.
    public static void run() {
        int[][] array = {{1, 2, 3, 4, 5}, {6, 7, 8, 9}, {-1, -2, -3, -4}, {-5, -6}};

        int elementsCount = 0;
        String arrayStrRepr = "[ ";
        for(var subArray: array) {
            arrayStrRepr += Arrays.toString(subArray) + ", ";
            elementsCount += subArray.length;
        }
        arrayStrRepr = arrayStrRepr.substring(0, arrayStrRepr.length() - 2) + " ]";

        System.out.println("В массиве " + arrayStrRepr + " " + elementsCount + " элементов");
    }
}
