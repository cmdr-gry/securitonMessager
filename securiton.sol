pragma solidity ^0.8.17;

contract Message {
    uint public msgIndex;
    string[] public messages;
    uint[] public messageExpiry;
    string[] public messagePassword;
    address[] public authorizedAddresses;
    mapping (address => bool) authorizedUsers;
    bool canView = false;

    constructor() public { }

    function setMessage(string memory newMessage, uint expiry, string memory password) public {
        messages.push(newMessage);
        messageExpiry.push(expiry);
        messagePassword.push(password);
        msgIndex++;
    }

    function authorizeAddress(address addr) public {
        authorizedAddresses.push(addr);
        authorizedUsers[addr] = true;
    }

    function viewMessage(address addr) public view {
        // check if user is authorized
        if (authorizedUsers[addr] == true) {
            canView = true;
        }
    }

    function checkPassword(string memory password) public view {
        // check if password is correct
if (keccak256(password) == keccak256(messagePassword[msgIndex])) {                canView = true;
        }
    }

    function checkExpiry(uint expiry) public view {
        // check if message is expired
        if (expiry > messageExpiry) {
            canView = false;
        }
    }
}