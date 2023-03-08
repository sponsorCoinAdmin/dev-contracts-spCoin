// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
/// @title ERC20 Contract
import "hardhat/console.sol";
import "./Security.sol";
//import "./StringUtils.sol";
import "./TimeUtils.sol";
import "./Logging.sol";

contract Utils is Security, TimeUtils, Logging {
    constructor() { 
    }
  
    function msgSender() external view returns(address){
        return (msg.sender);
     }
}
