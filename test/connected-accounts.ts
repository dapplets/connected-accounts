import { use, expect } from "chai";
import { ethers } from "hardhat";
import chaiAsPromised from "chai-as-promised";
import { Contract } from "ethers";
import { soliditySha3 } from "web3-utils";
use(chaiAsPromised);

describe("ConnectedAccountsTest", function () {
  let accountAddress: string;
  let contract: Contract;

  beforeEach(async function () {
    const [acc1] = await ethers.getSigners();

    const ConnectedAccounts = await ethers.getContractFactory(
      "ConnectedAccountsTest",
      acc1,
    );
    const deploy = await ConnectedAccounts.deploy();
    await deploy.deployed();

    accountAddress = acc1.address;
    contract = deploy;
  });

  it("The contract is being deposited", async function () {
    expect(contract.address).to.be.properAddress;
  });

  // it("Test", async () => {
  //   await contract.createTestAccounts(100);
  //   const accountHash = soliditySha3("id_name_1", "Instagram");
  //   const data = await contract.getConnectedGroup(accountHash);
  //   console.log(`Length: ${data.length}`);
  // });

  it("Gas for getting 10 test accounts", async () => {
    await contract.createTestAccounts(10);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
  it("Gas for getting 20 test accounts", async () => {
    await contract.createTestAccounts(20);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
  it("Gas for getting 30 test accounts", async () => {
    await contract.createTestAccounts(30);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
  it("Gas for getting 40 test accounts", async () => {
    await contract.createTestAccounts(40);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
  it("Gas for getting 50 test accounts", async () => {
    await contract.createTestAccounts(50);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
  it("Gas for getting 60 test accounts", async () => {
    await contract.createTestAccounts(60);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
  it("Gas for getting 70 test accounts", async () => {
    await contract.createTestAccounts(70);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
  it("Gas for getting 80 test accounts", async () => {
    await contract.createTestAccounts(80);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
  it("Gas for getting 90 test accounts", async () => {
    await contract.createTestAccounts(90);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
  it("Gas for getting 99 test accounts", async () => {
    await contract.createTestAccounts(99);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });

  console.info("С этого моменты тесты начинают ложиться из-за нехватки газа");
  it("Gas for getting 100 test accounts", async () => {
    await contract.createTestAccounts(100);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
  it("Gas for getting 200 test accounts", async () => {
    await contract.createTestAccounts(200);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
  it("Gas for getting 300 test accounts", async () => {
    await contract.createTestAccounts(300);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
  it("Gas for getting 400 test accounts", async () => {
    await contract.createTestAccounts(400);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);

    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
  it("Gas for getting 500 test accounts", async () => {
    await contract.createTestAccounts(500);
    const accountHash = soliditySha3("id_name_1", "Instagram");
    const result = await contract.getConnectedGroupPayable(accountHash);
    const data = await contract.getConnectedGroup(accountHash);
    console.log(`Length: ${data.length}`);
    console.log(`GasUsed: ${(await result.wait()).gasUsed.toString()}`);
  });
});
