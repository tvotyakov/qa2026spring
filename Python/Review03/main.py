def task3():
    input_string = input("Введите целое число: ")
    if len(input_string) != 2:
        print(False)
        exit()

    # variant 1
    if input_string[0] == input_string[1]:
        print("Да")
    else:
        print("Нет")

    # variant 2
    num = int(input_string)
    first_digit = num // 10
    second_digit = num % 10
    if first_digit == second_digit:
        print("Да")
    else:
        print("Нет")

def task4():
    password = input("Введите пароль: ")
    confirm_password = input("Повторите пароль: ")
    if len(password) < 8:
        print("Пароль слишком короткий")
    elif password == confirm_password:
        print("Пароль принят")
    else:
        print("Пароль не принят")

def task5():
    str_val = input("Введите число больше или равно 0 и меньше 1000: ")
    if len(str_val) == 0 or len(str_val) > 3:
        print("Некорректное число")
        exit()

    int_val = int(str_val)
    if 0 <= int_val < 10:
        print("Число однозначное")
    elif int_val < 100:
        print("Число двузначное")
    else:
        print("Число трехзначное")

def task6():
    name = input("Введите имя девушки: ")
    hobby = input("Её увлечения: ").lower()

    if hobby == "музыка":
        place_to_go = "на концерт"
    elif hobby == "спорт":
        place_to_go = "в поход"
    elif hobby == "театр":
        place_to_go = "в театр"
    else:
        place_to_go = "в ресторан"

    print(f"{name}, пойдём {place_to_go}?")

while True:
    # task4()
    # task5()
    task6()
    if input("Continue (y/n) ").lower() == "n":
        break
