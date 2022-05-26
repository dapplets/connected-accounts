import { use, expect } from "chai";
import { ethers } from "hardhat";
import chaiAsPromised from "chai-as-promised";
import { Contract } from "ethers";
use(chaiAsPromised);

describe("ConnectedAccount", function () {
  let accountAddress: string;
  let contract: Contract;

  beforeEach(async function () {
    const [acc1] = await ethers.getSigners();

    const ConnectedAccount = await ethers.getContractFactory(
      "ConnectedAccount",
      acc1
    );
    const deploy = await ConnectedAccount.deploy();
    await deploy.deployed();

    accountAddress = acc1.address;
    contract = deploy;
  });

  it("The contract is being deposited", async function () {
    expect(contract.address).to.be.properAddress;
  });
});
