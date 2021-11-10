const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");
const { hre } = require('hardhat');

describe("NFTDEX", function () {
  

  it("Check Trade Counter and currency Token", async function () {
    const BibimbeatERC20 = await ethers.getContractFactory("BibimbeatERC20");   
    const bibimbeatERC20 = await upgrades.deployProxy(BibimbeatERC20);
  
    const bibimbeatERC20Address = bibimbeatERC20.address;
    
    const BibimbeatERC1155 = await ethers.getContractFactory("BibimbeatERC1155");
    const bibimbeatERC1155 = await upgrades.deployProxy(BibimbeatERC1155); 

    const bibimbeatERC1155Address = bibimbeatERC1155.address;

    const BibimbeatNFTDex = await ethers.getContractFactory("BibimbeatNFTDex");
    
    const bibimbeatNFTDex = await upgrades.deployProxy(BibimbeatNFTDex, [bibimbeatERC20Address, bibimbeatERC1155Address]);
    console.log(typeof bibimbeatERC1155Address);
    
    expect(await bibimbeatNFTDex.tradeCounter()).to.equal("0");
    expect(await bibimbeatNFTDex.currencyToken()).to.equal(bibimbeatERC20Address);
  });
  
});