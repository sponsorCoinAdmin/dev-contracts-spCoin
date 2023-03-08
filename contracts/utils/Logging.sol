// SPDX-License-Identifier: MIT
// *** TdDo Not yet implemented *** //
pragma solidity ^0.8.19;

import "hardhat/console.sol";
import "./StringUtils.sol";

contract Logging is StringUtils{
    bool private logStatus = true;
    string prefix;
 
    constructor()  {
        setLogStatus(true);
    }

   function setLogStatus(bool _logStatus )  public {
        logStatus = _logStatus;
 //       string memory boolToString = toString(_logStatus);
 //       console.log(toString);
 //       string memory concat = string.concat("Setting Logging ", "toString");
 //       scLog(string.concat("Setting Logging ", toString(_logStatus)));
    }

   function scLog(bool _logStr ) view public{
        console.log(_logStr);
    }
 }
