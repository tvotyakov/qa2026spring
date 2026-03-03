def sum_ignore_non_numbers(items):
    """
    Sum up all items ignoring non-numbers.
    :param items: list of items to sum up.
    :return:
    """
    return sum(item for item in items if isinstance(item, (int, float)))

def run():
    print(sum_ignore_non_numbers([1, 2, 'Hey', None, 4.3]))