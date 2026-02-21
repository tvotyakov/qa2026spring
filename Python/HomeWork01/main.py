def task_01():
    """
    Prints "Hello World" using print() function
    """
    print("Hello World")

def task_02():
    """
    Prints "Я люблю:" and three enumerated points with the things I like.
    """
    print("Я люблю:")
    print("1. Программировать")
    print("2. Смотреть фильмы")
    print("3. Играть в игры")

if __name__ == '__main__':
    tasks = { 1: task_01, 2: task_02, }
    while True:
        task_num = int(input("Select task to execute (1, 2): "))

        if task_num == 0:
            break

        if  task_num in tasks:
            tasks[task_num]()
            print()
        else:
            print("Invalid task. Select from 1, or 2.")
