Decentralized Lottery System

The goal of this project is to develop a decentralized lottery system for the Ethereum Blockchain. The idea is to allow a user to anonymously partake in the lottery and to win the funds from a lottery pool if they have been randomly selected.

Lottery Dapp Workflow
- The user will connect to a web3 site using their wallet.
- The user's wallet address will uniquely identify them to the system. 
- The user will enter an amount of ether to be transferred to a lottery pool maintained by the smart contract. 
- The system will verify the funds exists in the user's wallet before making the transfer.
- After an elapsed period of time a function in the smart contract will be triggered which will result in the random selection of a lottery winner.
- The smart contract will automatically transfer all the funds from the pool to the address of the winner.

In order to create "randomness" on the blockchain the ChainLink VRF orcale is used in the random selection of the winner. The ChainLink Alarm Clock oracle is also used to set a time period after which the smart contract will be automatically triggered to select a winner.
