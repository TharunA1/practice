// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint) public balances;

    // Event to log account creation
    event AccountCreated(address indexed account);

    // Event to log money addition
    event MoneyAdded(address indexed account, uint amount);

    // Function to create an account for a specific address
    function createAccount(address account) public {
        require(balances[account] == 0, "Account already exists");

        balances[account] = 0;
        emit AccountCreated(account);
    }

    // Function to add money to the account
    function addMoney(address account, uint amount) public payable {
        require(balances[account] >= 0, "Account does not exist");

        balances[account] += amount;
        emit MoneyAdded(account, amount);
    }

    // Function to get the balance of an account
    function getBalance(address account) public view returns (uint) {
        return balances[account];
    }
}
