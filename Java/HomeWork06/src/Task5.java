public class Task5 {
    // Prints count of letters 'е' (Cyrillic) in the given message
    public static void run() {
        var message = "Перевыборы выбранного президента";
        System.out.println("Фраза: " + message);
        var countOfEs = 0;
        for(var i = 0; i < message.length(); i++) {
            countOfEs += message.charAt(i) == 'е' ? 1 : 0;
        }

        System.out.println("Количество букв е в этой фразе: " + countOfEs);
    }
}
