// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/KeeperCompatibleInterface.sol";
import "./Random.sol"; 

/// @title A lottery contract 
/// @author Jason Porter
/// @notice You can use this contract to run a lottery on the blockchain
/// @dev All function calls are currently implemented without side effects
contract Lottery is KeeperCompatibleInterface{
  enum LOTTERY_STATE {OPEN, CLOSED, DRAWING}   /// @notice Enum for all possible states the lottery can be in
  LOTTERY_STATE public lottery_state;     /// @notice The current state of the lottery contract
  address[] public players;     /// @notice The players that have entered the lottery
  address payable public winner;    /// @notice The winner of the current run of the lottery
  address public owner;     /// @notice The individual who deployed the contract
  address public random;    /// @notice The address of the Random contract used to generate random numbers

  uint public duration;     /// @notice The time period that a lottery will run for
  uint public lastTimeStamp;    /// @notice Used as the starting time to measure the elapsed duration 

/// @notice Sets deployer as contract owner and initializes contract state to closed
  constructor(){
    owner = msg.sender;
    lottery_state = LOTTERY_STATE.CLOSED;
  }

  /// @notice Initializes lottery contract with address of random contract
  /// @param _random The address of the Random contract 
  function initialize(address _random) public{
    require(msg.sender == owner);
    random = _random;
  }

  /// @notice Allows players to enter the lottery by sending ETH
  /// @dev Function is payable and recieves ETH which is added to contract balance
  function enter() public payable{
    require(lottery_state == LOTTERY_STATE.OPEN, "Lottery not yet open");
    players.push(msg.sender);
  }

  /// @notice Starts a new lottery of length "duration"
  /// @param _duration The time duration for the lottery
  /// @dev Parameter is integer representing time period in seconds
  function startNewLottery(uint256 _duration) public{
    require(msg.sender == owner);
    require(lottery_state == LOTTERY_STATE.CLOSED, "Can't start a new lottery");
    lottery_state = LOTTERY_STATE.OPEN;
    winner = payable (address(0));
    duration = _duration;
    lastTimeStamp = block.timestamp;
  }

  /// @notice ChainLink Keeper function to run a timer of length "duration"
  /// @dev The parameter is not used in this function as no call data is required
  /// @return upkeepNeeded - Boolean value indicating whether upkeep is needed 
  function checkUpkeep(bytes calldata /* checkData */) external view override returns (bool upkeepNeeded, bytes memory /* performData */) {
    if(lottery_state == LOTTERY_STATE.OPEN){
        upkeepNeeded = (block.timestamp - lastTimeStamp) >= duration;
    }
    else{
        upkeepNeeded = false;
    }
  }

  /// @notice ChainLink Keeper function to perform process of getting random number once "duration" has elapsed
  /// @dev The parameter is not used as no call data is required. Function calls Random contract.
  function performUpkeep(bytes calldata /* performData */) external override {
    require(msg.sender == 0x4Cb093f226983713164A62138C3F718A5b595F73);
    lottery_state = LOTTERY_STATE.DRAWING;
    Random(random).getRandomNumber();
  }

  /// @notice Chooses a winner randomly from the list of players and transfers the lottery pool to the winner then closes the lottery
  /// @dev Function is called by the Random contract 
  function pickWinner(uint256 randomness) external{
    require(msg.sender == random);
    require(lottery_state == LOTTERY_STATE.DRAWING, "Not time to choose winner");
    require(randomness > 0, "random not found");
    uint256 index = randomness % players.length;
    winner = payable (players[index]);
    winner.transfer(address(this).balance);
    players = new address[](0);
    lottery_state = LOTTERY_STATE.CLOSED;
  }

  /// @notice Returns the entered players
  function getPlayers() public view returns (address[] memory) {
    return players;
  }

  /// @notice Returns the lottery pool balance
  function getPool() public view returns(uint256){
    return address(this).balance;
  }

  /// @notice Circuit breaker function to stop lottery in emergency
  function stopLottery() public{
    require(msg.sender == owner);
    lottery_state = LOTTERY_STATE.CLOSED;
  }

}
