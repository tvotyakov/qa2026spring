void main() {

    System.out.println("Введите два целых числа:");
    Scanner sc = new Scanner(System.in);
    int a = sc.nextInt();
    int b = sc.nextInt();

    System.out.println("a + b = " + MyMath.add(a, b));
    System.out.println("a - b = " + MyMath.sub(a, b));
    System.out.println("a * b = " + MyMath.multi(a, b));
    System.out.println("a / b = " + MyMath.div(a, b));
}
