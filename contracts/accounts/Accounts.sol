// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
/// @title ERC20 Contract
import "../utils/StructSerialization.sol";

contract Accounts is StructSerialization {
    constructor() {}

    /// @notice insert block chain network address for spCoin Management
    /// @param _accountKey public accountKey to set new balance
    function addAccountRecord(address _accountKey)
        public onlyOwnerOrRootAdmin(_accountKey) {
        if (!isAccountInserted(_accountKey)) {
            AccountStruct storage accountRec = accountMap[_accountKey];
            accountRec.index = accountIndex.length;
            accountRec.accountKey = _accountKey;
            accountRec.insertionTime = block.timestamp;
            accountRec.inserted = true;
            accountIndex.push(_accountKey);
        }
    }

    /// @notice determines if address is inserted in accountKey array
    /// @param _accountKey public accountKey validate Insertion
    function isAccountInserted(address _accountKey)
        public view onlyOwnerOrRootAdmin(_accountKey) returns (bool)
    {
        if (accountMap[_accountKey].inserted) return true;
        else return false;
    }

    /// @notice retreives the array index of a specific address.
    /// @param _accountKey public accountKey to set new balance
    function getAccountIndex(address _accountKey)
        public view onlyOwnerOrRootAdmin(_accountKey)
        returns (uint256)
    {
        if (isAccountInserted(_accountKey))
            return accountMap[_accountKey].index;
        else return 0;
    }

    /// @notice retreives the number of accounts inserted.
    function getAccountSize() public view returns (uint256) {
        return accountIndex.length;
    }

    /// @notice retreives a specified account address from accountIndex.
    /// @param _idx index of a specific account in accountIndex
    function getAccountKey(uint256 _idx) public view returns (address) {
        return accountIndex[_idx];
    }

    /// @notice retreives the account array records.
    function getAccountArrayList() public view returns (string memory) {
        string memory strAccountArray = "";
        console.log("getAccountArrayList");   
        for (uint256 i = 0; i < accountIndex.length; i++){
            strAccountArray = concat(strAccountArray, toString(i), ", ", toString(accountIndex[i]));
            if (i < accountIndex.length - 1)
                strAccountArray = concat(strAccountArray, "\n");
        }
        return strAccountArray;
    }

    /// @notice retreives the account record of a specific accountKey address.
    /// @param _accountKey public accountKey to set new balance
    function getAccountRecord(address _accountKey)
        internal view onlyOwnerOrRootAdmin(_accountKey)
        returns (AccountStruct storage)
    {
        require(isAccountInserted(_accountKey));
        return accountMap[_accountKey];
    } 

    ////////////////////// BENEFICIARY REQUESTS //////////////////////////////

    /// @notice get address for an account patreon
    /// @param _accountKey public account key to get sponsor array
    /// @param patreonIdx new patreon to add to account list
    function getAccountPatreonKeyByIndex(address _accountKey, uint patreonIdx ) public view onlyOwnerOrRootAdmin(msg.sender) returns (address) {
        AccountStruct storage accountRec = accountMap[_accountKey];
        address accountSponsorKey = accountRec.accountParentPatreonKeys[patreonIdx];
        return accountSponsorKey;
    }

    /// @notice retreives the sponsor array record size of the Patreon list.
    /// @param _accountKey public account key to get Sponsor Record Length
    function getAccountPatreonSize(address _accountKey) public view onlyOwnerOrRootAdmin(_accountKey) returns (uint) {
        return getAccountParentPatreonKeys(_accountKey).length;
    }

    /// @notice retreives the sponsor array records for the Patreon list
    /// @param _accountKey public account key to get Sponsor Record Length
    function getAccountParentPatreonKeys(address _accountKey) internal onlyOwnerOrRootAdmin(_accountKey) view returns (address[] memory) {
        AccountStruct storage account = accountMap[_accountKey];
        address[] storage accountParentPatreonKeys = account.accountParentPatreonKeys;
        return accountParentPatreonKeys;
    }

    /// @notice get address for an account patreon
    /// @param _accountKey public account key to get sponsor array
    /// @param sponsorIdx new parent sponsor to add to account list

    function getAccountParentSponsorByIdx(address _accountKey, uint sponsorIdx ) public view onlyOwnerOrRootAdmin(msg.sender) returns (address) {
        AccountStruct storage accountRec = accountMap[_accountKey];
        address accountAgentSponsorKey = accountRec.accountParentSponsorKeys[sponsorIdx];
        return accountAgentSponsorKey;
    }

    /// @notice retreives the sponsor array record size of the Patreon list.
    /// @param _accountKey public account key to get Sponsor Record Length
    function getAccountParentSponsorSize(address _accountKey) public view onlyOwnerOrRootAdmin(_accountKey) returns (uint) {
        return getAccountParentSponsorKeys(_accountKey).length;
    }
    
    /// @notice retreives the sponsor array records for the Patreon list
    /// @param _accountKey public account key to get Sponsor Record Length
    function getAccountParentSponsorKeys(address _accountKey) internal onlyOwnerOrRootAdmin(_accountKey) view returns (address[] memory) {
        AccountStruct storage account = accountMap[_accountKey];
        address[] storage accountParentSponsorKeys = account.accountParentSponsorKeys;
        return accountParentSponsorKeys;
    }

    /////////////////////////// AGENT REQUESTS //////////////////////////////

    /// @notice get address for an account agent
    /// @param _accountKey public account key to get sponsor array
    /// @param _agentIdx new patreon to add to account list
    function getAccountChildAgentKeyByIndex(address _accountKey, uint _agentIdx ) public view onlyOwnerOrRootAdmin(msg.sender) returns (address) {
        AccountStruct storage accountRec = accountMap[_accountKey];
        address accountAgentKey = accountRec.accountChildAgentKeys[_agentIdx];
        return accountAgentKey;
    }

    /// @notice retreives the sponsor array record size of the Patreon list.
    /// @param _accountKey public account key to get Sponsor Record Length
    function getAccountChildAgentSize(address _accountKey) public view onlyOwnerOrRootAdmin(_accountKey) returns (uint) {
        return getAccountChildAgentKeys(_accountKey).length;
    }

    /// @notice retreives the sponsor array records for the Patreon list
    /// @param _accountKey public account key to get Sponsor Record Length
    function getAccountChildAgentKeys(address _accountKey) internal onlyOwnerOrRootAdmin(_accountKey) view returns (address[] memory) {
        AccountStruct storage account = accountMap[_accountKey];
        address[] storage accountChildAgentKeys = account.accountChildAgentKeys;
        return accountChildAgentKeys;
    }

    /// @notice retreives the sponsor array record size a specific address.
    /// @param _patreonKey public account key to get Sponsor Record Length
    function getChildSponsorSize(address _patreonKey) public view onlyOwnerOrRootAdmin(_patreonKey) returns (uint) {
        return getChildSponsorKeys(_patreonKey).length;
    } 

    /// @notice retreives the sponsors of a specific address.
    /// @param _patreonKey public account key to set new balance
    function getChildSponsorKeys(address _patreonKey) internal onlyOwnerOrRootAdmin(_patreonKey) view returns (address[] memory) {
        AccountStruct storage account = accountMap[_patreonKey];
        address[] storage accountChildSponsorKeys = account.accountChildSponsorKeys;
        return accountChildSponsorKeys;
    }

     /////////////////// DELETE ACCOUNT METHODS ////////////////////////
   
    // ** 1. Require that Account Exists  (Check AccointIndex List) 
    // 2. Require that Account has No Sponsors, account.accountChildSponsorKeys must be zero (0).
    // 2. Require that Account has No Agents, account.accountChildAgentKeys must be zero (0).
    // 3. Require that Account is not a Sponsor, account.accountParentPatreonKeys must be zero (0).
    // 4. Require that Account is not an Agent, account.accountParentSponsorKeys must be zero (0).
    // NOTE: ** -> Complete
    modifier accountExists (address _accountKey) {
        require (isAccountInserted(_accountKey) , "Account not found)");
        _;
    }  // COMPLETE

    modifier patreonAccountHasNoSponsors (address _accountKey) {
        require (getChildSponsorSize(_accountKey) == 0, "Patreon Account has Sponsors)");
        _;
    }

    modifier sponsorAccountHasNoAgents (address _accountKey) {
        require (getAccountChildAgentSize(_accountKey)  == 0, "Sponsor Account Has Agent(s)");
        _;
    }

    modifier sponsorAccountHasNoPatreons (address _accountKey) {
        require (getAccountPatreonSize(_accountKey) == 0 , "Sponsor Account has Patron(s))");
        _;
    } // COMPLETE

    modifier agentAccountHasNoSponsors (address _accountKey) {
        require (getAccountParentSponsorSize(_accountKey) == 0 , "Agent Account has Sponsor(s)");
        _;
    } // COMPLETE

    function deleteAccount(address _accountKey) public 
            onlyOwnerOrRootAdmin(_accountKey)
        accountExists (_accountKey) 
        patreonAccountHasNoSponsors(_accountKey)
        sponsorAccountHasNoAgents(_accountKey)
        sponsorAccountHasNoPatreons(_accountKey)
        agentAccountHasNoSponsors(_accountKey) {
    console.log("ToDo Complete this function");
        removeAccount(_accountKey);
    }

    function removeAccount(address _accountKey) 
        internal {
        // console.log("removeAccount(", _accountKey, ")");  
        // console.log("accountIndex.length = ", accountIndex.length); 
        for (uint i = 0; i < accountIndex.length; i++) {
            // console.log("foundAccount(", accountIndex[i], ")");
            if (accountIndex[i] == _accountKey) {
                //AccountStruct storage accountStruct = getAccountRecord(accountIndex[i]);
                // console.log("BEFORE accountStruct.accountKey = ", accountStruct.inserted);
                // console.log("BEFORE accountStruct.inserted = ", accountStruct.accountKey);
                delete accountMap[_accountKey];
                // console.log("AFTER accountStruct.accountKey = ", accountStruct.accountKey);
                // console.log("AFTER accountStruct.inserted = ", accountStruct.inserted);
                // console.log("Deleting address[", i, "] = ", accountIndex[i]);
                delete accountIndex[i];
                while (i < accountIndex.length-1) { 
                    accountIndex[i] = accountIndex[i+1];
                    // console.log("Shifting address[", i, "] =", accountIndex[i]);
                    i++;
                }
                accountIndex.pop();
            }
        }
    }

    /////////////////// ACCOUNT SERIALIZATION REQUESTS ////////////////////////

    /// @notice retreives the account record of a specific accountKey address.
    /// @param _accountKey public accountKey to set new balance
    function getSerializedAccountRec(address _accountKey)
        public view onlyOwnerOrRootAdmin(_accountKey)
        returns (string memory)
    {
        require(isAccountInserted(_accountKey));
        return serializeAccount(accountMap[_accountKey]);
    }
}
