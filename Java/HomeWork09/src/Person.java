public class Person {
    private final String fullName;
    private final int age;
    private final Gender gender;

    Person(String name, int age, Gender gender) {
        assert name != null && !name.isEmpty() : "Name cannot be null or empty";

        this.age = age;
        this.gender = gender;

        String namePrefix = gender == Gender.MALE
                ? "Mr. "
                : gender == Gender.FEMALE
                    ? "Mrs. "
                    : "";

        this.fullName = namePrefix + name;
    }

    public String getName() {
        return fullName;
    }
}
