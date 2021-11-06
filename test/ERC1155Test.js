const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");
const { hre } = require('hardhat');

describe("BibimbeatERC1155", function () {
  it("Checks tokenID to be 1", async function () {
    const BibimbeatERC1155 = await ethers.getContractFactory("BibimbeatERC1155");
    // const BibimbeatERC20V2 = await ethers.getContractFactory("BibimbeatERC20V2");
    
    const bibimbeatERC1155 = await upgrades.deployProxy(BibimbeatERC1155
      // , {kind: 'uups'}
      );

    expect(await bibimbeatERC1155.tokenId()).to.equal("1");
    
  });
  
});