// SPDX-License-Identifier: GPL-3.0

import "Donator.sol";
pragma solidity ^0.8.7;

contract NGO{
 
    address[] private donor;
    address[] private beneficiary;
    address[] private fundsTheft;
    string private d_Name;
    string private d_Location;
    uint private threshold = 10;
    uint private availableFunds = 0;
    uint private froudFunds = 0;
    uint private maxBalance = 50;

    //Donator object 
    Donator private d_instance;

    constructor() {
        d_instance = new Donator();
        addBeneficiary(address(d_instance)); 
    }

    function donate(address donorAddress, uint amount) public payable {

        require(donorAddress != address(0x00) , "Etherium address required in this field");
        require(amount >= 1, "Integer number required in this field");
        require(alertAll(), "Laundry detected!!");

        if(amount > threshold  ){
           addSuspect(donorAddress);
           froudFunds += amount;
        }
        if(amount <= threshold) {
            addDonors(donorAddress);
            availableFunds += amount;  
        }
    }

    function getFunds() view public returns (uint) { 
        return availableFunds;
    }

    function getDonor() view public returns (address[] memory){
        return donor;
    }

    function getDonatees() view public returns (address[] memory){
        return beneficiary;
    }
    
    function getTheft() view public returns (address[] memory){
        return fundsTheft;
    }

    function addDonors(address dAddress) private {
        donor.push(dAddress);
    }

    function addBeneficiary(address bAddress) private {
        beneficiary.push(bAddress);
    }

    function addSuspect(address _theft) private {
        fundsTheft.push(_theft);
    }

    function alertAll() view public returns (bool){
        if (availableFunds < maxBalance) {
            return true;
        }
        return false;
        
    }

    function giveBeneficiary(uint amount) external payable {
        require(amount <= availableFunds ,"Enter funds less than the availableFunds");
        d_instance.Donate(amount);
        availableFunds -= amount;
    }

    function withdraw(uint amount) public payable {
        d_instance.withdraw(amount);
    }
    
    function beneficiaryBalance() view public returns (uint256) {
        return d_instance.showBalance();
    }

    function setDonorLocation(string memory donorLocation) public {
        d_Location = donorLocation;
    }

    function setDonorName(string memory donorName) public {
        d_Name = donorName;
    }

    function getDonorLocation() view public returns (string memory) {
        return d_Location;
    }

    function getDonorName() view public returns (string memory) {
        return d_Name;
    }

}