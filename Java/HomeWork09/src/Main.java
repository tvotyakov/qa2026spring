void main() {
    // Task 1
    var timofey = new Person("Timofey", 40, Gender.MALE);
    var elena = new Person("Elena", 40, Gender.FEMALE);
    var victor = new Person("Victor", 20, Gender.OTHER);

    var persons = new Person[]{ timofey, elena, victor };

    System.out.println("Defined persons: ");
    for(var person : persons) {
        System.out.println(person.getName());
    }

    System.out.println("------------");
    // Task 2
    var timofeyEmp = new Employee("Timofey", 40, Gender.MALE, 1000);
    var anotherTimofeyEmp = new Employee("Timofey", 40, Gender.MALE, 2000);
    var elenaEmp = new Employee("Elena", 40, Gender.FEMALE, 3000);

    System.out.println("Employee Timofey has the same name as another employee Timofey: " +
            timofeyEmp.isSameName(anotherTimofeyEmp));

    System.out.println("Employee Timofey has the same name as employee Elena: " +
            timofeyEmp.isSameName(elenaEmp));

    System.out.println("------------");

    // Task 3
    System.out.println(getTotalSalaryMessage(new Employee[] {timofeyEmp, anotherTimofeyEmp, elenaEmp}));
    System.out.println(getTotalSalaryMessage(new Employee[] {timofeyEmp, anotherTimofeyEmp}));
    System.out.println(getTotalSalaryMessage(new Employee[] {elenaEmp}));
}

private String getTotalSalaryMessage(Employee[] employees) {
    var employeeNames = new String[employees.length];
    for (var i = 0; i < employees.length; i++) {
        employeeNames[i] = employees[i].getName();
    }

    return "Employees' " + Arrays.toString(employeeNames) +
            " total salary: " + Salary.getSum(employees);
}
