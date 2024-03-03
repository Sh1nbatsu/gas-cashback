// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GasMinter is ERC20 {
    uint256 constant public GAS_MINT = 33537;
    uint256 constant public GAS_TRANSFER = 41928;
    uint256 constant public GAS_APPROVE = 36722;
    uint256 constant public GAS_TRANSFER_FROM = 52351;

    constructor() ERC20("GasMinter", "GMR"){
    }

    function mint() external {
        _mint(tx.origin, GAS_MINT);
    }

    function transfer(address to, uint256 value) public override returns (bool) {
        _mint(tx.origin, GAS_TRANSFER);
        return super.transfer(to, value);
    }

    function approve(address spender, uint256 value) public override returns (bool) {
        _mint(tx.origin, GAS_APPROVE);
        return super.approve(spender, value);
    }

    function transferFrom(address from, address to, uint256 value) public override returns (bool) {
        _mint(tx.origin, GAS_TRANSFER_FROM);
        return super.transferFrom(from, to, value);
    }
}