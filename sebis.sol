/*
    Example Smart Contract for Blockchain Seminar Talk
    @author Shumail Mohyuddin - 14/11/2017
 */

pragma solidity ^0.4.0;

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
        if (balances[msg.sender] <= _value) {
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
    function transfer(address _to, uint _value) ifFunds(_to, _value) returns (bool success) {
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        SuccessfulTransaction(msg.sender, _to, _value);
        return true;
    }
}
