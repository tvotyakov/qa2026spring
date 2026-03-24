from BankAccount import BankAccount

class OverdraftAccount(BankAccount):
    def withdraw(self, amount):
        """
        Withdraw funds from this account allowing negative balance.
        :param amount: Non-negative integer representing the amount to withdraw.
        :return: None
        """
        self._balance -= amount