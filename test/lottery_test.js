const lottery = artifacts.require("Lottery");
const random = artifacts.require("Random");

/*
 * Here I am testing the following: 1) The deployment of the smart contracts, 2) the initialization of the smart contracts and also showing
 * that only the owner is able to do so, 3) the ability to start a new lottery and change its state to open which only the owner is able to do, 
 * 4) users are able to enter the lottery by sending funds and update the balance of the contract and 5) the owner is able to stop the lottery if 
 * necessary and change its state to closed. Due to the use of ChainLink oracles I am unbale to test the Random contract (requires VRF) as well as the 
 * checkUpkeep and performUpkeep functions (requires Keepers) in the Lottery contract. Also, I am unable to test the pickWinner function in the Lottery 
 * contract as it depends on afore mentioned functions and the Random contract to be executed.
 */

contract("Lottery", function (accounts) {
  describe("Initial deployment", async () =>{
    it("Lottery contract deployed", async () =>{
      await lottery.deployed();
      return assert.isTrue(true);
    });
    it("Random contract deployed", async () =>{
      await random.deployed();
      return assert.isTrue(true);
    });
  })
  describe("Functionality", async () => {
    it("Only owner can initialize contract", async () =>{
      const lotteryInstance = await lottery.deployed();
      const randomInstance = await random.deployed();
     try{
        await lotteryInstance.initialize(randomInstance.address, {from: accounts[1]});
      }
      catch(err){}
      const randomAddress = await lotteryInstance.random.call();
      assert.equal(randomAddress,0x0000000000000000000000000000000000000000, "Random address was not supposed to be set");
    })
    it("Lottery contract initialized", async () =>{
      const lotteryInstance = await lottery.deployed();
      const randomInstance = await random.deployed();
      await lotteryInstance.initialize(randomInstance.address, {from: accounts[0]});
      const randomAddress = await lotteryInstance.random.call();
      assert.equal(randomAddress,randomInstance.address, "Random address was supposed to be set");
    })
    it("Only owner can start lottery", async () =>{
      const lotteryInstance = await lottery.deployed();
     try{
        await lotteryInstance.startNewLottery(30 /*duration*/, {from: accounts[1]});
      }
      catch(err){}
      const lotteryState = await lotteryInstance.lottery_state.call();
      assert.equal(lotteryState,1, "Lottery state was supposed to be closed");
    })
    it("Lottery started", async () =>{
      const lotteryInstance = await lottery.deployed();
      await lotteryInstance.startNewLottery(30 /*duration*/, {from: accounts[0]});
      const lotteryState = await lotteryInstance.lottery_state.call();
      assert.equal(lotteryState,0, "Lottery state was supposed to be open");
    })
    it("Users can enter the lottery", async () =>{
      const lotteryInstance = await lottery.deployed();
      await lotteryInstance.enter({from: accounts[0], value: web3.utils.toWei('1', 'ether')});
      const players = await lotteryInstance.getPlayers();
      const balance = await lotteryInstance.getPool();
      assert.equal(players.length,1, "The number of players should be greater than zero");
      assert.equal(web3.utils.toWei('1', 'ether'), balance, "Lottery balance should be 1 ETH");
    })
    it("Only owner can stop lottery", async () =>{
      const lotteryInstance = await lottery.deployed();
     try{
        await lotteryInstance.stopLottery({from: accounts[1]});
      }
      catch(err){}
      const lotteryState = await lotteryInstance.lottery_state.call();
      assert.equal(lotteryState,0, "Lottery state was supposed to be open");
      await lotteryInstance.stopLottery({from: accounts[0]});
      const updatedLotteryState = await lotteryInstance.lottery_state.call();
      assert.equal(updatedLotteryState,1, "Lottery state was supposed to be closed");
    })
  })
});
