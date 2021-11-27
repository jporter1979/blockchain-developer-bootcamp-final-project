# This project makes use of the following design patterns:
**Inter-Contract Execution**: The Lottery contract calls the getRandomNumber function in the Random contract which requests a random number from the ChainLink VRF. The Random Contract upon receiving the random number calls the pickWinner function in the Lottery contract to randomly choose a winner.
**Inheritance and Interface**: The Lottery contract imports and uses the ChainLink KeeperCompatibleInterface to access the ChainLink Keeper service. The Random contract imports and uses VRFConsumerBase to access the ChainLink VRF service. 
**Oracles**: The Lottery contract uses the ChainLink Keeper service to trigger the selection of a random number after the elapsed time period. The Random contract uses the ChainLink VRF service to generate a random number.
**Access Control Design Patterns**: In the Lottery contract the following access control is being used:
 - Only the owner can call the initialize, startNewLottery and stopLottery functions.
 - Only the ChainLink Keeper registry can call the performUpKeep function.
 - Only the Random contract can call the pickWinner function. 
 In the Random contract the following access control is being used:
 - Only the owner can call the initialize function.
 - Only the Lottery contract can call the getRandomNumber function.
 - Only the VRF coordinator can call the fulfillRandomness function. 