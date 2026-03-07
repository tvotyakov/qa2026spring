public class Manager extends Employee {
    private final int subordinateCount;

    public Manager(int id, String name, int salaryPerDay, Integer age, Gender gender, int subordinateCount) {
        super(id, name, salaryPerDay, age, gender);

        assert subordinateCount > 0 : "Subordinate count must be a positive value";

        this.subordinateCount = subordinateCount;
    }

    public Manager(int id, String name, int salaryPerDay, int subordinateCount) {
        this(id, name, salaryPerDay, null, null, subordinateCount);
    }

    public int getSubordinateCount() {
        return subordinateCount;
    }

    @Override
    public int getSalary(Month[] months) {
        var salary = super.getSalary(months);

        return addSalaryBonus(salary);
    }

    protected int addSalaryBonus(int salary) {
        return salary + salary * subordinateCount / 100;
    }
}
