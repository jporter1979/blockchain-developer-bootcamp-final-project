Decentralized Lottery System

The goal of this project is to develop a decentralized lottery system for the Ethereum Blockchain. The idea is to allow a user to anonymously partake in the lottery and to win the funds from a lottery pool if they have chosen the correct numbers.

Lottery Dapp Workflow
- The user will connect to a web3 site using their wallet.
- The user's wallet address will uniquely identify them to the system. 
- The user will "purchase" a ticket which will result in that amount of ether being           transferred to a lottery pool maintained by the smart contract. 
- The system will verify the funds exists in the users wallet before making the transfer.
- Along with purchasing a ticket the user enter lottery numbers which will also be stored by the smart contract.
- After an elapsed period of time a "draw" function in the smart contract will be triggered which will result in the generation of random numbers.
- The system will check to see if there are any matching numbers. If a user has matching numbers the funds in the pool will be transferred to their wallet address. If there are no matching numbers the funds remain in the pool. 

One of the main challenges will be to generate random numbers. To facilitate this I will utilize the Chainlink Verifiable Random Function (VRF) oracle to generate cryptographically proven random numbers within the smart contract. 
