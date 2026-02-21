void main() {

    int taskNum;
    Scanner input = new Scanner(System.in);
    do {
        System.out.print("Choose a task number [4 - 11] or 0 to exit: ");
        taskNum = input.nextInt();
        if (taskNum == 0) {
            break;
        }

        switch (taskNum) {
            case 4: Task4.run(); break;
            case 5: Task5.run(); break;
            case 6: Task6.run(); break;
            case 7: Task7.run(); break;
            case 8: Task8.run(); break;
            case 9: Task9.run(); break;
            case 10: Task10.run(); break;
            case 11: Task11.run(); break;

            default: System.out.println("Invalid task number");
        }

    } while (true);
}
