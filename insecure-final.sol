pragma solidity ^0.4.9;

// THIS CONTRACT CONTAINS BUGS - DO NOT USE
contract InsecureAndMessy {
   mapping(address => uint) shares;
   address owner;
   address[] allShareholders;
   /*event FailedSend(address, uint);*/

   function InsecureAndMessy() {
      owner = msg.sender;
   }

   function pay() payable {
      shares[msg.sender] += msg.value;
   }

   function addShareholder(address newShareholder) constant {
      require(msg.sender == owner);
      allShareholders.push(newShareholder);
   }

   function withdraw() {
     var ownerShare = shares[msg.sender];
     shares[msg.sender] = 0;
     msg.sender.transfer(ownerShare);                             //transfer raises an exception on failure, so can take out the else.
   }

   function dispense() {
      require(msg.sender == owner);
      address shareholder;
      for (uint i = 0; i < allShareholders.length; i++) {
         shareholder = allShareholders[i];
         uint sh = shares[shareholder];
         shares[shareholder] = 0;
         shareholder.send(sh);
      }
   }
}
