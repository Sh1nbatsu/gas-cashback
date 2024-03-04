// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GasCashbackToken is ERC20 {
    // The minimal Gas amount spent by the corresponding functions
    uint256 public constant GAS_MINT = 33537;
    uint256 public constant GAS_TRANSFER = 41928;
    uint256 public constant GAS_APPROVE = 36722;
    uint256 public constant GAS_TRANSFER_FROM = 60351;

    constructor() ERC20("GasCashback", "GCB") {}

    // This modifier is used to mint Gas Cashback
    modifier gasmint(uint256 gas) {
        _mint(tx.origin, gas);
        _;
    }

    function mint() external gasmint(GAS_MINT) {}

    function transfer(
        address to,
        uint256 value
    ) public override gasmint(GAS_TRANSFER) returns (bool) {
        return super.transfer(to, value);
    }

    function approve(
        address spender,
        uint256 value
    ) public override gasmint(GAS_APPROVE) returns (bool) {
        return super.approve(spender, value);
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public override gasmint(GAS_TRANSFER_FROM) returns (bool) {
        return super.transferFrom(from, to, value);
    }
}
