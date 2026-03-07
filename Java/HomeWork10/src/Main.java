void main() {
    // Ordinary Employees
    var alexEmp = new Employee(1, "Alex", 200);
    var bobEmp = new Employee(2, "Bob", 125);
    var fredEmp = new Employee(3, "Fred", 170);
    var mindyEmp  = new Employee(4, "Mindy", 233);
    var sandyEmp  = new Employee(5, "Sandy", 70);

    // Two managers
    var wendyMng = new Manager(10, "Wendy", 300, 2);
    var johnMng = new Manager(20, "John", 300, 3);

    // Director
    var bruceDirector = new Director(1000, "Bruce", 5000, 7);

    System.out.println(alexEmp.getName() + "'s First Quarter Salary: " + alexEmp.getSalary(MonthUtils.QUARTERS[0]));
    System.out.println(mindyEmp.getName() + "'s First Half a Year Salary: " + mindyEmp.getSalary(MonthUtils.HALF_YEARS[0]));

    System.out.println(wendyMng.getName() + "'s Second Quarter Salary: " + wendyMng.getSalary(MonthUtils.QUARTERS[1]));
    System.out.println(johnMng.getName() + "'s Second Half a Year Salary: " + johnMng.getSalary(MonthUtils.HALF_YEARS[1]));

    System.out.println(bruceDirector.getName() + "'s Year Salary: " + bruceDirector.getSalary(MonthUtils.MONTHS));

    // expected total salary in January:
    //     emp: (200 + 125 + 170 + 233 + 70) * 20 = 15960
    //     managers: (300 * 20 + 300 * 20 * 2 / 100) + (300 * 20 + 300 * 20 * 3 / 100) = 12300
    //     director: 5000 * 20 + 5000 * 20 * 7 * 3 / 100 = 121000
    //     total: 149260
    System.out.println("All Employees Total Salary in January: " +
            SalaryUtils.getTotalSalary(
                    new Employee[] {alexEmp, bobEmp, fredEmp, mindyEmp, sandyEmp, wendyMng, johnMng, bruceDirector },
                    new Month[] {MonthUtils.JANUARY}));
}
