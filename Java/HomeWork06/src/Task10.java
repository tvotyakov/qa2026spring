import java.util.Arrays;

public class Task10 {

    /// Prints count of temperature decreasing related to the previous day
    public static void run() {
        int[] temps = {18, 20, 17, 19, 16, 15, 21};

        var decreasingCounter = 0;
        for (var i = 1; i < temps.length; i++) {
            if(temps[i] < temps[i-1]) {
                decreasingCounter++;
            }
        }

        System.out.println("На основе статистики температур в массиве " + Arrays.toString(temps)
                + " зафиксировано " + decreasingCounter
                + " падений температуры по сравнению с предыдущим днём");
    }
}
