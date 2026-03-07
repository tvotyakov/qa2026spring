public class Employee extends Person {
    private final int salary;

    Employee(String name, int age, Gender gender, int salary) {
        super(name, age, gender);
        this.salary = salary;
    }

    public int getSalary() {
        return salary;
    }

    public boolean isSameName(Employee employee) {
        return this.getName().equals(employee.getName());
    }
}
