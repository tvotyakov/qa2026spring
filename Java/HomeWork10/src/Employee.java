public class Employee {
    private final int id;
    private final String name;
    private final Integer age;
    private final Gender gender;
    private final int salaryPerDay;

    public Employee(int id, String name, int salaryPerDay, Integer age, Gender gender) {
        assert name != null && !name.isEmpty() : "Employee name is required";
        assert salaryPerDay > 0 : "Salary should be a positive value";
        assert age == null || age > 0 : "Age should be a positive value";

        this.id = id;
        this.name = name;
        this.salaryPerDay = salaryPerDay;
        this.age = age;
        this.gender = gender;
    }

    public Employee(int id, String name, int salaryPerDay) {
        this(id, name, salaryPerDay, null, null);
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Integer getAge() {
        return age;
    }

    public Gender getGender() {
        return gender;
    }

    public int getSalaryPerDay() {
        return salaryPerDay;
    }

    public int getSalary(Month[] monthArray) {
        var sum = 0;
        for (var month : monthArray) {
            sum += month.getWorkdaysCount() * this.salaryPerDay;
        }

        return sum;
    }
}
