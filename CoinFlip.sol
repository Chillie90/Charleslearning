pragma solidity 0.5.16;
import "./Ownable.sol";


contract Coinflip is Ownable{


  uint public bala;

    event wager(address gambler, uint bet, bool);
    event invnt(address owner, uint capital);

modifier costs(uint cost){
  require(msg.value >= cost, "Theres a 0.01 Ether minimum for this ride.");
  _;
}

modifier insuf(){
  require(address(this).balance >= msg.value, "You need more ether");
  _;
}

// experimental ceiling that varies per bet, Meaning the contract needs to at least have 4 times the betting amount return
// intent was to keep from being bankrupted after a couple of lucky rolls
/*modifier toom(){
  uint  thres = msg.value * 4;
  require(bala >= thres, ("You are about " + (bala - thres) / 4 + "too high"));
  _;
} */


  function coin() public payable costs(0.001 ether) insuf()  returns (bool){

    bool success;
      if (now % 2 == 0){
        bala += msg.value;
        success = false;


      } else if(now % 2 == 1)
      {
        bala -= msg.value;
        msg.sender.transfer(msg.value * 2);
        success = true;
      }

      emit wager(msg.sender, msg.value, success);
      return success;

  }
  function funBal() public payable costs(0.001 ether) {
    bala += msg.value;
  }

  function withdraw() public onlyOwner returns(uint) {
      uint xferBal = bala;
      bala = 0;
      msg.sender.transfer(xferBal);
      return xferBal;
  }
  function conBal() public view returns (address, uint, uint) {
    return (address(this),address(this).balance, bala);
  }
}
