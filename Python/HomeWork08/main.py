from random import randint
from BankAccount import BankAccount
from OverdraftAccount import OverdraftAccount

def test_bank_account(account):
    print("Test account:", account)
    print("Initial balance:", account.get_balance())

    account.deposit(account.get_balance() * 150 // 100)
    print("Deposited balance:", account.get_balance())

    result = account.withdraw(account.get_balance() * 50 // 100)
    if result:
        print("Withdraw failed:", result)
    print("Balance after withdrawing:", account.get_balance())

    amount = account.get_balance() + randint(1, 1000)
    print(f'Trying to overdraft account withdrawing {amount} amount')
    result = account.withdraw(amount)
    if result:
        print("Withdraw failed:", result)

    print("Current balance:", account.get_balance())

def task3():
    users = [
        {'id': 345324, 'name': 'Alice', 'age': 25},
        {'id': 1232, 'name': 123, 'age': 30},
        {'id': 7854, 'name': 'Bob', 'age': 22},
        {'id': 33412, 'name': None, 'age': 35},
        {'id': 78845, 'name': 'Charlie', 'age': 28},
        {'id': 45325, 'name': 'Eve', 'age': 40},
        {'id': 745633, 'name': True, 'age': 19},
        {'id': 64364, 'name': 'Frank', 'age': 33}
    ]

    print("Variant 1")
    print(list(
        map(lambda user: user['id'],
            filter(
                lambda user: not isinstance(user['name'], str),
                users
            )
        )
    ))

    print("Variant 2")
    print(list(
        user['id'] for user in users
            if not isinstance(user['name'], str)
    ))

if __name__ == '__main__':
    test_bank_account(BankAccount("Maria", 1000))
    print()
    test_bank_account(OverdraftAccount("Peter", 500))
    print()
    task3()