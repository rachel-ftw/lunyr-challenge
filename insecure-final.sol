pragma solidity ^0.4.9;

// THIS CONTRACT CONTAINS BUGS - DO NOT USE
contract SomewhatSecureAndOrganized {
  address owner;
  address[] private shareholderList;
  bool isLocked;
  struct shareData {
    uint shareCount;
    bool isShareholder;
  }
  mapping(address => shareData) shares;

  event FailedSend(address indexed shareholder, uint sharesCount);
  event DispensedShares(address indexed shareholder, uint shareCount)
  event SuccessfulWithdraw(address indexed shareholder, uint shareCount)
  event ShareholderAdded(address indexed shareholder)
  event SharesAdded(address indexed shareholder, uint shareCount, uint shareTotal)

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

  function SomewhatSecureAndOrganized() {
    owner = msg.sender;
  }

  function addShares()
  payable
  isShareholder
  {
    if(msg.value > 0) shares[msg.sender] += msg.value;
    SharesAdded(msg.sender, msg.value, shares[msg.sender].shareCount);
  }

  function addShareholder(address newShareholder)
  onlyBy(owner)
  constant {
    require(!shares[shareholder.isShareholder]);
    assert(0 == shares[shareholder.shareCount]);

    shareholderList.push(newShareholder);
    shares[newShareholder].isShareholder = true;
    ShareholderAdded(newShareholder);
  }

  function withdraw()
  onlyBy(owner)
  noReentrance {
    uint currentShares = shares[msg.sender].shareCount;
    shares[msg.sender].shareCount = 0;

    if (msg.sender.send(currentShares)) {
      SuccessfulWithdraw(msg.sender, currentShares);
    } else {
      shares[msg.sender].shareCount = currentShares;
      FailedSend(msg.sender, shareCount);
    }
  }

  function dispense()
  onlyBy(owner)
  noReentrance
  returns (bool success) {
    success = false;
    address _shareholder;
    uint shareholderCount = shareholderList.length;
    uint successfulDispenses = 0;
    uint shareCount;
    uint i

    for (i = 0; i < shareholderCount; i++) {
      _shareholder = shareholderList[i];
      shareCount = shares[_shareholder].shareCount;

      if (shareCount > 0) {
        shares[_shareholder].shareCount = 0;

        if(shareholder.send(shareCount)){
          DispensedShares(shareholder, shareCount);
          successfulDispenses++;
        } else {
          shares[shareholder].shareCount = shareCount;
          FailedSend(shareholder, shareCount);
        }
      } else {
        successfulDispenses++;
      }
      success = (successfulDispenses == shareholderCount);
      returns success
    }
  }
}
