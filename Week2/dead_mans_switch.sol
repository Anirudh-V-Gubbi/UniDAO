// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DeadMansSwitch {
    address contractOwner;
    address beneficiary;
    uint lastActiveBlock;
    
    constructor(address _beneficiary) {
        contractOwner = msg.sender;
        beneficiary = _beneficiary;
        lastActiveBlock = block.number;
    }
    
    function still_alive() public {
        require(msg.sender == contractOwner);
        lastActiveBlock = block.number;
    }
    
    function isOwnerAlive() public view returns (bool) {
        return (block.number - lastActiveBlock) <= 10;
    }
    
    function transferFunds() public {
        require(!isOwnerAlive());
        selfdestruct(payable(beneficiary));
    }
}
