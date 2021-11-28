# Decentralized Lottery System
The goal of this project is to develop a decentralized lottery system for the Ethereum Blockchain. The idea is to allow a user to anonymously partake in the lottery and to win the funds from a lottery pool if they have been randomly selected.

Lottery Dapp Workflow
- The user will connect to a web3 site using their wallet.
- The user's wallet address will uniquely identify them to the system. 
- The user will enter an amount of ether to be transferred to a lottery pool maintained by the smart contract. 
- The system will verify that the user has sufficient funds before making the transfer.
- After an elapsed period of time the smart contract will be triggered which will result in the random selection of a lottery winner.
- The smart contract will automatically transfer all the funds from the pool to the address of the winner.

In order to create "randomness" on the blockchain the ChainLink VRF oracle is used in the random selection of the winner. The ChainLink Keepers service is also used to enforce the duration of the lottery and automatically triggers the random selection of a winner when the time period has expired.

# Directory Structure
The following highlights the important directories within the project:
- The client directory contains all the frontend code for the project. The frontend was developed using plain HTML/CSS/JS.
- The contracts folder contains the smart contracts used in the project. Along with the standard Migrations.sol, there are also Lottery.sol and Random.sol. 
- The migrations folder contains the migration scripts for the project with 2_deploy_contracts.js as the main script for deploying the smart contracts.
- The test folder contains the unit tests for the smart contracts.

# Accessing Project
- The project can be accessed at the following url: https://jporter1979.github.io/.

# Dependencies
- The following dependencies are required for this project:
  - "@chainlink/contracts" -> npm install @chainlink/contracts --save
  - "@truffle/hdwallet-provider" -> npm install @truffle/hdwallet-provider
  - "dotenv" -> npm install dotenv
  - Requires compiler version 0.8.7 to be set in truffle-config

# Running Project
- Ensure Metamask is on the Kovan test network.
- Click the Enable Metamask button to connect your account(s) to the site.
- Enter a duration for the lottery in seconds in the "Sec" box (for e.g. 180 seconds for 3 minutes) then press start and wait for the lottery to open.
- Select an account from Metamask, enter an amount in the "ETH" box then click submit.
- Wait for the lottery to draw after the duration has passed.

# Running Unit Tests
- In a terminal from the project root run "truffle test" (Uses the builtin test network within truffle).

# Screencast
https://youtu.be/Vt5622DCFfk 