const Lottery = artifacts.require("Lottery.sol");
const Random = artifacts.require("Random.sol");

module.exports = function(deployer){
    deployer.deploy(Lottery);
    deployer.deploy(Random);
};