// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
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

    /////////////////// DELETE SPONSOR METHODS ////////////////////////

    function deletePatreonSponsor(address _patreonKey, address _sponsorKey) 
        public sponsorExists(_patreonKey, _sponsorKey) {

        }

    modifier sponsorExists (address _patreonKey, address _sponsorKey) {
        require (isSponsorInserted(_patreonKey, _sponsorKey) , "_sponsorKey not found)");
        _;
    }

}
