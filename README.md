# Gas Cashback

Gas Cashback is a blockchain mass adoption paradigm centered around providing cashback to users for the Gas they spend within the system.

## Abstract

It is a known fact that transactions in Ethereum are overpriced. This is one of the main obstacles to blockchain mass adoption. Due to this, some applications are migrating to Layer 2 solutions or other blockchains to provide users with a better user experience.

Although Ethereum switched to the Proof-of-Stake consensus mechanism, Gas fees have not yet lowered. At the moment of writing this README, the Gas price is 56 gwei, and 1 ETH = $3485, making an ordinary ERC20 transfer cost over $4, which is simply burned!

## Solution

A reasonable economic solution is an ERC20 Gas cashback token. It is a token minted each time Gas is spent within the project.

As the token would be minted equivalently to the burned Gas, it would be collateralized by spent funds and have a reasonable price (actually, close to ETH price).

To make the token useful, utility should be provided: the token should be reused within the system (discounts to the holders, usage as payment for paymaster in Account Abstraction, or any other utilities).

## Example

The `GasCashbackToken` contract provides a simple example of an ERC20 token that is only minted when Gas is burned.

The approach is simple: there are constants defined containing the minimal amount of Gas burned for different function calls. All the ERC20 functionality is wrapped within the contract using the `gasmint(GAS)` modifier.

It needs to be mentioned that tokens are minted to the `tx.origin` account (actually the one who spends Gas). However, it may be inconsistent with the Account Abstraction paymasters scheme. Mint tokens to `msg.sender` if considering it to be more reasonable for your project.

## Get started

Clone the repository:

```sh
git clone https://github.com/Sh1nbatsu/gas-cashback.git
```

Install dependencies:

```sh
npm i
```

Run commands:

```sh
npm run test
npm run coverage
npm run gas-report
```
