public class Salary {
    public static int getSum(Employee[] employees) {
        int sum = 0;
        for (Employee employee : employees) {
            sum += employee.getSalary();
        }

        return sum;
    }
}
