const { expect } = require("chai");
const { testHHAccounts } = require("./testMethods/hhTestAccounts");
const { addTestNetworkPatreonSponsors,
    addTestNetworkSponsorAgents,
    addTestNetworkAccount,
    getTestHHAccountArrayKeys
  } = require("../test/testMethods/scTestMethods");

const {    
    LOG_MODE,
    setLogDefaults,
    logSetup,
    setLogMode,
    logTestHeader,
    logFunctionHeader,
    logDetail,
    log
    } = require("../test/prod/lib/utils/logging");

let account;

logSetup("JS => Setup Test");

let spCoinContractDeployed;
describe("spCoinContract", function() {
    let spCoinContract;
    let msgSender;
    beforeEach(async() =>  {
        spCoinContract = await hre.ethers.getContractFactory("SPCoin");
        logSetup("JS => spCoinContract retreived from Factory");

        logSetup("JS => Deploying spCoinContract to Network");
        spCoinContractDeployed = await spCoinContract.deploy();
        logSetup("JS => spCoinContract is being mined");

        await spCoinContractDeployed.deployed();
        logSetup("JS => spCoinContract Deployed to Network");
        msgSender = await spCoinContractDeployed.msgSender();

        setCreateContract(spCoinContractDeployed);
        setLogDefaults();
    });

    it("Deployment should return correct parameter settings", async function () {
        // setLogMode(LOG_MODE.LOG, true);
        // setLogMode(LOG_MODE.LOG_DETAIL, true);
        // setLogMode(LOG_MODE.LOG_TEST_HEADER, true);
        // setLogMode(LOG_MODE.LOG_FUNCTION_HEADER, true);
        // setLogMode(LOG_MODE.LOG_SETUP, true);
        logTestHeader("ACCOUNT DEPLOYMENT");
        let testName         = "sponsorTestCoin";
        let testSymbol       = "SPTest";
        let testDecimals    = 3;
        let testTotalSupply = 10 * 10**testDecimals;
        let testMsgSender   = testHHAccounts[0];
        await spCoinContractDeployed.initToken(testName,  testSymbol, testDecimals, testTotalSupply);
        logDetail("JS => MsgSender = " + msgSender);
        logDetail("JS => Name      = " + await spCoinContractDeployed.name());
        logDetail("JS => Symbol    = " + await spCoinContractDeployed.symbol());
        logDetail("JS => Decimals  = " + await spCoinContractDeployed.decimals());
        logDetail("JS => balanceOf = " + await spCoinContractDeployed.balanceOf(msgSender));
        expect(await spCoinContractDeployed.msgSender()).to.equal(testMsgSender);
        expect(await spCoinContractDeployed.name()).to.equal(testName);
        expect(await spCoinContractDeployed.symbol()).to.equal(testSymbol);
        let solDecimals = await spCoinContractDeployed.decimals();
        expect(solDecimals).to.equal(testDecimals);
        expect(await spCoinContractDeployed.decimals()).to.equal(testDecimals);
//        expect(await spCoinContractDeployed.balanceOf(msgSender)).to.equal(testTotalSupply);
    });
    
    it("Account Insertion Validation", async function () {
        logTestHeader("TEST ACCOUNT INSERTION");
        let account = testHHAccounts[0];
        let recCount = await spCoinContractDeployed.getAccountSize();
        expect(recCount).to.equal(0);
        logDetail("JS => ** Before Inserted Record Count = " + recCount);
        let isAccountInserted = await spCoinContractDeployed.isAccountInserted(account);
        logDetail("JS => Address "+ account + " Before Inserted Record Found = " + isAccountInserted);
        await spCoinContractDeployed.addAccountRecord(account);
        isAccountInserted = await spCoinContractDeployed.isAccountInserted(account);
        logDetail("JS => Address "+ account + " After Inserted Record Found = " + isAccountInserted);
        recCount = await spCoinContractDeployed.getAccountSize();
        logDetail("JS => ** After Inserted Record Count = " + await recCount);        
        expect(recCount).to.equal(1);
    });

    it("Insertion 20 Hardhat Accounts for Validation", async function () {
        logTestHeader("ADD MORE HARDHAT ACCOUNTS")
        await addAccountRecords(testHHAccounts);

        logDetail("JS => *** RETRIEVE ALL INSERTED RECORDS FROM THE BLOCKCHAIN ***")
        let insertedArrayAccounts = await getAccountKeys();
        let testRecCount = testHHAccounts.length;
        let insertedRecCount = insertedArrayAccounts.length;
        expect(testRecCount).to.equal(insertedRecCount);

        for(idx = 0; idx < insertedRecCount; idx++) {
            expect(testHHAccounts[idx]).to.equal(insertedArrayAccounts[idx]);
            account = insertedArrayAccounts[idx];
            logDetail("JS => Address Retrieved from Block Chain at Index " + idx + "  = "+ account );
        }
    });
    
    it("Insert 4 Sponsor Coin Records 1 count, 1 sponsor and 2 Agents", async function () {
        logTestHeader("TEST MORE HARDHAT SPONSOR RECORD INSERTIONS")

        logDetail("JS => *** Insert Sponsor to AccountRecord[2] as AccountRecord[5] ***")
        let startRec = 4;
        let endRec = 15;
        await addTestNetworkSponsorAgents(3, 6, [1, 2]);
        let insertCount = await spCoinContractDeployed.getAccountSize();
        expect(insertCount).to.equal(4);
    });
});
