// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

// Below is the contract for the Donator

contract Donator {

    string private d_name;
    string private d_location;
    uint private availableFunds = 0;


    function setName(string memory donorName) public {
        d_name = donorName;
    }

    function setLocation(string memory donorLocation) public {
        d_location = donorLocation;
    }

    function getName() view public returns (string memory) {
        return d_name;
    }

    function getLocation() view public returns (string memory) {
        return d_location;
    }

    function Donate(uint amount) external payable{
        availableFunds += amount;
    }

    function withdraw(uint amount) external payable {
        require(amount <= availableFunds, "Withdrawal amount must be less than TotalFunds");
        availableFunds -= amount;
    }

    function showBalance() view public returns (uint) {
        return availableFunds;
    }

}