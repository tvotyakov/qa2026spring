public class Task4 {
    /// Prints all letters о (Cyrillic) in the given string
    public static void run() {
        var message = "Перестановочный алгоритм быстрого действия";
        var countOfOs = 0;
        System.out.println("message: " + message);
        for(var i = 0; i < message.length(); i++) {
            if (message.charAt(i) == 'о') {
                System.out.print('о');
                countOfOs++;
            }
        }
        System.out.println(" (" + countOfOs + ")");
    }
}
