// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleLottery {
    address public manager;
    address payable[] public participants;

    constructor() {
        manager = msg.sender;
    }

    // Function to enter the lottery
    function enter() public payable {
        require(msg.value > .01 ether, "Minimum Ether required is 0.01");
        participants.push(payable(msg.sender));
    }

    // Function to get the participants
    function getParticipants() public view returns (address payable[] memory) {
        return participants;
    }

    // Function to get the balance of the contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Function to pick a random winner (only manager can call this)
    function pickWinner() public restricted {
        require(participants.length > 0, "No participants in the lottery");

        uint index = random() % participants.length;
        participants[index].transfer(address(this).balance);

        // Reset the lottery
        delete participants;
    }

    // Modifier to restrict access to certain functions
    modifier restricted() {
        require(msg.sender == manager, "Only manager can call this function");
        _;
    }

    // Helper function to generate a random number
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants)));
    }
}
