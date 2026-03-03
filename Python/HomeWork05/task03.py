def average(*numbers):
    """
    Calculates the average of given numbers

    :param numbers to calculate the average of

    :return: average of given numbers
    """
    return sum(numbers) / len(numbers) if len(numbers) > 0 else 0

def run():
    print('average() = ', average())
    print('average(1, 2, 3, 4, 5, 6, 7, 8) = ', average(1, 2, 3, 4, 5, 6, 7, 8))