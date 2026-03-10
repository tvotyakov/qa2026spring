vowels = 'aeiouyAEIOUYаеёиоуыэюяАЕЁИОУЫЭЮЯ'

def snake_talk(text):
    result = ''.join(map(lambda c: c + c if c in vowels else c, text))
    return result

def run():
    print(snake_talk('hello'))
    print(snake_talk('world'))
    print(snake_talk('Harry'))
    print(snake_talk('Гарри Поттер'))