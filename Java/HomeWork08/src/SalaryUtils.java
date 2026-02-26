import java.math.BigDecimal;

public class SalaryUtils {
    public static BigDecimal calculateSalaryForOneMonth(Employee employee, Month month) {
        return employee.salary.multiply(BigDecimal.valueOf(month.workdaysCount));
    }

    public static BigDecimal calculateSalaryForManyMonths(Employee employee, Month[] months) {
        BigDecimal salary = new BigDecimal(0);
        for (Month month : months) {
            salary = salary.add(calculateSalaryForOneMonth(employee, month));
        }

        return salary;
    }
}
