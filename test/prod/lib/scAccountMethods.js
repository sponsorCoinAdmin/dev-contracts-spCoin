const {
  AccountStruct,
  SponsorStruct,
  AgentStruct,
  RateHeaderStruct,
  TransactionStruct,
} = require("./dataTypes");

const {} = require("./utils/serialize");

const { logFunctionHeader, logDetail } = require("./utils/logging");

let spCoinContractDeployed;

//////////////////////////// ROOT LEVEL FUNCTIONS ////////////////////////////

setCreateContract = (_spCoinContractDeployed) => {
  spCoinContractDeployed = _spCoinContractDeployed;
};

getAccountSize = async () => {
  logFunctionHeader("getAccountSize = async()");
  let maxSize = await spCoinContractDeployed.getAccountSize();
  logDetail("JS => Found " + maxSize + " Account Records");
  return maxSize;
};

getAccountKeys = async () => {
  logFunctionHeader("getAccountKeys = async()");
  let maxSize = await spCoinContractDeployed.getAccountSize();

  var insertedArrayAccounts = [];
  for (idx = 0; idx < maxSize; idx++) {
    let account = await spCoinContractDeployed.getAccountKey(idx);
    logDetail("JS => Address at Index " + idx + "  = " + account);
    insertedArrayAccounts.push(account);
  }
  return insertedArrayAccounts;
};

////////////////////////// ACCOUNT OBJECT FUNCTIONS //////////////////////////

addAccountRecord = async (_accountKey) => {
  logFunctionHeader("addAccountRecord = async(" + _accountKey + ")");
  logDetail("JS => Inserting Account " + _accountKey + " To Blockchain Network");
  await spCoinContractDeployed.addAccountRecord(_accountKey);
};

addAccountRecords = async (_accountArrayKeys) => {
  logFunctionHeader("addAccountRecord = async(arrayAccounts)");
  let maxSize = _accountArrayKeys.length;
  logDetail("JS => Inserting " + maxSize + " Records to Blockchain Network");

  for (idx = 0; idx < maxSize; idx++) {
    let account = _accountArrayKeys[idx];
    logDetail("JS => Inserting " + idx + ", " + account);
    await spCoinContractDeployed.addAccountRecord(account);
  }
  logDetail("JS => Inserted " + maxSize + " Accounts to Blockchain Network");

  return maxSize;
};

getAccountRecord = async (_accountKey) => {
  logFunctionHeader("getAccountRecord = async(" + _accountKey + ")");
  let serializedAccountRec =
    await spCoinContractDeployed.getSerializedAccountRec(_accountKey);
  return deSerializedAccountRec(serializedAccountRec);
};

getChildSponsorKeys = async (_accountKey) => {
  logFunctionHeader("getChildSponsorKeys = async(" + _accountKey + ")");

  let maxSize = await spCoinContractDeployed.getChildSponsorKeys(_accountKey);
  logDetail("JS => Found " + maxSize + " Sponsor Records For Account " + _accountKey
  );
  return maxSize;
};

getAccountPatreonSize = async (_accountKey) => {
  logFunctionHeader("getAccountPatreonSize = async(" + _accountKey + ")");

  let maxSize = await spCoinContractDeployed.c(_accountKey);
  logDetail("JS => Found " + maxSize + " Patreon Records For Account " + _accountKey
  );
  return maxSize;
};

getChildAccountAgentSize = async (_accountKey) => {
  logFunctionHeader("getChildAccountAgentSize = async(" + _accountKey + ")");

  let maxSize = await spCoinContractDeployed.getChildAccountAgentSize(_accountKey);
  logDetail("JS => Found " + maxSize + " Agent Records For Account " + _accountKey
  );
  return maxSize;
};

