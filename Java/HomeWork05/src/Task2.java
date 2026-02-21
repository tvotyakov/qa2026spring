public class Task2 {
    public static void printNumsBigger5() {
        int[] arr = {9, 2, 6, 4, 5, 12, 7, 8, 6};

        System.out.print("variant 1: ");
        System.out.print("[ ");
        for(var i = 0; i < arr.length; i++) {
            if (arr[i] > 5) {
                System.out.print(arr[i] + " ");
            }
        }
        System.out.println("]");

        System.out.print("variant 2: ");
        System.out.print("[ ");
        for(var item: arr) {
            if (item > 5) {
                System.out.print(item + " ");
            }
        }
        System.out.println("]");
    }
}
