// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract DeadMan{
    address public owner;
    address public defaultAddress;
    uint public lastAliveBlock;


    constructor(address _defaultAddress){
        owner = msg.sender;
        defaultAddress = _defaultAddress;
        lastAliveBlock = block.number;
    }

    function still_alive() public {
        require(msg.sender == owner, "Only the owners can call this");
        lastAliveBlock = block.number;
        
    }

    function checkInactivity() public {
        require(block.number > lastAliveBlock + 10, "Owner is still active");
        selfdestruct(payable(defaultAddress)); 
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
