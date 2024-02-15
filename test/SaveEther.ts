import { time, loadFixture, } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { SaveEther__factory } from "../typechain-types";
import { parseEther } from "ethers";

describe("SaveEther", function () {
  let owner:any, Address1:any, Address2:any
  let saveEther:any
  let contractBalance = ethers.parseUnits("0", 18)
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  beforeEach(async function () {
    const SaveEther = await ethers.getContractFactory("SaveEther");
    [owner, Address1, Address2 ] = await ethers.getSigners()
    saveEther = await SaveEther.deploy();
  })

  it("it should check balance", async function(){
    expect(await saveEther.checkContractBal()).to.equal(contractBalance)
  })
  it("it should deposite amount", async function(){
    await saveEther.connect(owner).deposit({value:ethers.parseUnits("1", 18)})
    expect(await saveEther.checkContractBal()).to.equal(ethers.parseUnits("1", 18))
  } )
  it("It should return user balance", async function(){
    await saveEther.connect(owner).deposit({value:ethers.parseUnits("1", 18)})
   let value = await saveEther.connect(owner).checkSavings(owner.address)
   expect(value).to.equal(ethers.parseUnits("1", 18))
  } )
  it("it should be withdrawable", async function(){
    await saveEther.connect(owner).deposit({value:ethers.parseUnits("1", 18)})
    await saveEther.connect(owner).withdraw()
    let savingsValue = await saveEther.connect(owner).checkSavings(owner.address)
    expect(savingsValue).to.equal(ethers.parseUnits("0", 18))
  })
  it("it should be able to send out funds", async function(){
    await saveEther.connect(owner).deposit({amount:ethers.parseUnits("1", 18)})
    await saveEther.connect(owner).sendOutSavings(Address1.address, 1)
    // let savingsValue = await saveEther.connect(Address1).checkSavings(Address1.address)
    // expect(savingsValue).to.equal(ethers.parseUnits("0.5", 18))
  })
});
