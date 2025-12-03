// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BadVault {
    mapping(address => uint) public balances;
    address public owner;

    constructor() {
        owner = tx.origin;
    }

    function deposit() public payable {
        balances[tx.origin] += msg.value; 
    }

    function withdraw() public {
        uint amount = balances[msg.sender];
        (bool success, ) = msg.sender.call{value: amount}("");
        balances[msg.sender] = 0;
    }

    function drainAll() public {
        payable(msg.sender).transfer(address(this).balance);
    }

    function suicide() public {
        selfdestruct(payable(owner)); 
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
