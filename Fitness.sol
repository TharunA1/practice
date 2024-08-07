// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FitnessRewards {
    address public admin;
    mapping(address => uint) public rewards;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    function addRewardPoints(address member, uint points) public onlyAdmin {
        rewards[member] += points;
    }

  function checkRewardPoints(address member) public view returns (uint) {
    return rewards[member]; 
}

}