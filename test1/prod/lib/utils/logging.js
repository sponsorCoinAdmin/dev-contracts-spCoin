// ************************* LOG SECTION ******************************/
let LOG = true;
let LOG_DETAIL = false;
let LOG_TEST_HEADER = false;
let LOG_FUNCTION_HEADER = false;
let LOG_SETUP = false;
let LOG_TREE = false;
prefix = "  ";

const LOG_MODE = {
    LOG : "LOG",
    LOG_DETAIL : "LOG_DETAIL",
    LOG_TEST_HEADER : "LOG_TEST_HEADER",
    LOG_FUNCTION_HEADER : "LOG_FUNCTION_HEADER",
    LOG_SETUP : "LOG_SETUP",
    LOG_TREE : "LOG_TREE"
  }

  setLogDefaults = (_log_mode, _state) => {
    LOG = true;
    LOG_DETAIL = false;
    LOG_TEST_HEADER = false;
    LOG_FUNCTION_HEADER = false;
    LOG_SETUP = false;
    LOG_TREE = false;
  }
    
  setLogMode = (_log_mode, _state) => {
    console.log("EXECUTING setLogMode = (" + _log_mode + ", " + _state + ")");

    switch(_log_mode) {
        case LOG_MODE.LOG:
           console.log("Setting _log_mode LOG: " + _state)
           LOG = _state;
        break;
        case LOG_MODE.LOG_DETAIL:
            console.log("Setting _log_mode LOG_DETAIL: " + _state)
            LOG_DETAIL = _state;
         break;
         case LOG_MODE.LOG_TEST_HEADER:
            console.log("Setting _log_mode LOG_TEST_HEADER: " + _state)
            LOG_TEST_HEADER = _state;
         break;
         case LOG_MODE.LOG_FUNCTION_HEADER:
            console.log("Setting _log_mode LOG_FUNCTION_HEADER: " + _state)
            LOG_FUNCTION_HEADER = _state;
         break;
         case LOG_MODE.LOG_SETUP:
            console.log("Setting _log_mode LOG_SETUP: " + _state)
            LOG_SETUP = _state;
        case LOG_MODE.LOG_TREE:
            console.log("Setting _log_mode LOG_SETUP: " + _state)
            LOG_TREE = _state;
            break;
        default:
        _text = "Unknown _log_mode " + _log_mode;
    }
}

logSetup = (_text) => {
    if (LOG_SETUP) {
        log(_text);
    }
}

logTestHeader = (_testHeader) => {
    if (LOG_TEST_HEADER) {
        log("=============== TEST HEADER " + _testHeader + " ===============");
    }
}

logFunctionHeader = (_functionHeader) => {
    if (LOG_FUNCTION_HEADER) {
        log("************** HEADER FUNCTION " + _functionHeader + " **************");
    }
}

logDetail = (_details) => {
    if (LOG_DETAIL) {
        log(_details);
    }
}

log = (_text) => {
    if (LOG) {
        console.log(_text);
    }
}

logPrefix = (_prefix, _text) => {
    log(_prefix + _text);
}

setIndentPrefixLevel = (_indentPrefix, _level) => {
    let indent = "";
    for (let i = 0; i < _level; i++)
        indent += _indentPrefix;
    return indent;
}

logAccountStructure = (_accountArr) => {
    console.log("ACCOUNT RECORD DUMP");
    console.log(JSON.stringify(_accountArr, null, 2));
}

logTree = (_tree) => {
    if (LOG_TREE) {
        console.log("TREE STRUCTURE DUMP");
//        console.log(_tree);
        console.log(JSON.stringify(_tree, null, 2));
    }
}

module.exports = {
    LOG_MODE,
    logAccountStructure,
    logSetup,
    setLogDefaults,
    setIndentPrefixLevel,
    setLogMode,
    logTestHeader,
    logFunctionHeader,
    logDetail,
    log
}
