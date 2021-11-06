const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");
const { hre } = require('hardhat');

describe("BibimbeatERC20", function () {
  it("Checks Name and total supply", async function () {
    const BibimbeatERC20 = await ethers.getContractFactory("BibimbeatERC20");
    // const BibimbeatERC20V2 = await ethers.getContractFactory("BibimbeatERC20V2");
    
    const bibimbeatERC20 = await upgrades.deployProxy(BibimbeatERC20
      // , {kind: 'uups'}
      );
    // await bibimbeatERC20.deployed();
    let supply = await bibimbeatERC20.totalSupply();
    let supplyNumber = Number(supply._hex);
    console.log("supplyNumber is : " + supplyNumber);
    console.log("haha");
    // console.log(sex._hex);
    
    expect(await bibimbeatERC20.name()).to.equal("Bibimbeat");
    expect(await supplyNumber).to.equal(1000000000 * Math.pow(10, 18));

    // const bibimbeatERC20V2 = await upgrades.upgradeProxy(bibimbeatERC20, BibimbeatERC20V2);
    // expect(await bibimbeatERC20V2.version()).to.equal("V2!");
    
  });
  
});