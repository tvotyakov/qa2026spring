package school.redrover.tvotyakov;

import java.util.*;
import java.util.function.BiConsumer;
import java.util.function.Consumer;

public class Main {
    static void main() {
        task1();

        var numbers = task2();
        task3(numbers);
        task4();
    }

    private static void task1() {
        System.out.println("Task 01:");
        var colors = new ArrayList<>(List.of(
            "White",
            "Tan",
            "Yellow",
            "Orange",
            "Red",
            "Pink",
            "Purple",
            "Blue"
        ));

        System.out.println("Colors before filter: " + colors);

        colors.removeIf(
            color -> color.toUpperCase().contains("L"));

        System.out.println("Colors after filter: " + colors);
    }

    private static List<Integer> task2() {
        System.out.println("Task 2:");
        var numbers = new ArrayList<Integer>();

        for (var i = 100; i <= 1000; i++ ) {
            numbers.add(i);
        }

        System.out.println("List of numbers between 100 and 1000 inclusive:");
        System.out.println(numbers);

        return numbers;
    }

    private static void task3(List<Integer> numbers) {
        System.out.println("Task 3:");

        numbers.removeIf(number -> number % 2 == 0);

        System.out.println("Filtered list of numbers:");
        System.out.println(numbers);
    }

    private static void task4() {
        System.out.println("Task 4:");

        var rnd = new Random();
        var queue = new ArrayDeque<Integer>();

        BiConsumer<Queue<Integer>, Integer> producer = (q, num) ->
        {
            q.add(num);
            System.out.println("Produced value -> " + num);
        };

        Consumer<Queue<Integer>> consumer = q ->
            System.out.println("Consumed value <- " + q.poll());

        for(int i = 1; i < rnd.nextInt(10, 51); i++) {
            producer.accept(queue, i);

            if (rnd.nextInt() % 2 == 0) {
                consumer.accept(queue);
            }
        }

        System.out.println("Final state of the queue: " + queue);
    }
}
