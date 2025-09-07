// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title CollateralVault - Issue stable tokens against carbon credits
contract CollateralVault {
    IERC20 public carbonToken;
    IERC20 public stableToken;
    uint256 public ratio = 150; // 150% overcollateralization

    constructor(address _carbon, address _stable) {
        carbonToken = IERC20(_carbon);
        stableToken = IERC20(_stable);
    }

    function deposit(uint256 amount) external {
        require(carbonToken.transferFrom(msg.sender, address(this), amount), "transfer failed");
        uint256 stableOut = (amount * 100) / ratio;
        stableToken.transfer(msg.sender, stableOut);
    }
}
