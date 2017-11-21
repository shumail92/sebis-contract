/*
    Example Smart Contract for Blockchain Seminar Talk
    @author Shumail Mohyuddin - 14/11/2017
 */

pragma solidity ^0.4.11;

contract SebisContract {
    address public owner;
    mapping (address => uint) balances;

    event FailedTransaction (
        address _from,
        address _to,
        uint256 _amount
    );

    event SuccessfulTransaction (
        address _from,
        address _to,
        uint256 _amount
    );

    modifier ifFunds(address _to, uint _value) {
        if (balances[owner] <= _value) {
            FailedTransaction(msg.sender, _to, _value);
            throw;
        }
        _;
    }

    function SebisContract() {
        owner = msg.sender;
        balances[owner] = 1000;
    }

    function getBalance(address _user) constant returns (uint _balances) {
        return balances[_user];
    }

    // we know who's sending transaction by msg.sender
    function transfer() ifFunds(msg.sender, msg.value) payable returns (bool success) {
        balances[owner] -= msg.value;
        balances[msg.sender] += msg.value;
        SuccessfulTransaction(owner, msg.sender, msg.value);
        return true;
    }
}
