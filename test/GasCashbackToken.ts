import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("GasCashbackToken", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployFixture() {
    // Contracts are deployed using the first signer/account by default
    const [user, loser] = await ethers.getSigners();

    const GasCashbackToken = await ethers.getContractFactory("GasCashbackToken");
    const contract = await GasCashbackToken.deploy();

    return { contract, user, loser };
  }

  describe("Deployment", function () {
    it("Transfer", async function () {
      const { user, loser, contract } = await loadFixture(deployFixture);

      const n = 1000n;

      for (let i = 0; i < n; i++) {
        await contract.connect(user).mint();
      }

      for (let i = 0; i < n; i++) {
        await contract.connect(user).transfer(loser.address, 33537);
      }

      expect(await contract.balanceOf(loser.address)).to.be.equal(
        n * (await contract.GAS_MINT())
      );

      expect(await contract.balanceOf(user.address)).to.be.equal(
        n * (await contract.GAS_TRANSFER())
      );
    });

    it("Mint", async function () {
      const { user, contract } = await loadFixture(deployFixture);

      const n = 100n;

      for (let i = 0; i < n; i++) {
        await contract.mint();
      }

      expect(await contract.balanceOf(user.address)).to.be.equal(
        n * (await contract.GAS_MINT())
      );
    });

    it("approve", async function () {
      const { user, loser, contract } = await loadFixture(deployFixture);

      await contract.approve(loser.address, 6);
      await contract.approve(loser.address, 6);
      await contract.approve(loser.address, 7);
      await contract.approve(loser.address, 0);

      expect(await contract.balanceOf(user.address)).to.be.equal(
        4n * (await contract.GAS_APPROVE())
      );
    });
  });
});
