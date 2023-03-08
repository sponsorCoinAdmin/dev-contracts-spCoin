// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";

contract TestContract is ERC721 {

    constructor(string memory _name, string memory _symbol) 
        ERC721(_name, _symbol) {
            console.log("CONTRACT => name", _name);
            console.log("CONTRACT => symbol: ", _symbol);
            console.log("CONTRACT => msg.sender", msg.sender);
    }
}