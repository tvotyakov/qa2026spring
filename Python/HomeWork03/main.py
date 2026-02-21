def task_01():
    """
    Prints "чётное/нечётное" depending on the number entered by the user.
    """
    num = int(input("Введите число: "))
    if num % 2 == 0:
        print("чётное")
    else:
        print("нечётное")

def task_02():
    """
    Prints type of the week day by its name entered by the user.
    """
    day = input("Какой сегодня день: ").lower()
    days_of_week = (
        "понедельник",
        "вторник",
        "среда",
        "четверг",
        "пятница",
        "суббота",
        "воскресенье")
    if day not in days_of_week:
        print("Указан некорректный день недели")
        return

    if day in (days_of_week[5], days_of_week[6]):
        print("Сегодня выходной!")
    elif day == days_of_week[2]:
        print("Мне сегодня к стоматологу в 15:30.")
    else:
        print("Сегодня обычный день.")

def task_03():
    """
    Prints text entered by the user one or more times.
    Number of repetitions are also entered by the user.
    """
    text = input("Введите текст для повторения: ")
    rep_count = int(input("Введите количество повторений текста: "))
    for i in range(rep_count):
        print(text)

def task_04():
    """
    Prints number of cyrillic vowels in the message entered by the user.
    """
    message = input("Введите ваше сообщение: ")
    cyrillic_vowels = "аеёиоуыэюя"

    vowel_count = 0
    for char in message:
        if char in cyrillic_vowels:
            vowel_count += 1

    print(f"Количество гласных в вашем сообщении: {vowel_count}")

def task_05():
    """
    Asks the user to enter integer numbers until his or her enters the negative one.
    After that it prints the sum of all entered numbers except the last (negative) one
    and finishes its job.
    """
    sum_of_numbers = 0
    while True:
        next_num = int(input("Введите целое число: "))
        if next_num < 0:
            break
        sum_of_numbers += next_num
    print("Сумма введённых положительных чисел:", sum_of_numbers)

if __name__ == '__main__':
    tasks = {
        1: task_01,
        2: task_02,
        3: task_03,
        4: task_04,
        5: task_05,
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

