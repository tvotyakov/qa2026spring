class Car:
    ACCELERATION_SPEED = 10
    BREAK_SPEED = 10

    def __init__(self, make, model, max_speed):
        self.make = make
        self.model = model
        self.max_speed = max_speed
        self.speed = 0

    def accelerate(self):
        self.speed = min(self.max_speed, self.speed + self.ACCELERATION_SPEED)

    def brake(self):
        self.speed = max(self.speed - self.BREAK_SPEED, 0)

    def display_speed(self):
        print(f"Current speed: {self.speed}")

    def __repr__(self):
        return f"Car({self.make}, {self.model}, {self.max_speed}, {self.speed})"