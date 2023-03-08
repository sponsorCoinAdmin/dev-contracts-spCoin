const { AccountStruct,
        SponsorStruct,
        AgentStruct,
        RateHeaderStruct,
        TransactionStruct } = require("../prod/lib/dataTypes");
const { logFunctionHeader } = require("../prod/lib/utils/logging");

printTestHHAccounts = () => {
    return JSON.stringify(testHHAccounts, null, 2);
}

///////////////////////////////// Structure Data //////////////////////////////

printStructureTree = (_structure) => {
    logFunctionHeader("printStructureTree (" + _structure + ")");
    let structure = getJSONStructureTree(_structure);
    console.log(structure);
}

printStructurePatreonSponsors = async(_accountStruct) => {
    logFunctionHeader("printStructurePatreonSponsors (" + _accountStruct + ")");
    let accountSponsors = getJSONStructurePatreonSponsors(_accountKey);
    console.log(accountSponsors);
}

printStructureAccountKYC = async(_accountStruct) => {
    logFunctionHeader("printStructureAccountKYC (" + _accountStruct + ")");
    let accountKYC = getJSONStructureAccountKYC(_accountKey);
    console.log(accountKYC);
}

printStructureSponsorAgents = async(_sponsorStruct) => {
    logFunctionHeader("printStructureSponsorAgents (" + _sponsorStruct + ")");
    let sponsorAgents = getJSONStructureSponsorAgents(_accountKey, _sponsorAccountKey);
    console.log(sponsorAgents);
}

///////////////////////////////// Structure Data //////////////////////////////

getJSONStructureTree = (_structure) => {
    logFunctionHeader("getJSONStructureTree (" + _structure + ")");
    return JSON.stringify(_structure, null, 2);
}

getJSONStructurePatreonSponsors = async(_accountStruct) => {
    logFunctionHeader("getJSONStructurePatreonSponsors (" + _accountStruct + ")");
    return JSON.stringify(_accountSponsors, null, 2);
}

getJSONStructureAccountKYC = async(_accountStruct) => {
    logFunctionHeader("getJSONStructureAccountKYC (" + _accountStruct + ")");
    return JSON.stringify(_accountStruct.KYC, null, 2);
}

getJSONStructureSponsorAgents = async(_sponsorStruct) => {
    logFunctionHeader("getJSONStructureSponsorAgents (" + _sponsorStruct + ")");
    return JSON.stringify(_sponsorStruct, null, 2);
}

///////////////////////////////// NetWork Stuff //////////////////////////////

printNetworkPatreonSponsors = async(_accountKey) => {
    logFunctionHeader("printNetworkPatreonSponsors (" + _accountKey + ")");
    let accountSponsors = getJSONNetworkPatreonSponsors(_accountKey);
    console.log(accountSponsors);
}

printNetworkAccountKYC = async(_accountKey) => {
    logFunctionHeader("printNetworkAccountKYC (" + _accountKey + ")");
    let accountKYC = getJSONNetworkAccountKYC(_accountKey);
    console.log(accountKYC);
}

printNetworkSponsorAgents = async(_accountKey, _sponsorAccountKey) => {
    logFunctionHeader("printNetworkSponsorAgents (" + _accountKey + ", " + _sponsorAccountKey + ")");
    let sponsorAgents = getJSONNetworkSponsorAgents(_accountKey, _sponsorAccountKey);
    console.log(sponsorAgents);
}

///////////////////////////////// NetWork Stuff //////////////////////////////

getJSONNetworkPatreonSponsors = async(_accountKey) => {
    logFunctionHeader("getJSONNetworkPatreonSponsors (" + _accountKey + ")");
    let accountSponsors = getNetworkPatreonSponsors(_accountKey);
    return JSON.stringify(accountSponsors, null, 2);
}

getJSONNetworkAccountKYC = async(_accountKey) => {
    logFunctionHeader("getJSONNetworkAccountKYC (" + _accountKey + ")");
    let accountKYC = getNetworkAccountKYC(_accountKey);
    return JSON.stringify(accountKYC, null, 2);
}

getJSONNetworkSponsorAgents = async(_accountKey, _sponsorAccountKey) => {
    logFunctionHeader("getJSONNetworkSponsorAgents (" + _accountKey + ", " + _sponsorAccountKey + ")");
    let sponsorAgents = getNetworkSponsorAgents(_accountKey, _sponsorAccountKey);
    return JSON.stringify(sponsorAgents, null, 2);
}

////////////////////////// To Do Get From Network ////////////////////////////

getNetworkPatreonSponsors = async(_accountKey) => {
    logFunctionHeader("getNetworkPatreonSponsors (" + _accountKey + ")");
    let accountSponsors = await getNetworkPatreonSponsors(_accountKey);
    return JSON.stringify(accountSponsors, null, 2);
}

getNetworkAccountKYC = async(_accountKey) => {
    logFunctionHeader("getNetworkAccountKYC (" + _accountKey + ")");
    let accountKYC = await getNetworkAccountKYC(_accountKey);
    return JSON.stringify(accountKYC, null, 2);
}

getNetworkSponsorAgents = async(_accountKey, _sponsorAccountKey) => {
    logFunctionHeader("getNetworkSponsorAgents (" + _accountKey + ", " + _sponsorAccountKey + ")");
    let sponsorAgents = await getNetworkSponsorAgents(_accountKey, _sponsorAccountKey);
    return JSON.stringify(sponsorAgents, null, 2);
}

module.exports = {
// Local Calls
    printTestHHAccounts,
    printStructureTree,
    printStructurePatreonSponsors,
    printStructureAccountKYC,
    printStructureSponsorAgents,
    getJSONStructurePatreonSponsors,
    getJSONStructureAccountKYC,
    getJSONStructureSponsorAgents,
    // NetWork Calls
    printNetworkPatreonSponsors,
    printNetworkAccountKYC,
    printNetworkSponsorAgents,
    getJSONNetworkPatreonSponsors,
    getJSONNetworkAccountKYC,
    getJSONNetworkSponsorAgents,
    getNetworkPatreonSponsors,
    getNetworkAccountKYC,
    getNetworkSponsorAgents
}