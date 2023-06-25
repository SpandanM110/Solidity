// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract Bird {
    string public name;
    uint public feet;
    bool public canFly;

    constructor(string memory _name, uint _feet, bool _canFly) {
        name = _name;
        feet = _feet;
        canFly = _canFly;

    }
}

contract BirdInfo is Bird {
    bool public food;
    constructor(string memory _name, uint _feet, bool _canFly, bool _food)
    Bird(_name, _feet, _canFly)
    {
        food = _food;
    }
    
}