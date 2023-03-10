const { testHHAccounts } = require("../../testMethods/hhTestAccounts");
const { AccountStruct,
        SponsorStruct,
        AgentStruct,
        RateHeaderStruct,
        TransactionStruct } = require("./dataTypes");
let spCoinContractDeployed;

loadTreeStructures = async(_spCoinContractDeployed) => {
    logFunctionHeader("loadTreeStructures(" + _spCoinContractDeployed + ")");
    spCoinContractDeployed = _spCoinContractDeployed;
    let accountArr = [];
    let insertedArrayAccounts = await getAccountKeys();
    let maxSize = insertedArrayAccounts.length;
    for(let idx = 0; idx < maxSize; idx++) {
        let accountKey = insertedArrayAccounts[idx];
        let accountStruct = new AccountStruct(accountKey);

        accountStruct.index = idx;
        accountStruct.accountKey = accountKey;
        accountChildSponsorKeys = await getPatreonSponsorKeys(accountKey);
        accountStruct.accountChildSponsorKeys = accountChildSponsorKeys;
        accountStruct.accountSponsorObjects = await loadSponsorRecordsByKeys(accountKey, accountChildSponsorKeys);
        accountArr.push(accountStruct);

        accountStruct.accountParentPatreonKeys = await getAccountPatreonKeys(accountKey);
        accountStruct.accountChildAgentKeys = await getAccountAgentKeys(accountKey);
        accountStruct.accountParentSponsorKeys = await getAccountAgentSponsorKeys(accountKey);
    }
    return accountArr;
}

//////////////////// LOAD ACCOUNT DATA //////////////////////
loadSponsorsByAccount = async(_accountKey) => {    
    logFunctionHeader("loadSponsorsByAccount("  + _accountKey + ")");
    accountChildSponsorKeys = await getPatreonSponsorKeys(_accountKey);
    accountSponsorObjects = await loadSponsorRecordsByKeys(_accountKey, accountChildSponsorKeys);
    return accountSponsorObjects;
}

//////////////////// LOAD SPONSOR DATA //////////////////////

loadSponsorRecordsByKeys = async(_accountKey, _accountChildSponsorKeys) => {
    logFunctionHeader("loadSponsorRecordsByKeys(" + _accountKey + ", " + _accountChildSponsorKeys + ")");
    let accountSponsorObjects = [];
    for (let [sponsorAccountKey, idx] of Object.entries(_accountChildSponsorKeys)) {
        logDetail("JS => Loading Sponsor Record " + sponsorAccountKey, idx);
        let sponsorStruct = await loadSponsorRecordByKeys(_accountKey, sponsorAccountKey);
        sponsorStruct.index = idx;
        accountSponsorObjects.push(sponsorStruct);
    }
    return accountSponsorObjects;
}

loadSponsorRecordByKeys = async(_accountKey, _sponsorAccountKey) => {
    logFunctionHeader("loadSponsorRecordByKeys(" + _accountKey + ", " + _sponsorAccountKey + ")");
    let accountChildAgentKeys = await getChildAgentKeys(_accountKey, _sponsorAccountKey);
    let sponsorStruct = new SponsorStruct(_sponsorAccountKey);
    sponsorStruct.sponsorAccountKey = _sponsorAccountKey;
    sponsorStruct.accountChildAgentKeys = accountChildAgentKeys;
    sponsorStruct.agentObjectArray = await loadAgentRecordsByKeys(_accountKey, _sponsorAccountKey, accountChildAgentKeys);
    return sponsorStruct;
}

loadAgentsByPatreonSponsor = async(_accountKey, _sponsorAccountKey) => {
    logFunctionHeader("loadAgentsByPatreonSponsor = async(" + _accountKey + ", " + _sponsorAccountKey + ")");
    let accountChildAgentKeys = await getChildAgentKeys(_accountKey, _sponsorAccountKey);
    let agentObjectArray = await loadAgentRecordsByKeys(_accountKey, _sponsorAccountKey, accountChildAgentKeys);
    return agentObjectArray;
}

//////////////////// LOAD AGENT DATA //////////////////////

loadAgentRecordsByKeys = async(_accountKey, _sponsorAccountKey, _accountChildAgentKeys) => {
    logFunctionHeader("loadAgentRecordsByKeys(" + _accountKey + ", " + _sponsorAccountKey + ", " + _accountChildAgentKeys + ")");
    let agentObjectArray = [];
    for (let [agentAccountKey, idx] of Object.entries(_accountChildAgentKeys)) {
        logDetail("JS => Loading Agent Records " + agentAccountKey, idx);
        let agentStruct = await loadAgentRecordByKeys(_accountKey, _sponsorAccountKey, agentAccountKey);
        agentStruct.index = idx;
        agentObjectArray.push(agentStruct);
    }
    return agentObjectArray;
}

loadAgentRecordByKeys = async(_accountKey, _sponsorAccountKey, _agentAccountKey) => {
    logFunctionHeader("loadAgentRecordByKeys(" + _accountKey + ", " + _sponsorAccountKey + ", " + _agentAccountKey + ")");
    // let agentIndex = await spCoinContractDeployed.getAgentIndex(_accountKey, _sponsorAccountKey, agentAccountKey);
    // let agentActIdx = await spCoinContractDeployed.getAccountIndex(agentAccountKey);
    agentStruct = new AgentStruct();
    agentStruct.agentAccountKey = _agentAccountKey;
    //agentStruct.agentObjectArray = await spCoinContractDeployed.getAgentRecordByKeys(_accountKey, _sponsorAccountKey, _agentAccountKey);
    agentStruct.rates = ratesByAccountAgents = await loadRatesByAccountAgents(_accountKey, _sponsorAccountKey, _agentAccountKey);
    return agentStruct;
}

loadRatesByAccountAgents = async(_accountKey, _sponsorAccountKey, _agentAccountKey) => {
    // logFunctionHeader("loadAgentsByPatreonSponsor = async(" + _accountKey + ", " + _rateRecordKey + ")");
    // let agentRateKeys = await getAgentRateKeys(_accountKey, _rateRecordKey);
    // let agentRateArray = await loadAgentRatesByKeys(_accountKey, _sponsorAccountKey, _rateRecordKey);
    // return agentRateArray;
    return "ToDo Rates";
}

//////////////////// MODULE EXPORTS //////////////////////

module.exports = {
    loadTreeStructures,
    loadSponsorsByAccount,
    loadAgentsByPatreonSponsor
}
