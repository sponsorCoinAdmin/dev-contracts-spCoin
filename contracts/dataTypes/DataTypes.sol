// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
/// @title ERC20 Contract
import "./KYC.sol";

contract DataTypes is KYC {
    // Keep track of account insertions
    // Record relationship rules as Follows:
    // 1. Every Account is the root of a mapping tree in the diagram below:
    // 2. Every Account can be a Patreon, And/or Sponsor, and/or Agent
    //    - A Patreon is the, primary steak Holder of the "Sponsor Coin" token.
    //        The primary purpose of holding "Sponsor Coins" is to share "Proof of Stake"
    //        percentage earnings with the selected sopnsor(s).
    //    - A Sponsor is considered to be a child of one or more Patreons with the purposes
    //      of sharing "Proof of Stake" Patreon rewards.
    //    - An Agent finds Patreon(s) for any specific sponsor and receives a share of the 
    //      "Proof of Stake" reward allocation for this effort. 
    // 3. Every Account can be a Patreon, Sponsor and/or agent to one or more mutually 
    //    exclusive account(s).
    // 4. Every Sponsor can have a number of Patreon(s), Sponsor(s) and/or Agent(s)
    // 5. Every Sponsor has an array of rate structures
    // 6. Every Agent has an array of rate structures
    // 7. Every Rate Structure has an array of Transactions
    // 8. Each Patreon/Sponsor/Agent "MUST BE" mutually exclusive
    //    - This implies no two accounts can be the same for each account structure
    //
    //  The following is a brief diagram of the contractural structure.
    //
    //              |                          |-/Agent(s)/Rate(s)/Transaction(s)
    // Account(s) =>| Patreon(s)/Sponsor(s)/ =>|
    //              |                          |-/Rate(s)/Transaction(s)

    address burnAddress = 0x0000000000000000000000000000000000000000;
    address[] public accountIndex;
    mapping(address => AccountStruct) accountMap;

    struct AccountStruct {
        uint256 index;
        address accountKey;
        uint256 insertionTime;
        bool inserted;
        bool verified;
        address[] accountSponsorKeys;      // If Patreon List of Sponsored Accounts is not zero
        address[] accountAgentKeys;        // If Sponsor? List of Agent Accounts is not zero
        address[] accountPatreonKeys;      // If Sponsor? List of Patreon Accounts
        address[] accountAgentSponsorKeys; // If Agent? List of Patreon Sponsor Accounts
        mapping(address => SponsorStruct) sponsorMap;
        KYC kyc;
    }

    // Each Account has a map of Sponsors and an array of rate structures
    struct SponsorStruct {
        uint256 index;
        address sponsorAccountKey;
        uint256 insertionTime;
        bool inserted;
        bool verified;
        address[] accountAgentKeys;
        mapping(address => AgentStruct) agentMap;
        RateStruct[] rates;
        mapping(uint256 => RateStruct) rateMap;
    }

    // Each Sponsor has a map of Agents and an array of rate structures
    struct AgentStruct {
        uint256 index;
        address agentAccountKey;
        uint256 insertionTime;
        bool inserted;
        bool verified;
        RateStruct[] rates;
        mapping(uint256 => RateStruct) rateMap;
    }

    struct RateStruct {
        uint256 insertionTime;
        uint256 lastUpdateTime;
        uint256 totalQuantity;
        uint256[] rate;
        TransactionStruct[] transactionChain;
    }

    struct TransactionStruct {
        uint256 insertionTime;
        int256 quantity;
    }
}
