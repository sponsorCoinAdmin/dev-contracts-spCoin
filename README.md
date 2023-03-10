# dev-contracts-spCoin

// TESTING

// VISUAL STUDIO CODE INSTALL PLUGIN
Nomic Foundation

// INSTALLING HARDHAT
npm install --save-dev hardhat

//REQUIRED SUPPORT PACKAGES
"@nomicfoundation/hardhat-toolbox": "^2.0.1"
npm install --save-dev @nomicfoundation/hardhat-toolbox
npm install --save-dev @nomiclabs/hardhat-waffle 'ethereum-waffle@^3.0.0' @nomiclabs/hardhat-ethers 'ethers@^5.0.0'

Add the following code snippet at the top of your hardhat.config.js file
require("@nomiclabs/hardhat-waffle");

npm audit fix --force

// IMPORTANT HARDHAT GLOBAL COMMANDS
npx hardhat help

dataStructureModel Level
SPCoin
  Token
      Staking Manager
        Transactions
          Rates
            Agents
              Sponsors
                Accounts

To Add a Sponsor Account Agent, add the following:
Add a Rate Record to Agent

Using: addSponsorAgents(Account, Sponsor, [Agents])
Example: addSponsorAgents(1, 2, [6]); 

Add a Rate Record to Sponsor
================================================
Create:  AddSponsorRate(Account, Sponsor, SponsorRatePercent);
Example: AddSponsorRate(1, 2, 10);

Add a Rate Record to Sponsor
================================================
Create: AddAgentRate(Account, Sponsor, Agent, SponsorRatePercent, AgentRatePercent);
Example: AddAgentRate(1, 2, 6, 10, 10);

Add a Sponsor Transaction
================================================
Create AddSponsorTransaction(Account, Sponsor, SponsorRate, amount);
Example: AddSponsorTransaction(1, 2, 10, 123.1230);

Add aa Agent Transaction
================================================
Create AddAgentRateTransaction(Account, Sponsor, SponsorRate, Agent, AgentRate, Amount)
Example: AddAgentRate(1, 2, 6, 10, 10, 123.1230);


Requirements to Delete Agent: Agent Affiliation Program
1. Require Agent to be child of Sponsor
2. Require Agent to have No SponsorCoin balanceOf Token affiliation with Parent.
3. Must Remove from parent Sponsor.accountChildAgentKeys
4. Then Remove Sponsor Parent from agentAccount.accountParentSponsorKeys
5. Optional, If Agent account balanceOf is zero (0), Agent account may be deleted.

Requirements to Delete Sponsor from Patreon: (Delete Patreon sponsorship)
1. Require Sponsor to be Child of Patreon
2. Require Sponsor to have no Parent Patrion balanceOf Token affiliation.
3. Require Sponsor to have no Child Agent affiliation
4. Remove associated child agents from Sponsor.accountChildAgentKeys
5. Remove from Account ParentKeys, account.accountChildSponsorKeys
6. Remove from Account.sponsorMap, 
7. Optional, If Sponsor account balanceOf is zero (0), Sponsor account may be deleted.

Requirements to Delete Account
1. Require Account to have No Sponsors, account.accountChildSponsorKeys must be zero (0).
2. Require Account to have No Agents, account.accountChildAgentKeys must be zero (0).
3. Optional, Require Account to have No Patreons account.accountParentPatreonKeys must be zero (0).
4. Optional, Require Account to have No account.accountParentSponsorKeys must be zero (0).
