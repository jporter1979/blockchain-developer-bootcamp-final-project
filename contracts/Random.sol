// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "./Lottery.sol";

/// @title A random number contract 
/// @author Jason Porter
/// @notice You can use this contract to generate a random number on the blockchain 
/// @dev All function calls are currently implemented without side effects
contract Random is VRFConsumerBase{
    bytes32 internal keyHash;  /// @notice Key hash used for call to VRF oracle
    uint256 internal fee;  /// @notice Fee required for oracle service 

    uint256 public randomResult;  /// @notice The random number returned by VRF
    address public lottery;  /// @notice The address of the lottery contract 

    /// @dev inherits constructor from VRFConsumerBase
    constructor() 
        VRFConsumerBase(
            0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9, // VRF Coordinator
            0xa36085F69e2889c224210F603D836748e7dC0088  // LINK Token
        )
    {
        keyHash = 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4;
        fee = 0.1 * 10 ** 18; // 0.1 LINK (Varies by network)
    }

    /// @notice Initializes random contract with address of lottery contract
    /// @param _lottery The address of the lottery contract
    function initialize(address _lottery) public{
        lottery = _lottery;
    }

    /// @notice Makes request to ChainLink VRF oracle for random number
    /// @return requestId - Unique id for random number request
    function getRandomNumber() public returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK - fill contract with faucet");
        require(msg.sender == lottery);
        return requestRandomness(keyHash, fee);
    } 

    /// @notice Callback function used by VRF Coordinator to return random number 
    // @param requestId Unique id for random number request
    /// @param randomness Random number returned by Chainlink VRF 
    function fulfillRandomness(bytes32 /*requestId*/, uint256 randomness) internal override {
        require(msg.sender ==  0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9);
        randomResult = randomness;
        Lottery(lottery).pickWinner(randomness);
    }   
}