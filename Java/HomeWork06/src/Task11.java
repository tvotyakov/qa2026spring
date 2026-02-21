import java.util.Arrays;

public class Task11 {

    /// Shifts given array to the left and prints result
    public static void run() {
        int[] arr = {1, 2, 3, 4, 5};
        System.out.println("Исходный массив: " + Arrays.toString(arr));

        var firstEl = arr[0];
        for(var i = 1; i < arr.length; i++){
            arr[i-1] = arr[i];
        }
        arr[arr.length-1] = firstEl;

        System.out.println("Сдвинутый массив: " + Arrays.toString(arr));
    }
}
