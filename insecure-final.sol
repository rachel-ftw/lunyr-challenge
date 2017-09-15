pragma solidity ^0.4.9;

// THIS CONTRACT CONTAINS BUGS - DO NOT USE
contract SecureAndOrganized {
  address owner;
  struct shareData {
    uint shareCount;
    bool isShareholder;
  }
  mapping(address => shareData) shares;
  address[] private shareholderList;
  bool isLocked;



  /*event FailedSend(address, uint);
  event*/

  modifier onlyBy(address _account){
    require(msg.sender == _account);
    _;
  }

  modifier isShareholder() {
    require(shares[msg.sender].isShareholder);
    _;
  }

  modifier noReentrance() {
    require(!isLocked);
    isLocked = true;
    _;
    isLocked = false;
  }

  ///////////////////////////////////////////////

  function SecureAndOrganized() {
    owner = msg.sender;
  }

  function addShares()
  payable
  onlyBy(owner)
  isShareholder
  {
    if(msg.value > 0) shares[msg.sender] += msg.value;
  }

  function addShareholder(address newShareholder)
  onlyBy(owner)
  constant
  {
    shareholderList.push(newShareholder);
  }

  function withdraw()
  onlyBy(owner)
  {
    var ownerShare = shares[msg.sender];
    shares[msg.sender] = 0;
    msg.sender.transfer(ownerShare);                             //transfer raises an exception on failure, so can take out the else.
  }

  function dispense()
  onlyBy(owner)
  noReentrance
  returns (bool success)
  {
    address _shareholder;
    for (uint i = 0; i < shareholderList.length; i++) {
      /*if(shares[shareholderList[i]] > 0)*/
      _shareholder = shareholderList[i];
      uint sh = shares[_shareholder];
      shares[_shareholder] = 0;
      _shareholder.send(sh);
    }
    returns success
  }
}
