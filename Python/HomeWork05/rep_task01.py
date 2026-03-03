def run():
    text = input("Введите строку для преобразования: ")
    result = "".join(c.upper() if i % 2 == 0 else c.lower()
                     for i, c in enumerate(text))

    print(result)