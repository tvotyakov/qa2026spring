void main() {
    final Employee[] employees = {
            new Employee("Алекс", 22, Gender.MALE, new BigDecimal("500.00")),
            new Employee("Анна", 35, Gender.FEMALE, new BigDecimal("750.50")),
            new Employee("Женя", 40, Gender.OTHER, new BigDecimal("1000.00")),
    };

    Random rnd =  new Random();
    Scanner scanner = new Scanner(System.in);

    String continueCalculations = "y";
    while (continueCalculations.equals("y"))
    {
        var employee = employees[rnd.nextInt(employees.length)];

        System.out.println("Расчёт зарплаты для " + employee.name);

        var month = MonthUtils.MONTHS[rnd.nextInt(MonthUtils.MONTHS.length)];
        var salaryForMonth = SalaryUtils.calculateSalaryForOneMonth(employee, month);

        System.out.println("Зарплата за месяц " + month.name.toLowerCase() + ": " + salaryForMonth);

        var firstMonthIdx = rnd.nextInt(MonthUtils.MONTHS.length / 2);
        var lastMonthIdx = rnd.nextInt(firstMonthIdx + 1, MonthUtils.MONTHS.length);

        var months = new Month[lastMonthIdx - firstMonthIdx + 1];
        String monthNames = "";
        for (int i = firstMonthIdx, j = 0; i <= lastMonthIdx && j < months.length; i++, j++) {
            var curMonth = MonthUtils.MONTHS[i];
            monthNames += curMonth.name + ", ";
            months[j] = curMonth;
        }
        var salaryForMonths = SalaryUtils.calculateSalaryForManyMonths(employee, months);

        System.out.println("Зарплата за несколько месяцев (" + monthNames + "): " + salaryForMonths);

        System.out.print("Продолжить (y)? ");
        continueCalculations = scanner.next();
    }
}
