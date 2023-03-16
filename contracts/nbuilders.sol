// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Whitelist.sol";

contract NBuildersNFT is ERC1155Burnable, Ownable, Whitelist {
    using Strings for uint256;

    uint256 public totalSupply;

    event sessionMintCompleted(uint256 indexed sessionId);

    constructor(string memory path) ERC1155(path){}

    function mintSessionNFT(address[] calldata addrs, uint256 sessionId) public isWhitelisted {
        for (uint256 i; i < addrs.length; i++) {
            uint256 tokenIndex = totalSupply++;
            _mint(addrs[i], tokenIndex, 1, "");
        }
        emit sessionMintCompleted(sessionId);
    }

    function setURI(string memory newURI) public onlyOwner {
      _setURI(newURI);
    }

    function name() external pure returns (string memory) {
        return "N BUILDERS";
    }

    function symbol() external pure returns (string memory) {
        return "NB";
    }

    function uri(uint256 tokenId) public view override returns (string memory) {
      string memory baseURI = ERC1155.uri(tokenId);
      return string(abi.encodePacked(baseURI, Strings.toString(tokenId)));
    }
}