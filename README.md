# DOS-CLI-Tool

True Windows command line wrapper for the VerusCoin daemon, for most common actions on dedicated staking platform.

You will need to edit the batchfile in order to customize it for your system:
```
rem *************************************************************
rem ***                                                       ***
rem ***          Begin: parameters specific to users          ***
rem ***                                                       ***
rem ***  T-ADDRESS is your Public VRSC Address                ***
rem ***  Z-ADDRESS is your Private VRSC Address               ***
rem ***                                                       ***
rem ***  FILELOCATION is your complete path to the verus      ***
rem ***  binaries. e.g. C:\mining\verus-cli                   ***
rem ***                                                       ***
rem *************************************************************
set T-ADDRESS=REPLACE_WITH_YOUR_TRANSPARENT_R-ADDRESS
set Z-ADDRESS=REPLACE_WITH_YOUR_PRIVATE_Z-ADDRESS
set FILELOCATION=REPLACE_WITH_FULL_PATH_TO_YOUR_CLI_EXECUTABLES
rem *************************************************************
rem ***           End: parameters specific to users           ***
rem *************************************************************
```

The Public, private and file location needs to be set.

Pull Requests are welcome.

Disclaimer:
Use the software at your own risk. No liabilities...
