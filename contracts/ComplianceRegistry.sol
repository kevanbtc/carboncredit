// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title ComplianceRegistry - FATF Travel Rule + ISO 20022
contract ComplianceRegistry {
    mapping(address => bool) public isWhitelisted;
    mapping(address => string) public kycHash;

    event Whitelisted(address indexed user, string kycData);
    event Removed(address indexed user);

    function whitelist(address user, string calldata kycData) external {
        isWhitelisted[user] = true;
        kycHash[user] = kycData;
        emit Whitelisted(user, kycData);
    }

    function remove(address user) external {
        isWhitelisted[user] = false;
        emit Removed(user);
    }

    function enforce(address from, address to) external view {
        require(isWhitelisted[from] && isWhitelisted[to], "Not compliant");
    }
}
