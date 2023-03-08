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
        public
        view
        onlyOwnerOrRootAdmin(_accountKey)
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
        address accountSponsorKey = accountRec.accountPatreonKeys[patreonIdx];
        return accountSponsorKey;
    }

    /// @notice retreives the sponsor array record size of the Patreon list.
    /// @param _accountKey public account key to get Sponsor Record Length
    function getAccountPatreonSize(address _accountKey) public view onlyOwnerOrRootAdmin(_accountKey) returns (uint) {
        return getAccountPatreonList(_accountKey).length;
    }

    /// @notice retreives the sponsor array records for the Patreon list
    /// @param _accountKey public account key to get Sponsor Record Length
    function getAccountPatreonList(address _accountKey) internal onlyOwnerOrRootAdmin(_accountKey) view returns (address[] memory) {
        AccountStruct storage account = accountMap[_accountKey];
        address[] storage accountPatreonKeys = account.accountPatreonKeys;
        return accountPatreonKeys;
    }

    /// @notice get address for an account patreon
    /// @param _accountKey public account key to get sponsor array
    /// @param sponsorIdx new parent sponsor to add to account list

    function getAccountAgentSponsorByIdx(address _accountKey, uint sponsorIdx ) public view onlyOwnerOrRootAdmin(msg.sender) returns (address) {
        AccountStruct storage accountRec = accountMap[_accountKey];
        address accountAgentSponsorKey = accountRec.accountAgentSponsorKeys[sponsorIdx];
        return accountAgentSponsorKey;
    }

    /// @notice retreives the sponsor array record size of the Patreon list.
    /// @param _accountKey public account key to get Sponsor Record Length
    function getAccountAgentSponsorSize(address _accountKey) public view onlyOwnerOrRootAdmin(_accountKey) returns (uint) {
        return getAccountAgentSponsorList(_accountKey).length;
    }
    
    /// @notice retreives the sponsor array records for the Patreon list
    /// @param _accountKey public account key to get Sponsor Record Length
    function getAccountAgentSponsorList(address _accountKey) internal onlyOwnerOrRootAdmin(_accountKey) view returns (address[] memory) {
        AccountStruct storage account = accountMap[_accountKey];
        address[] storage accountAgentSponsorKeys = account.accountAgentSponsorKeys;
        return accountAgentSponsorKeys;
    }

    /////////////////////////// AGENT REQUESTS //////////////////////////////

    /// @notice get address for an account agent
    /// @param _accountKey public account key to get sponsor array
    /// @param _agentIdx new patreon to add to account list
    function getAccountAgentKeyByIndex(address _accountKey, uint _agentIdx ) public view onlyOwnerOrRootAdmin(msg.sender) returns (address) {
        AccountStruct storage accountRec = accountMap[_accountKey];
        address accountAgentKey = accountRec.accountAgentKeys[_agentIdx];
        return accountAgentKey;
    }

    /// @notice retreives the sponsor array record size of the Patreon list.
    /// @param _accountKey public account key to get Sponsor Record Length
    function getAccountAgentSize(address _accountKey) public view onlyOwnerOrRootAdmin(_accountKey) returns (uint) {
        return getAgentList(_accountKey).length;
    }

    /// @notice retreives the sponsor array records for the Patreon list
    /// @param _accountKey public account key to get Sponsor Record Length
    function getAgentList(address _accountKey) internal onlyOwnerOrRootAdmin(_accountKey) view returns (address[] memory) {
        AccountStruct storage account = accountMap[_accountKey];
        address[] storage accountAgentKeys = account.accountAgentKeys;
        return accountAgentKeys;
    }

     /////////////////// DELETE ACCOUNT METHODS ////////////////////////
   
    // 1. Require that Account Exists
    // 2. Require that Account has No Sponsors, account.accountSponsorKeys must be zero (0).
    // 2. Require that Account has No Agents, account.accountAgentKeys must be zero (0).
    // 3. Require that Account is not a Sponsor.
    // 4. Require that Account is not an Agent.
    function deleteAccount(address _accountKey) public view
            onlyOwnerOrRootAdmin(_accountKey)
        accountExists (_accountKey) 
        hasNoAgents(_accountKey)
        hasNoSponsors(_accountKey)
        isNotASponsor(_accountKey)
        isNotAnAgent(_accountKey) {
    //     // ToDo Complete this function
    }

    modifier accountExists (address _accountKey) {
        require (isAccountInserted(_accountKey) , "Account not found)");
        _;
    }

    modifier hasNoAgents (address _accountKey) {
        require (isAccountInserted(_accountKey) , "Account has Agents)");
        _;
    }

    modifier hasNoSponsors (address _accountKey) {
        require (isAccountInserted(_accountKey) , "Account Has Sponsors)");
        _;
    }

    modifier isNotASponsor (address _accountKey) {
        require (getAccountPatreonSize(_accountKey) == 0 , "Account is a Sponsor");
        _;
    }

    modifier isNotAnAgent (address _accountKey) {
        require (getAccountAgentSponsorSize(_accountKey) == 0 , "Account is a Agent");
        _;
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
