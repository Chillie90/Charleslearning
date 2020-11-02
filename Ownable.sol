pragma solidity 0.5.16;

contract Ownable {

    address public owner;
    constructor() public{
      owner = msg.sender;
    }


    modifier onlyOwner() {
    require(msg.sender == owner, "Not permitted.");
    _;
    }

    function xferownership(address newOwner) public onlyOwner {
    require(newOwner != address(owner));
      owner = newOwner;
    }








}
