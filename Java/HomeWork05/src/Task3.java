public class Task3 {

    public static void printIncrementedNums() {
        int[] arr = {9, 2, 6, 4, 5, 12, 7, 8, 6};

        System.out.print("variant 1: ");

        System.out.print("[ ");
        for(int item: arr) {
            System.out.print((item + 15) + " ");
        }
        System.out.println("]");

        System.out.print("variant 2: ");
        System.out.print("[ ");;
        for(var i = 0; i < arr.length; i++) {
            arr[i] = arr[i] + 15;
            System.out.print(arr[i] + " ");
        }
        System.out.println("]");

    }
}
