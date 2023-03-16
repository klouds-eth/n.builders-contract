// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Whitelist is Ownable {
  // address[] private whitelisted;
  mapping(address => bool) private whitelisted;

  function addWhitelistedAddress(address addr) public onlyOwner {
    whitelisted[addr] = true;
  }

  function removeWhitelistedAddress(address addr) public onlyOwner {
    whitelisted[addr] = false;
  }

  function checkWhitelist(address addr) internal view returns (bool) {
    return msg.sender == owner() || whitelisted[addr];    
  }

  modifier isWhitelisted {
    require(checkWhitelist(msg.sender), "Only whitelisted address can call this");
    _;
  }
}