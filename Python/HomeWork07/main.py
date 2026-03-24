from Rectangle import Rectangle
from Car import Car

def test_rectangle():
    print("Testing Rectangle")
    rect = Rectangle(2, 4)
    area = rect.area()
    perimeter = rect.perimeter()

    assert rect.width == 2, "Rectangle width should be 2"
    assert rect.height == 4, "Rectangle height should be 4"
    assert area == 8, "Rectangle area should be 8"
    assert perimeter == 12, "Rectangle perimeter should be 12"

    print(rect)
    print("  Area: ", area)
    print("  Perimeter: ", perimeter)

def test_car():
    print("Testing Car")
    my_toyota = Car("Toyota", "Corolla", 180)

    assert my_toyota.make == "Toyota", "Model should be Toyota"
    assert my_toyota.model == "Corolla", "Model should be Corolla"
    assert my_toyota.max_speed == 180, "Max speed should be 180"
    assert my_toyota.speed == 0, "Speed should be 0 at the beginning"

    print(f"My {my_toyota} before acceleration")
    my_toyota.accelerate()
    my_toyota.accelerate()
    my_toyota.accelerate()
    assert my_toyota.speed == 30, "Speed should be 30"
    print(f"My {my_toyota} after acceleration")
    my_toyota.display_speed()

    my_toyota.brake()
    my_toyota.brake()
    assert my_toyota.speed == 10, "Speed should be 10"
    print(f"My {my_toyota} after braking")
    my_toyota.display_speed()

if __name__ == '__main__':
    test_rectangle()

    print()
    test_car()