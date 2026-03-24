class BankAccount:
    def __init__(self, client_name, balance):
        """
        Initiates new BankAccount object for the given client name and balance.
        :param client_name: Not empty string representing the client name.
        :param balance: Non-negative integer representing the balance of the account.
        """
        assert client_name is not None and client_name != '', 'Client name cannot be empty!'
        assert isinstance(balance, int), 'Balance must be an integer!'
        assert balance is not None and balance >= 0, 'Balance cannot be negative!'

        self._client_name = client_name
        self._balance = balance

    def deposit(self, amount):
        """
        Deposits the given amount into the bank account.
        :param amount: Non-negative integer, amount to be deposited.
        :return: None
        """
        assert amount >= 0, 'Amount cannot be negative!'

        self._balance += amount

    def withdraw(self, amount):
        """
        Withdraws the given amount from the bank account.
        :param amount: Non-negative integer, amount to be withdrawn.
        :return: None or error message
        """
        assert amount >= 0, 'Amount cannot be negative!'

        if self._balance < amount:
            return 'Not enough money!'

        self._balance -= amount
        return None

    def get_balance(self):
        """
        Returns the current balance of the account.
        :return: Non-negative integer representing the current balance.
        """
        return self._balance

    def __str__(self):
        return f"{self.__class__.__name__}({self._client_name}, {self._balance})"