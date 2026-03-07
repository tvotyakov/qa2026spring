public class Director extends Manager {

    public Director(int id, String name, int salaryPerDay, Integer age, Gender gender, int subordinateCount) {
        super(id, name, salaryPerDay, age, gender, subordinateCount);
    }

    public Director(int id, String name, int salaryPerDay, int subordinateCount) {
        super(id, name, salaryPerDay, subordinateCount);
    }

    @Override
    protected int addSalaryBonus(int salary) {
        return salary + salary * getSubordinateCount() * 3 / 100;
    }
}
