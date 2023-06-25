// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 <0.9.0;

contract partOne {
    address public owner;
    constructor () {
        owner = msg.sender;
    }
}
contract partTwo is partOne{
    uint public ownerBalance;
    constructor () {
        ownerBalance = 500;
    }
}