getAccountAgentSponsorKeys = async (_accountKey) => {
  logFunctionHeader("getAccountAgentSponsorKeys = async(" + _accountKey + ")");
  let maxSize = await spCoinContractDeployed.getAccountParentSponsorSize(_accountKey);
  let accountParentSponsorKeys = {};
  for (let idx = 0; idx < maxSize; idx++) {
    let parentSponsor = await spCoinContractDeployed.getAccountParentSponsorByIdx(_accountKey, idx );
    accountParentSponsorKeys[parentSponsor] = idx;
  }
  return accountParentSponsorKeys;
}

getAccountPatreonKeys = async (_accountKey) => {
  logFunctionHeader("getAccountPatreonKeys = async(" + _accountKey + ")");
  let maxSize = await spCoinContractDeployed.getAccountPatreonSize(_accountKey);

  let accountParentPatreonKeys = {};

  for (let idx = 0; idx < maxSize; idx++) {
    let patreon = await spCoinContractDeployed.getAccountPatreonKeyByIndex(_accountKey, idx );
    accountParentPatreonKeys[patreon] = idx;
  }
  return accountParentPatreonKeys;
};

getPatreonSponsorKeys = async (_accountKey) => {
  logFunctionHeader("getPatreonSponsorKeys = async(" + _accountKey + ")");
  let maxSize = await spCoinContractDeployed.getChildSponsorKeys(_accountKey);

  let accountChildSponsorKeys = {};

  for (let idx = 0; idx < maxSize; idx++) {
    let sponsor = await spCoinContractDeployed.getPatreonSponsorKeyByIndex(_accountKey, idx );
    accountChildSponsorKeys[sponsor] = idx;
  }
  return accountChildSponsorKeys;
};

getAccountAgentKeys = async (_accountKey) => {
  logFunctionHeader("getAccountAgentKeys = async(" + _accountKey + ")");
  let maxSize = await getChildAccountAgentSize(_accountKey);

  let accountChildAgentKeys = {};

  for (let idx = 0; idx < maxSize; idx++) {
    let patreon = await spCoinContractDeployed.getAccountChildAgentKeyByIndex(_accountKey, idx );
    accountChildAgentKeys[patreon] = idx;
  }
  return accountChildAgentKeys;
};
  
/////////////////////// SPONSOR OBJECT FUNCTIONS ///////////////////////

addPatreonSponsor = async (_accountKey, _sponsorKey) => {
  logFunctionHeader(
    "addPatreonSponsor = async(" + _accountKey + ", " + _sponsorKey + ")"
  );

  logDetail("JS => For Account[" + _accountKey + "]: " + _accountKey + ")");
  logDetail("JS => Inserting " + _sponsorKey + " Sponsors To Blockchain Network"
  );

  logDetail("JS => Inserting Sponsor " + _sponsorKey );
  await spCoinContractDeployed.addPatreonSponsor(_accountKey, _sponsorKey);
};

addPatreonSponsors = async (_accountKey, _accountSponsorObjects) => {
  logFunctionHeader(
    "addPatreonSponsors = async(" + _accountKey + ", " + _accountSponsorObjects + ")"
  );

  logDetail("JS => For Account[" + _accountKey + "]: " + _accountKey + ")");
  logDetail("JS => Adding " + _accountSponsorObjects.length + " Sponsors To Blockchain Network"
  );

  let sponsorCount = 0;
  for (sponsorCount; sponsorCount < _accountSponsorObjects.length; sponsorCount++) {
    let _sponsorKey = _accountSponsorObjects[sponsorCount];
    await addPatreonSponsor(_accountKey, _sponsorKey);
  }
  logDetail("JS => Inserted = " + sponsorCount + " Sponsor Records");
  return --sponsorCount;
};

getSponsorAgentKeys = async (_accountKey, _sponsorAccountKey) => {
  logFunctionHeader("getSponsorAgentKeys = async(" + _accountKey + ", " + _sponsorAccountKey + ")" );
  let maxSize = await spCoinContractDeployed.getSponsorAgentSize(_accountKey, _sponsorAccountKey);

  let accountChildAgentKeys = {};
  for (let idx = 0; idx < maxSize; idx++) {
    let agent = await spCoinContractDeployed.getSponsorAgentKeyAddress(_accountKey, _sponsorAccountKey, idx);
    logDetail("JS => Agent[" + idx + "]: " + agent);
    accountChildAgentKeys[agent] = idx;
  }
  return accountChildAgentKeys;
};

