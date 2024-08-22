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

    function addUser(address _userAddress, string memory _role, string memory _name) public onlyOwner {
        require(!users[_userAddress].exists, "User already exists");
        users[_userAddress] = User(_role, _name, true);
        emit UserAdded(_userAddress, _role, _name);
    }

    function removeUser(address _userAddress) public onlyOwner userExists(_userAddress) {
        delete users[_userAddress];
        emit UserRemoved(_userAddress);
    }

    function getUserRole(address _userAddress) public view userExists(_userAddress) returns (string memory) {
        return users[_userAddress].role;
    }

    function isUserInRole(address _userAddress, string memory _role) public view userExists(_userAddress) returns (bool) {
        return keccak256(abi.encodePacked(users[_userAddress].role)) == keccak256(abi.encodePacked(_role));
    }

    function isAuthorized(address _userAddress, string memory _role) public view userExists(_userAddress) returns (bool) {
        return keccak256(abi.encodePacked(users[_userAddress].role)) == keccak256(abi.encodePacked(_role)) || keccak256(abi.encodePacked(users[_userAddress].role)) == keccak256(abi.encodePacked("admin"));
    }
}