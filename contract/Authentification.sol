// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Authentification {
    struct User {
        string role;
        string name;
        bool exists;
    }

    mapping(address => User) public users;
    address public owner;

    event UserAdded(address indexed UserAddress, string role, string name);
    event UserRemoved(address indexed UserAddress);

    constructor() {
        owner = msg.sender;   
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    modifier userExists(address _userAddress) {
        require(users[_userAddress].exists, "User does not exist");
        _;
    }
}