package school.redrover.tvotyakov;

public class Boxer {
    public final String name;
    public final int age;
    public final int weight;
    public final int wins;

    Boxer(String name, int age, int weight) {
        this(name, age, weight, 0);
    }

    Boxer(String name, int age, int weight, int wins) {
        this.name = name;
        this.age = age;
        this.weight = weight;
        this.wins = wins;
    }

    public static int compareByName(Boxer a, Boxer b) {
        return a.name.compareTo(b.name);
    }

    public static int compareByAge(Boxer a, Boxer b) {
        return a.age - b.age;
    }

    public static int compareByWeight(Boxer a, Boxer b) {
        return a.weight - b.weight;
    }

    public static int compareByWins(Boxer a, Boxer b) {
        return a.wins - b.wins;
    }

    @Override
    public String toString() {
        return String.format(
            "Boxer(%s, age=%d, weight=%d, wins=%d)",
            name, age, weight, wins);
    }
}