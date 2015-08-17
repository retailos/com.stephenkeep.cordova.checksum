var argscheck = require('cordova/argscheck'),
    channel = require('cordova/channel'),
    utils = require('cordova/utils'),
    exec = require('cordova/exec'),
    cordova = require('cordova');

channel.createSticky('onCordovaChecksumReady');
// Tell cordova channel to wait on the CordovaInfoReady event
channel.waitForInitialization('onCordovaChecksumReady');

function Checksum() {
  channel.onCordovaReady.subscribe(function() {
    channel.onCordovaChecksumReady.fire();
  });
}

/**
 * @param {Function} successCallback The function to call when the heading data is available
 * @param {Function} errorCallback The function to call when there is an error getting the heading data. (OPTIONAL)
 */
Checksum.prototype.MD5 = function(options, successCallback, errorCallback) {
    exec(successCallback, errorCallback, "Checksum", "MD5", options);
};

module.exports = new Checksum();