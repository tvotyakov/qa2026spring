def task_02():
    """
    Prints "Привет, меня зовут name" using three different approaches.
    name is input from console.
    """
    name = input("Введите ваше имя: ")
    print(f"Привет, меня зовут {name}")
    print("Привет, меня зовут " + name)
    print("Привет, меня зовут", name)


def task_03():
    """
    Prints "Привет, меня зовут Name Surname",
    where Name and Surname are input from console.
    """
    name = input("Введите имя: ")
    surname = input("Введите фамилию: ")
    print(f"Привет, меня зовут {name.title()} {surname.title()}")

def task_04():
    """
    Prints sum of two numbers input from console.
    """
    a = int(input("Enter first number: "))
    b = int(input("Enter second number: "))
    print(f"a + b = {a + b}")

if __name__ == '__main__':
    tasks = {
        2: task_02,
        3: task_03,
        4: task_04,
    }
    tasks_nums = list(tasks.keys())
    while True:
        task_num = int(input(f"Select task to execute {tasks_nums} or 0 to exit: "))

        if task_num == 0:
            break

        if  task_num in tasks:
            tasks[task_num]()
            print()
        else:
            print(f"Invalid task. Select from {tasks_nums}.")
