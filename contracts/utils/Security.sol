// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../dataTypes/DataTypes.sol";

import "hardhat/console.sol";

contract Security is DataTypes {
    address private  rootAdmin;
 
    constructor()  {
        rootAdmin = msg.sender;
    }

    modifier onlyRootAdmin () {
        require (msg.sender == rootAdmin, "Root Admin Security Access Violation");
        _;
    }

    modifier onlyOwner (address _account) {
        require (msg.sender == _account, "Owner Security Access Violation");
        _;
    }

    modifier onlyOwnerOrRootAdmin (address _account) {
        require (msg.sender == rootAdmin || msg.sender == _account, "Owner or Root Admin Security Access Violation");
        _;
    }

    modifier nonRedundantSponsor (address _accountKey, address _sponsorAccountKey) {
        require (_accountKey != _sponsorAccountKey , "_accountKey and _sponsorAccountKey must be Mutually Exclusive)");
        _;
    }

    modifier nonRedundantAgent (address _accountKey, address _sponsorAccountKey, address _agentAccountKey) {
        require (_accountKey != _sponsorAccountKey && 
                 _sponsorAccountKey != _agentAccountKey && 
                 _accountKey != _agentAccountKey , "_accountKey, _sponsorAccountKey and _agentAccountKey must be Mutually Exclusive)");
        _;
    }

    // address _accountKey, address _sponsorAccountKey, address _agentAccountKey
}
