pragma solidity ^0.4.24;

contract vault3 {
    address public account1;
    address public account2;
    address public account3;

    modifier onlyOwners (address _acct) {
        require((_acct == account1) || (_acct == account2) || (_acct == account2));
        _;
    }

    // accounts must be distict
    constructor (address _acct1, address _acct2, address _acct3) public {
        // addresses must be unique
        require((_acct1 != _acct2) && (_acct1 != _acct3) && (_acct2 != _acct3));
        account1 = _acct1;
        account2 = _acct2;
        account3 = _acct3;
    }

    // whatever sent msg.value is the deposit 
    function deposit() public payable {

    }

    function withdraw(address _acct) public onlyOwners(_acct) {
        uint256 contractBalance = address(this).balance;
        uint256 share = contractBalance / 3;

        account1.transfer(share);
        account2.transfer(share);
        account3.transfer(share);
    }
}