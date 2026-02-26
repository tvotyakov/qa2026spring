import java.math.BigDecimal;

public class Employee {
    public String  name;
    public int age;
    public Gender gender;
    public BigDecimal salary;

    public Employee(String name, int age,  Gender gender, BigDecimal salary) {
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.salary = salary;
    }
}
