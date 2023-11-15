//Migratation script 
var KYCPrototype = artifacts.require("KYCPrototype");

module.exports = function(deployer){
    deployer.deploy(KYCPrototype);
}
