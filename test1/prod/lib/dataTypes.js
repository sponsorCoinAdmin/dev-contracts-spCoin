class AccountStruct {
  constructor() {
    this.index;
    this.accountKey;
    this.insertionTime;
    this.verified;
    this.accountSponsorKeys;
    this.accountSponsorObjects;
    this.accountAgentKeys;
    this.accountPatreonKeys;
    this.accountAgentSponsorKeys;
    this.KYC;
  }
}

class SponsorStruct {
  constructor() {
    this.index;
    this.sponsorAccountKey;
    this.insertionTime;
    this.verified;
    this.rates;
    this.verified;
    this.accountAgentKeys;
    this.agentObjectArray;
  }
}

class AgentStruct {
  constructor() {
    this.index;
    this.agentAccountKey;
    this.insertionTime;
    this.verified;
    this.rates;
  }
}

class RateHeaderStruct {
  constructor() {
    this.insertionTime;
    this.lastUpdateTime;
    this.totalQuantity;
    this.TransactionStruct = [];
  }
}

class TransactionStruct {
  constructor() {
    this.insertionTime;
    this.quantity;
  }
}

module.exports = {
  AccountStruct,
  SponsorStruct,
  AgentStruct,
  RateHeaderStruct,
  TransactionStruct
};
