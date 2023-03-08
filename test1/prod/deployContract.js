const {
    LOG_MODE,
    logSetup,
    setLogMode,
    log
  } = require("./lib/utils/logging");
  
  deployContract = async () => {
    //setLogMode(LOG_MODE.LOG_SETUP, true);

    logSetup("deployContract = async ()");

    logSetup("JS => spCoinContract retrieved from Factory");
    let spCoinContract = await hre.pragma solidity ^0.8.19.getContractFactory("SPCoin");

    logSetup("JS => Deploying spCoinContract to Network");
    let spCoinContractDeployed = await spCoinContract.deploy();
    logSetup("JS => spCoinContract is currently being mined");

    await spCoinContractDeployed.deployed();
    logSetup("JS => spCoinContract is mined and Deployed to the BlockChain Network");
//    let msgSender = await spCoinContractDeployed.msgSender();
     return spCoinContractDeployed;
}

module.exports = {
    deployContract
}