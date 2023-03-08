// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
/// @title ERC20 Contract
import "../accounts/Agents.sol";
import "./Transactions.sol";

contract AccountStakingManager is Transactions{

// ###  ALGORITHMIC ARCHITECTURAL DESIGN FOR STAKING REWARDS ALLOCATION ###
// allocateStakingRewards()
// 1. Get the sponsors accounts Array as (accountSponsorObjects)
// 2. Set totalRewards = calcAllSponsorsStakingRewards(accountSponsorObjects)
// 3. Update all account balances updateAllSponsorsStakingRewards()

/*
function allocateStakingRewards() internal view returns(  AccountStruct[] memory ){
   
   AccountStruct[] memory accountSponsorObjects = getPatreonSponsorRecByKeysords(msg.sender);
   return accountSponsorObjects;
}
*/// @title A title that should describe the contract/interface
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details
function gitAddressThis() external view returns(address){
   return (address(this));
}

// ### CALCULATE TIME DIFFERENCE IN SECONDS SINCE LAST UPDATE ###
// getAccountTimeInSecondeSinceUpdate(lastUpdateDate)
//     1. Get the current date in seconds(currentDate = block.timestamp).
//     2. Set timeInSecondsSinceLastUpdate = currentDate - lastUpdateDate

/// ### CALCULATE PRORATED STAKING REWARDS MULTIPLIER SINCE LAST UPDATE ###
// calcStakingRewardsMultiplier(rewardsRate, lastUpdateDate)
//    1. Set seconds in yearSeconds = 31,557,600, (@365.25 Days in Actual Year)
//    2. Get the rewardsRate from the account
//    3. Set secondsElapsed = getAccountTimeInSecondeSinceUpdate(lastUpdateDate)
//    4. Prorate Seconds over a year proratedRate = secondsElapsed/yearSeconds
//    5. rewardsMultiplier = proratedRate * annualRewardsRate
//    6. return rewardsMultiplier

// ### CALCULATE PRORATED STAKING REWARDS SINCE LAST UPDATE ###
// calculateAccountSteakingReward(balance, rewardsRate, lastUpdateDate)
//    1. Set rewardsMultiplier = calcStakingRewardsMultiplier(account.rewardsRate, account.lastUpdateDate)
//    2. Get the balance from the account = accountBalance = balancOf(account)
//    3. Set stakingRewards = accountBalance * rewardsMultiplier
//    4. return stakingRewards

// ### CALCULATE STAKING REWARDS FOR ALL SPONSORS ###
// calcAllSponsorsStakingRewards(accountSponsorObjects)
//    1. Set totalSponsorRewards = 0
//    2. For each accountSponsor in accountSponsorObjects calculate the Staking Rewards as:
//    2.1   Increment totalSponsorRewards += calcSponsorStakingRewards(accountSponsor)
//    3. return totalSponsorRewards

// ### CALCULATE INDIVIDUAL SPONSOR STAKING REWARDS FOR ACCOUNT ###
// calcSponsorStakingRewards(accountSponsor)
//    1. Set sponsorRewards = calculateAccountSteakingReward(accountSponsor.balanceOf, accountSponsor.rewardsRate, accountSponsor.lastUpdateDate)
//    2. Update balance= accountBalance + stakingRewards
//    3. agentAccountArray = accountSponsor.
//    4. Set agentRewards = calcAllAgentsStakingRewards(agentAccountArray)
//    5. Decrement sponsorRewards -= agentRewards
//    6. addAccountRecordsToUpdateStakingRewards(accountSponsor, sponsorRewards)
//    7. return sponsorRewards

// ### CALCULATE STAKING REWARDS FOR ALL AGENTS ###
// calcAllAgentsStakingRewards(agentAccountArray)
//    1. Set totalAgentsRewards = 0
//    3. For each agentAccount in agentAccountArray calculate the Staking Rewards as:
//    4.    Increment totalAgentsRewards += calculateAccountSteakingReward(agentAccount)
//    5. addAccountRecordsToUpdateStakingRewards(accountSponsor, sponsorRewards)
//    6. return totalAgentsRewards

//*****************************************************************************************************

// ### CALCULATE INDIVIDUAL SPONSOR STAKING REWARDS FOR ACCOUNT ###
// calcSponsorStakingRewards(accountSponsor, rewardsMultiplier)
//    1. Get a list of the agents accounts (agentAccountArray)
//    2. Get the current currBalance with balanceOf() ERC20 function;
//    3. Get the lastUpdate for the sponsors Account
//    4. Update Balances of all accounts updateBalances()

//    3. For each agentAccount in agentAccountArray calculate the Staking Rewards as:
//       accountStakingReward = calcAgentStakingRewards(agentAccount)

//    3. Add new elementto Array accountsToBeUpdated(account, "Sponsor", StakingRewards, currBalance, newBalance)
//    4. Calculate newBalance as currBalance + stakingRewards 
//    3. return accountStakingReward;








// calcAgentsStakingRewards(sponsorsRewards, agentList)
//    1. Initialize local totalAgentsReward to zero (0).
// ### FOR EACH AGENT PROCESS AS FOLLOWS ###
//    2. Get the agents account, (agentsAccount).
//    3. Get the agents Staking Rewards Interest Rate, (agentsRewardsRate), (between 2% and and 20% of sponsorsRewards).
//    4. Get the Agents SPCoin Quantity (agentSCoinQty)
//    5. Calculate the agents SPCoin staking rewards as:
//             agentsReward = (SPCoin Sponsor Quanty) * elapsedProratedDays * sponsorsRewardsRate
//    6. Increment totalAgentsReward = totalAgentsReward + agentsReward
//    7. return totalAgentsReward



// 8. For the sponsoredAccount, get the Sponsors Account Rate, (sponsorAccountRate), (between 2% and sponsorsRewardsRate).
// 9. Calculate the Sponsored Reward, (sponsorRewards as stakingRewards * stakingRewardsRate;

// 10. Get the Sponsors Agent (sponsorsAgent)
//     10.1 If no agent found set agentRewards at 0.
// 11. For the sponsoredAccount, get the Sponsored Agent Rate, (sponsorAgentRate), (between 1% and sponsorAccountRate).
// 10. If Agent not found, AgentRewardRate = 0, otherwise AgentRewardRate = agent rate read, default 1%.
// 11. Calculate the SponsorsReward as, SponsorsRewards = stakingRewards * (1 - (AgentRewardRate/SponsorsRewardRate)).
// 12. Update the TotalQuanty
// 13. Update the Agents TotalQuanty 

    constructor(){
    }
}