from task01 import registration_v2, RegistrationError

def run():
    while True:
        username = input("Enter your username: ")
        password = input("Enter your password: ")

        try:
            if registration_v2(username, password):
                print("You have successfully registered!")
                break
        except RegistrationError as e:
            print(f"Registration error: {e}")
            print("Please try again!")