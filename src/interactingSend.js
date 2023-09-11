const IconService = require("icon-sdk-js");
const { ethers } = require("ethers");
const Web3Utils = require("web3-utils");
const fs = require("fs");

/* 
* @dev Send message to contract on desination
* @param {string} _to The BTP(Blockchain Transmisson Protocol) address of the callee on the destination chain
* @param {object} _data The calldata for the destination chain
*/
async function sendMessage(_to, _data)

/*
* @dev Get sendMessage() call result, if fail retry?
* @param{object} rs The rs of the sendMessage() txns 
*/
async function messageResult(rs)

/*
* @dev Listen for event on destination chain
* @param {object} abi
* @param {string} address EVM xCall address 
* @return {object} contractObject
* 
*/
const cmFilters = async function getContractObjectEVM(abi, address)

/*
* @dev Wait for callMessage event on destiation chain
* @param {string} contract address of EOA?? destination?? xCall??
* @param{object} cmfilters Object returned from getContractObjectEVM callMessageFilters

* @return events arguments
* @param _from The BTP address of the caller on the source chain
* @param _to A string representation of the callee address
* @param _sn The serial number of the request from the source
* @param _reqId The request id of the destination chain
* @param _data The calldata
*/
const events = async function waitEventEVM(contract, cmFilters)
/*
* @dev Once you have verifed that the event has been raised in the destniation chain, call the handleCallMessage. This is done by calling excuteCall
* @param _reqId The request id from events.reqId
* @param data The calldata
*/
async function excuteCall(reqId, data)

/*
* @dev Fetch the event on destination chain after executeCall
* @param contract Address of contract on destination chain
* @param filter List of events
* @param reciept 

*/
function filterEventEVM(contract, filter, reciept)













