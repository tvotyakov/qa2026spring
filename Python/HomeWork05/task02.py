def is_triangle(a, b, c):
    """
    Checks if given three sides (their lengths) form a valid triangle.
    :param a: length of side a
    :param b: length of side b
    :param c: length of side c
    :return: True, if triangle is valid, False otherwise.
    """
    return a + b > c

def run():
    print('is_triangle(2, 4, 9) = ', is_triangle(2, 4, 9))
    print('is_triangle(3, 4, 5) = ', is_triangle(3, 4, 5))