getSponsorAgentSize = async (_accountKey, _sponsorAccountKey) => {
  logFunctionHeader("getSponsorAgentSize = async(" + _accountKey + ", " + _sponsorAccountKey + ")" );

  let agentSize = await spCoinContractDeployed.getSponsorAgentSize(
    _accountKey, _sponsorAccountKey );
  logDetail("JS => "+ "Inserted = " + agentSize + " Agent Records");
  return agentSize;
};

/////////////////////// AGENT OBJECT FUNCTIONS ////////////////////////

addSponsorAgent = async (_accountKey, _sponsorAccountKey, _accountAgentKey) => {
  logFunctionHeader(
    "accountAgentKey = async(" + _accountKey + ", " + _sponsorAccountKey + ", " + _accountAgentKey + ")"
  );
  logDetail("JS => For Account[" + _accountKey + "]: " + _accountKey + ")");
  logDetail("JS => Adding Agent " + _accountAgentKey + " To Blockchain Network");

  logDetail("JS =>  " + _accountKey + ". " + "Inserting Agent[" + _accountKey + "]: " + _accountAgentKey );
  await spCoinContractDeployed.addSponsorAgent( _accountKey, _sponsorAccountKey, _accountAgentKey );
  logDetail("JS => "+ "Added Agent " + _accountAgentKey + " Record to SponsorKey " + _sponsorAccountKey);
};

addSponsorAgents = async (_accountKey, _sponsorAccountKey, _accountChildAgentKeys) => {
  logFunctionHeader(
    "addSponsorAgents = async(" + _accountKey + ", " + _sponsorAccountKey + ", " + _accountChildAgentKeys + ")"
  );
  logDetail("JS => For Account[" + _accountKey + "]: " + _accountKey + ")");
  logDetail("JS => For Sponsor[" + _sponsorAccountKey + "]: " + _sponsorAccountKey + ")");
  logDetail("JS => Inserting " + _accountChildAgentKeys.length + " Agents To Blockchain Network"
  );
  logDetail("JS => _accountChildAgentKeys = " + _accountChildAgentKeys);

  let agentSize = _accountChildAgentKeys.length;
  logDetail("JS => agentSize.length = " + agentSize);
  let agentCount = 0;
  for (let agentCount = 0; agentCount < agentSize; agentCount++) {
    let agentAccountKey = _accountChildAgentKeys[agentCount];
    logDetail("JS =>  " + agentCount + ". " + "Inserting Agent[" + agentCount + "]: " + agentAccountKey );
    await addSponsorAgent( _accountKey, _sponsorAccountKey, agentAccountKey );
  }
  logDetail("JS => "+ "Inserted = " + agentSize + " Agent Records");
  return agentCount;
};

////////////////////// DELETE ACCOUNT FUNCTIONS ///////////////////////
deleteAccount = async (_accountKey) => {
  logFunctionHeader("AAAA deleteAccount = async(" + _accountKey + ")");
  log("deleteAccount = async(" + _accountKey + ")");
  logDetail("JS => Deleting Account " + _accountKey + " From Blockchain Network");
  await spCoinContractDeployed.deleteAccount(_accountKey);
};

/////////////////////// EXPORT MODULE FUNCTIONS ///////////////////////

module.exports = {
  addAccountField,
  addAccountRecord,
  addAccountRecords,
  addPatreonSponsors,
  addSponsorAgent,
  addSponsorAgents,
  deleteAccount,
  getAccountSize,
  getAccountRecord,
  getAccountKeys,
  getChildSponsorKeys,
  getSponsorAgentKeys,
  getPatreonSponsorKeys,
  setCreateContract,
};
