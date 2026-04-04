def registration_v1(username: str, password: str) -> bool:
    """
    Register user with username and password
    :param username: letters only string of 4-15 symbols
    :param password: alfa-numeric string of 8-45 symbols
    :return: True if registration was successful
    :exception ValueError: if username or password is invalid
    """
    if len(username) < 4 or len(username) > 15 or not str.isalpha(username):
        raise ValueError("username must be 4-15 letters only string")

    if len(password) < 8 or len(password) > 45 or not str.isalnum(password):
        raise ValueError("password must be 8-45 letter-numeric only string")

    return True

class RegistrationError(ValueError):
    pass

def registration_v2(username: str, password: str) -> bool:
    """
    Register user with username and password
    :param username: letters only string of 4-15 symbols
    :param password: alfa-numeric string of 8-45 symbols
    :return: True if registration was successful
    :exception ValueError: if username or password is invalid
    """
    if len(username) < 4 or len(username) > 15 or not str.isalpha(username):
        raise RegistrationError("username must be 4-15 letters only string")

    if len(password) < 8 or len(password) > 45 or not str.isalnum(password):
        raise RegistrationError("password must be 8-45 letter-numeric only string")

    return True

def run():
    username = "admin"
    password = "sadf1234"

    print(f"Registration(v1): {username}/{password}")
    if registration_v1(username, password):
        print("Registration(v1) successful!")

    print(f"Registration(v2): {username}/{password}")
    if registration_v2(username, password):
        print("Registration(v2) successful!")

    try:
        print(f"Registration(v1) short username")
        if registration_v1("adm", ""):
            print("Registration(v1) successful!")
    except ValueError as e:
        print(f"Registration(v1) failed: {e}")

    try:
        print(f"Registration(v2) with short username")
        if registration_v2("adm", ""):
            print("Registration(v1) successful!")
    except RegistrationError as e:
        print(f"Registration(v2) failed: {e}")