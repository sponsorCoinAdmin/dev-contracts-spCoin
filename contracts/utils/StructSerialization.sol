// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Utils.sol";

contract StructSerialization is Utils {

    constructor() {}

    function serializeAccount(AccountStruct storage _accountRec)
        internal
        view
        returns (string memory)
    {
        // ToDo Remove Next Line and Serialize the AccountRec
        string memory index = concat("index: ", toString(_accountRec.index));
        string memory addr = concat(
            "accountKey: ",
            toString(_accountRec.accountKey)
        );
        string memory insertionTime = concat(
            "insertionTime: ",
            toString(_accountRec.insertionTime)
        );
        string memory verified = concat(
            "verified: ",
            toString(_accountRec.verified)
        );
        string memory accountChildAgentKeys = toString(_accountRec.accountChildAgentKeys);
        string memory accountParentPatreonKeys = toString(
            _accountRec.accountParentPatreonKeys
        );
        string memory delimiter = "\\,";
        string memory seralized = concat(
            index,
            delimiter,
            addr,
            delimiter,
            insertionTime
        );
        seralized = concat(seralized, ",", verified);
        seralized = string(
            abi.encodePacked(
                index,
                "\\,\n",
                addr,
                "\\,\n",
                insertionTime,
                "\\,\n",
                verified
            )
        );
        seralized = concat(seralized, delimiter, "accountChildAgentKeys:", accountChildAgentKeys);
        seralized = concat(
            seralized,
            delimiter,
            "accountParentPatreonKeys:",
            accountParentPatreonKeys
        );
        seralized = concat(seralized, delimiter, "accountChildAgentKeys:", accountChildAgentKeys);

        // console.log("_accountRec.accountKey:", _accountRec.accountKey);
        // console.log( "toString(_accountRec.accountKey)", toString(_accountRec.accountKey));

        return seralized;
    }
}
