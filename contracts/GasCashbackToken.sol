// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GasCashbackToken is ERC20 {
    // The minimal Gas amount spent by the corresponding functions
    uint256 public constant GAS_MINT = 33537;
    uint256 public constant GAS_TRANSFER = 41928;
    uint256 public constant GAS_APPROVE = 36722;
    uint256 public constant GAS_TRANSFER_FROM = 52351;

    constructor() ERC20("GasCashback", "GCB") {}

    function mint() external {
        _mint(tx.origin, GAS_MINT);
    }

    function transfer(
        address to,
        uint256 value
    ) public override returns (bool) {
        _mint(tx.origin, GAS_TRANSFER);
        return super.transfer(to, value);
    }

    function approve(
        address spender,
        uint256 value
    ) public override returns (bool) {
        _mint(tx.origin, GAS_APPROVE);
        return super.approve(spender, value);
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public override returns (bool) {
        _mint(tx.origin, GAS_TRANSFER_FROM);
        return super.transferFrom(from, to, value);
    }
}
