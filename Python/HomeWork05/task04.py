def common_strings(list1, list2, ignore_case = True):
    """
    Searches for common strings in two lists of strings comparing elements
    in case-insensitive manner if ignore_case is True.
    Elements in the returning list should be in lower register.

    :param list1: first list of strings to compare
    :param list2: second list of strings to compare
    :param ignore_case: case-insensitive comparison if True
    :return: list of common strings in the lower register
    """
    if ignore_case:
        list1 = [s.lower() for s in list1]
        list2 = [s.lower() for s in list2]

    result_list = [s.lower() for s in list1 if s in list2]
    return result_list

def run():
    fruits_1 = ['banana', 'APPLE', 'watermelon', 'cherry']
    fruits_2 = ['Mango', 'apple', 'orange', 'cherry']

    print(common_strings(fruits_1, fruits_2))
    print(common_strings(fruits_1, fruits_2, ignore_case = False))