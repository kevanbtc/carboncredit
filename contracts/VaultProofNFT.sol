// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/// @title VaultProofNFT - Proof of Reserve for Carbon Credit Batches
contract VaultProofNFT is ERC721 {
    uint256 public nextId;
    mapping(uint256 => string) private _reserveCID;

    constructor() ERC721("VaultProofNFT", "VPNFT") {}

    function mint(address to, string memory ipfsCID) external returns (uint256) {
        uint256 id = ++nextId;
        _safeMint(to, id);
        _reserveCID[id] = ipfsCID;
        return id;
    }

    function reserveCID(uint256 id) external view returns (string memory) {
        return _reserveCID[id];
    }
}
