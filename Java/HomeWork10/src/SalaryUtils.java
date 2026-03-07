public class SalaryUtils {
    public static int getTotalSalary(Employee[] employees, Month[] months){
        var totalSalary = 0;
        for(var employee : employees){
            totalSalary += employee.getSalary(months);
        }

        return totalSalary;
    }
}
