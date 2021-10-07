// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Lottery {

mapping(address => uint) public betNumber; //Keeps track of the number betted by each better.
mapping(address => uint) public betAmount; //Keeps track of the amount of money betted by each better.
address public owner; //The owner of the lottery smart contract.
uint public result; //The randomly chosen number for the lottery.
enum State {Active, Betted, Paidout, Inactive}
State public state; //The current state of the lottery contract.

  constructor(){
    owner = msg.sender;
    state = State.Active;
  }

  function bet(uint _betNumber) public payable{} //Allows a better to bet and supply a number.

  function abort() public{} //Allows the owner to disable the lottery contract.

  function release() payable public{} //Allows the contract to release the funds to the winner.

  function getRandomNumber() public returns (bytes32 requestId){} //Requests randomness from Chainlink VRF.

  function fulfillRandomness(bytes32 requestId, uint randomness) internal {} //Callback function used by VRF Coordinator

}
