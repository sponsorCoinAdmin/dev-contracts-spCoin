// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
/// @title ERC20 Contract
import "./Accounts.sol";

contract Sponsors is Accounts {
        constructor() {
    }

    /// @notice insert address for later recall
    /// @param _patreonKey public patreon key to get sponsor array
    /// @param _sponsorKey new sponsor to add to account list
    function addPatreonSponsor(address _patreonKey, address _sponsorKey) 
        public onlyOwnerOrRootAdmin(_patreonKey)
        nonRedundantSponsor ( _patreonKey,  _sponsorKey) {
        addAccountRecord(_patreonKey);
        addAccountRecord(_sponsorKey);
        AccountStruct storage patreonAccountRec = accountMap[_patreonKey];
        AccountStruct storage sponsorAccountRec = accountMap[_sponsorKey];
        SponsorStruct storage patreonSponsorRec = getPatreonSponsorRecByKeys(_patreonKey, _sponsorKey);
        if (!patreonSponsorRec.inserted) {
            patreonSponsorRec.index = patreonAccountRec.accountChildSponsorKeys.length;
            patreonSponsorRec.insertionTime = block.timestamp;
            patreonSponsorRec.sponsorAccountKey = _sponsorKey;
            patreonSponsorRec.inserted = true;
            patreonAccountRec.accountChildSponsorKeys.push(_sponsorKey);
            sponsorAccountRec.accountParentPatreonKeys.push(_patreonKey);
        }
    }

    /// @notice determines if sponsor address is inserted in account.sponsor.map
    /// @param _patreonKey public account key validate Insertion
    /// @param _sponsorKey public sponsor account key validate Insertion
    function isSponsorInserted(address _patreonKey, address _sponsorKey) public onlyOwnerOrRootAdmin(_patreonKey) view returns (bool) {
        return getPatreonSponsorRecByKeys(_patreonKey, _sponsorKey).inserted;
    }

    /// @notice retreives the array index of a specific address.
    /// @param _patreonKey public patreon key to get sponsor array
    function getPatreonSponsorIndex(address _patreonKey, address _sponsorKey) public onlyOwnerOrRootAdmin(_patreonKey) view returns (uint) {
        if (isSponsorInserted(_patreonKey, _sponsorKey))
            return accountMap[_patreonKey].sponsorMap[_sponsorKey].index;
        else
            return 0;
    }

    function getSponsorInsertionTime(address _patreonKey, address _sponsorKey) public onlyOwnerOrRootAdmin(_patreonKey) view returns (uint) {
        if (isSponsorInserted(_patreonKey, _sponsorKey))
            return accountMap[_patreonKey].sponsorMap[_sponsorKey].insertionTime;
        else
            return 0;
    }

    function getValidSponsorRec(address _patreonKey, address _sponsorKey) internal onlyOwnerOrRootAdmin(_patreonKey) returns (SponsorStruct storage) {
        if (!isSponsorInserted(_patreonKey, _sponsorKey)) {
            addPatreonSponsor(_patreonKey, _sponsorKey);
        }
        return getPatreonSponsorRecByKeys(_patreonKey, _sponsorKey);
     }

     function getPatreonSponsorRecByKeys(address _patreonKey, address _sponsorKey) internal view onlyOwnerOrRootAdmin(_patreonKey) returns (SponsorStruct storage) {
        AccountStruct storage accountRec = accountMap[_patreonKey];
        SponsorStruct storage accountSponsor = accountRec.sponsorMap[_sponsorKey];
       return accountSponsor;
     }

    /// @notice get address for an account sponsor
    /// @param _patreonKey public account key to get sponsor array
    /// @param _sponsorIdx new sponsor to add to account list
    function getPatreonSponsorKeyByIndex(address _patreonKey, uint _sponsorIdx ) public view onlyOwnerOrRootAdmin(msg.sender) returns (address) {
        AccountStruct storage accountRec = accountMap[_patreonKey];
        address sponsor = accountRec.accountChildSponsorKeys[_sponsorIdx];
        return sponsor;
    }

    //////////////////// NESTED AGENT METHODS /////////////////////////

    function getAgentRecordByKeys(address _patreonKey, address _sponsorKey, address _agentKey) internal view onlyOwnerOrRootAdmin(_patreonKey) returns (AgentStruct storage) {
        SponsorStruct storage sponsorRec = getPatreonSponsorRecByKeys(_patreonKey, _sponsorKey);
        AgentStruct storage sponsorChildAgentRec = sponsorRec.agentMap[_agentKey];
        return sponsorChildAgentRec;
     }

    /// @notice get address for an account sponsor
    /// @param _sponsorKey public account key to get agent array
    /// @param _agentIdx new agent to add to account list
    function getSponsorAgentKeyAddress(address _patreonKey, address _sponsorKey, uint _agentIdx ) public view onlyOwnerOrRootAdmin(msg.sender) returns (address) {
        address[] memory agentKeys = getChildAgentKeys(_patreonKey, _sponsorKey);
        address agentAddress = agentKeys[_agentIdx];
        return agentAddress;
    }

    /// @notice retreives the sponsor array record size a specific address.
    /// @param _sponsorKey public account key to get Sponsor Record Length
    function getChildAgentSize(address _patreonKey, address _sponsorKey) public view onlyOwnerOrRootAdmin(_sponsorKey) returns (uint) {
        return getChildAgentKeys(_patreonKey, _sponsorKey).length;
    }

    /// @notice retreives the sponsor array records from a specific account address.
    /// @param _sponsorKey public account key to get Sponsors
    function getChildAgentKeys(address _patreonKey, address _sponsorKey) internal view onlyOwnerOrRootAdmin(_sponsorKey) returns (address[] memory) {
        SponsorStruct storage sponsorRec = getPatreonSponsorRecByKeys(_patreonKey, _sponsorKey);
        address[] memory accountChildAgentKeys = sponsorRec.accountChildAgentKeys;
        return accountChildAgentKeys;
    }

    ///////////////////// DELETE SPONSOR METHODS ////////////////////////

    function deletePatreonSponsor(address _patreonKey, address _sponsorKey) 
        public sponsorExists(_patreonKey, _sponsorKey) {

        }

    modifier sponsorExists (address _patreonKey, address _sponsorKey) {
        require (isSponsorInserted(_patreonKey, _sponsorKey) , "_sponsorKey not found)");
        _;
    }

}
