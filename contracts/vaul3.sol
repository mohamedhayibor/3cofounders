pragma solidity ^0.4.24;

contract vault3 {
    address public account1;
    address public account2;
    address public account3;

    // There's only one God account1
    // with the only extra privilege to change account2 or account3
    modifier onlyGod() {
        require(msg.sender == account1);
        _;
    }

    modifier onlyOwners () {
        require((msg.sender == account1) || (msg.sender == account2) || (msg.sender == account2));
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

    // withdraw first then change the account
    function changeAcct2(address _newAcct) onlyGod public {
        require((_newAcct != account1) && (_newAcct != account3), "Addresses must be unique");
        withdraw();
        account2 = _newAcct;
    }

    function changeAcct3(address _newAcct) onlyGod public {
        require((_newAcct != account1) && (_newAcct != account2), "Addresses must be unique");
        withdraw();
        account3 = _newAcct;
    }

    function withdraw() public onlyOwners {
        uint256 contractBalance = address(this).balance;
        uint256 share = contractBalance / 3;

        account1.transfer(share);
        account2.transfer(share);
        account3.transfer(share);
    }

    // any of the owners can kill the contract
    // liquidation of the company | disputes
    function withdrawAndKill() onlyOwners public {
        withdraw();
        selfdestruct(0);
    }
}