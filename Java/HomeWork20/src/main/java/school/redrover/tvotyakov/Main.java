package school.redrover.tvotyakov;

import javax.swing.*;
import java.util.List;
import java.util.function.BiFunction;

public class Main {
    static void main() {
        List<Integer> integers = List.of(1, 2, 3, 4, 5);
        List<Double> doubles = List.of(1.12, 3.14, -5.0);
        List<String> strings = List.of("В", "лесу", "родилась", "елочка");

        System.out.println(minMax(integers, (x, y) -> x - y));
        System.out.println(minMaxCompare(integers));

        System.out.println(minMax(doubles, (x, y) -> (int)(x - y)));
        System.out.println(minMaxCompare(doubles));

        System.out.println(minMax(strings, String::compareTo));
        System.out.println(minMaxCompare(strings));

        List<Boxer> boxers = List.of(
            new Boxer("Mike", 25, 70, 5),
            new Boxer("Alex", 30, 90, 10),
            new Boxer("Ilia", 20, 60),
            new Boxer("Petr", 40, 100, 20),
            new Boxer("Vasia", 35, 95, 30)
        );

        System.out.println("By name: " + minMax(boxers, Boxer::compareByName));
        System.out.println("By age: " + minMax(boxers, Boxer::compareByAge));
        System.out.println("By weight: " + minMax(boxers, Boxer::compareByWeight));
        System.out.println("By wins: " + minMax(boxers, Boxer::compareByWins));
    }

    static <T> MinMax<T> minMax(List<T> list, BiFunction<T, T, Integer> cmp)
    {
        if (list.isEmpty()) {
            return null;
        }

        T min = list.getFirst();
        T max = min;
        for(T item : list) {
            if (cmp.apply(item, min) < 0 ) {
                min = item;
            }
            if (cmp.apply(item, max) > 0 ) {
                max = item;
            }
        }

        return new MinMax<>(min, max);
    }

    static <T extends Comparable<T>> MinMax<T> minMaxCompare(List<T> list) {
        if (list.isEmpty()) {
            return null;
        }

        T min = list.getFirst();
        T max = min;
        for(T item : list) {
            if (item.compareTo(min) < 0) {
                min = item;
            }
            if (item.compareTo(max) > 0) {
                max = item;
            }
        }

        return new MinMax<>(min, max);
    }
}
