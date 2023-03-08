const {
  AccountStruct,
  SponsorStruct,
  AgentStruct,
  RateHeaderStruct,
  TransactionStruct,
} = require("../dataTypes");

deSerializedAccountRec = async (serializedAccountRec) => {
  // LOG_DETAIL = true;
  logFunctionHeader(
    "deSerializedAccountRec = async(" + serializedAccountRec + ")"
  );
  logDetail("JS => serializedAccountRec:\n" + serializedAccountRec);
  let accountStruct = new AccountStruct();
  let elements = serializedAccountRec.split("\\,");
  for (let i = 0; i < elements.length; i++) {
    let element = elements[i].trim();
    let keyValue = element.split(":");
    logDetail("JS => keyValue = " + keyValue);

    let key = keyValue[0].trim();
    let value = keyValue[1].trim();
    // logDetail("JS => key     = " + key);
    // logDetail("JS => value   = " + value);
    addAccountField(key, value, accountStruct);
  }

  logDetail("JS => scPrintStructureTest.js, accountStruct:");
  logDetail("JS => accountStruct               = " + JSON.stringify(accountStruct, 0, 2)
  );
  logDetail("JS => ============================================================================"
  );
  return accountStruct;
};

addAccountField = (key, value, accountStruct) => {
  logFunctionHeader("addAccountField = (" + key + "," + value + ")");
  switch (key.trim()) {
    case "index":
      logDetail("JS => setting accountStruct.index = " + value);
      accountStruct.index = value;
      break;
    case "accountKey":
      logDetail("JS => setting accountStruct.index = " + value);
      accountStruct.accountKey = value;
      break;
    case "insertionTime":
      logDetail("JS => setting accountStruct.insertionTime = " + value);
      accountStruct.insertionTime = value;
      break;
    case "inserted":
      logDetail("JS => setting accountStruct.inserted = " + value);
      accountStruct.inserted = value;
      break;
    case "verified":
      logDetail("JS => setting accountStruct.verified = " + value);
      accountStruct.verified = value;
      break;
    case "KYC":
      logDetail("JS => setting accountStruct.KYC = " + value);
      accountStruct.KYC = value;
      break;
    case "accountSponsorKeys":
      logDetail("JS => setting accountStruct.accountSponsorKeys = " + value);
      accountStruct.accountSponsorKeys = value;
      break;
    case "accountSponsorObjects":
      logDetail("JS => setting accountStruct.accountSponsorObjects = " + value);
      accountStruct.accountSponsorObjects = value;
      break;
    case "accountAgentKeys":
      logDetail("JS => setting accountStruct.accountAgentKeys = " + value);
      accountStruct.accountAgentKeys = parseAddressStrArray(value);
      break;
    case "accountPatreonKeys":
      logDetail("JS => setting accountStruct.accountPatreonKeys = " + value);
      accountStruct.accountPatreonKeys = parseAddressStrArray(value);
      break;
    default:
      break;
  }
};

parseAddressStrArray = (strArray) => {
  logFunctionHeader("parseAddressStrArray = " + strArray);
  console.log("parseAddressStrArray = " + strArray);

  strArray = strArray.substring(0, strArray.length - 1);
  addressStrArray = strArray.split(",");
  return addressStrArray;
};

module.exports = {
  addAccountField,
};
