# This project avoids the following pitfalls and attacks:
**Proper use of Require, Assert and Revert**: The require clause is used as follows:
In the Lottery contract:
 - The message sender is the owner for calls to the initialize, startNewLottery and stopLottery functions.
 - The message sender is the ChainLink Keeper registry for calls to the performUpKeep function.
 - The message sender is the Random contract for calls to the pickWinner function. 
 - The lottery state is closed before a new lottery can be started.
 - The lottery state is open before any players are allowed to enter.
 - The lottery state is drawing and a random number is found before a winner is picked.
 In the Random contract:
 - The message sender is the owner for calls to the initialize function.
 - The message sender is the Lottery contract for calls to the getRandomNumber function.
 - The message sender is the VRF coordinator for calls to the fulfillRandomness function. 
 - The contract has sufficient LINK before a call to the ChainLink VRF is made.
 **Pull over Push**: The Lottery contract (which is the main contract) only makes one external call which is to the Random contract. However, it receives calls from:
 - The ChainLink Keepers which routinely make calls to checkUpkeep and performUpkeep.
 - Any number of players wishing to enter the lottery.
 - The Random contract which returns a random number.
 **Forcibly Sending Ether**: The Lottery contract stores an ether balance from all entered players and sends this balance to the winner. In order to prevent an attacker from forcing the contract to send ether a number of factors must occur:
 - Only one function is able to send ether.
 - This funtion can only be called by the Random contract.
 - The Lottery has to be in the drawing state which can only occur if a ChainLink Keeper calls performUpkeep on Random.getRandomNumber.

