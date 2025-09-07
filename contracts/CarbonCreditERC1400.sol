// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title CarbonCreditERC1400 - Tokenized Carbon Credits (Security Standard)
/// @notice Each token = 1 certified carbon credit (1 tonne CO2e)
contract CarbonCreditERC1400 is ERC20, Ownable {
    mapping(address => bool) public isWhitelisted;

    event Whitelisted(address indexed account);
    event Removed(address indexed account);

    constructor() ERC20("CarbonCredit", "CCRED") {}

    function mint(address to, uint256 amount) external onlyOwner {
        require(isWhitelisted[to], "Not whitelisted");
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function whitelist(address account) external onlyOwner {
        isWhitelisted[account] = true;
        emit Whitelisted(account);
    }

    function remove(address account) external onlyOwner {
        isWhitelisted[account] = false;
        emit Removed(account);
    }
}
