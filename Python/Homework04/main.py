def task_01():
    """
    Prints numbers between 1 and 100 which are divided by 2 and 3 in the same time
    """

    numbers = []
    for num in range(0, 101):
        if num % 2 == 0 and num % 3 == 0:
            numbers.append(num)

    print(numbers)

def task_02():
    """
    Prints a sum of integer and float numbers in the given array
    """
    is_number = lambda item: isinstance(item, (int, float))
    src_arr = [1.2, 3, None, 100, {'info': 'bla-bla'}, 44, 'Hi!', 99, 44.32, None]
    numbers = list(filter(is_number, src_arr))
    print('V1. Сумма числовых элементов массива (filter)', sum(numbers))

    numbers = [item for item in src_arr if is_number(item)]
    print('V2. Сумма числовых элементов массива (list comprehension)', sum(numbers))

    number = []
    num_sum = 0
    for item in numbers:
        if not is_number(item):
            continue

        number.append(item)
        num_sum += item

    print('V2. Сумма числовых элементов массива (for cycle)', num_sum)

def task_03():
    """
    Asks user to enter messages while 'Пока' word won't be entered.
    Prints the last 5 entered messages (incl., 'Пока')
    """
    messages = []

    while True:
        message = input("?: ")

        messages.append(message)
        if len(messages) > 5:
            messages.pop(0)

        if message.lower() == 'пока':
            break

    print(messages)

if __name__ == '__main__':
    tasks = {
        1: task_01,
        2: task_02,
        3: task_03,
    }
    tasks_nums = list(tasks.keys())
    while True:
        task_num = int(input(f"Select task to execute {tasks_nums} or 0 to finish: "))

        if task_num == 0:
            break

        if  task_num in tasks:
            tasks[task_num]()
            print()
        else:
            print(f"Invalid task. Select from {tasks_nums}.")