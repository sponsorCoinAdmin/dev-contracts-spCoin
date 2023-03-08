// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Token.sol";

contract SPCoin is Token{
    string private defaultName         = "sponsorCoin";
    string private defaultSymbol       = "SPCoin";
    uint256 private defaultDecimals    = 18;
    uint256 private defaultTotalSupply = 1000000000 * 10**defaultDecimals;

    constructor()  {
//        logDetail("JS => MESSAGE.SENDER: ", msg.sender);
        initToken(defaultName,  defaultSymbol, defaultDecimals, defaultTotalSupply);
//        logDetail("JS => MESSAGE.SENDER: ", msg.sender);
    }
}