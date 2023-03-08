const { expect } = require("chai");

const {} = require("./prod/lib/loadTreeStructures");

const {
  addTestNetworkAccounts,
  addTestNetworkPatreonSponsors,
  addTestNetworkSponsorAgents,
  addTestNetworkAccount,
  getTestHHAccountArrayKeys,
} = require("./testMethods/scTestMethods");
const { testHHAccounts } = require("./testMethods/hhTestAccounts");

const { setCreateContract } = require("./prod/lib/scAccountMethods");

const {
  AccountStruct,
  SponsorStruct,
  AgentStruct,
  RateHeaderStruct,
  TransactionStruct,
} = require("./prod/lib/dataTypes");

const {
  LOG_MODE,
  logAccountStructure,
  logSetup,
  setLogDefaults,
  setIndentPrefixLevel,
  setLogMode,
  logTestHeader,
  logFunctionHeader,
  logDetail,
  log,
} = require("./prod/lib/utils/logging");

const { deployContract } = require("./prod/deployContract");

let spCoinContractDeployed;

logSetup("JS => Setup Test");

describe("spCoinContract", function () {
  beforeEach(async () => {
    spCoinContractDeployed = await deployContract();
    setCreateContract(spCoinContractDeployed);
  });

  /**/

  it("PRINT STRUCTURE TREE TESTS", async function () {
    // // USAGE: addTestNetworkPatreonSponsors(_accountRecIdx, _startSpIdx, _lastSpIdx);
    // await addTestNetworkPatreonSponsors(2, [1, 7, 14, 8, 18, 9]);
    // await addTestNetworkPatreonSponsors(2, [12]);
    // await addTestNetworkPatreonSponsors(3, [14, 17]);
    // await addTestNetworkPatreonSponsors(1, [5, 11, 13, 15]);
    // await addTestNetworkPatreonSponsors(14, [18, 19, 7]);
    // await addTestNetworkPatreonSponsors(3, [4]);
    // await addTestNetworkPatreonSponsors(1, [2, 5]);
    // await addTestNetworkPatreonSponsors(11, [5, 9, 0]);

    // // USAGE: addNetworkSponsorAgents(_accountRecIdx, _sponsorRecIdx, _startAgIdx, _lastAgIdx);
    // await addTestNetworkSponsorAgents(1, 5, [7, 2, 17, 3, 9, 19]);
    // await addTestNetworkSponsorAgents(11, 18, [5, 7, 9, 6]);
    // await addTestNetworkSponsorAgents(0, 2, [6, 7, 16]);
    // await addTestNetworkSponsorAgents(14, 6, [1]);
    // await addTestNetworkSponsorAgents(14, 0, [1, 11, 5, 12, 2]);
    // await addTestNetworkSponsorAgents(0, 1, [2, 3]);
    // await addTestNetworkSponsorAgents(3, 4, [5]);

    // await addTestNetworkSponsorAgents(0, 1, [3,4,5,6]);
    // await addTestNetworkSponsorAgents(2, 1, [4]);
    // await addTestNetworkSponsorAgents(0, 1, [2,3,4]);
    // await addTestNetworkSponsorAgents(1, 0, [4]);

    // await addTestNetworkPatreonSponsors(1, [2]);
    await addTestNetworkAccounts([0,1,2,3,4]);
    let accountArr = await loadTreeStructures(spCoinContractDeployed);
    logAccountStructure(accountArr);
    
    accountArr = await getAccountArrayList();
    console.log(accountArr);

  });

});
