// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");
const { ethers, upgrades } = require("hardhat");
async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');
  let bibimbeatERC20Address = '0x54cC34B1C8C93Dda6D703CC1F8789fe4a4434c51';
  let bibimbeatERC1155Address = '0x93f71d1719023396BD9C30d882c22477A478e9ca';
  

  // We get the contract to deploy
  const BibimbeatNFTDex = await ethers.getContractFactory("BibimbeatNFTDex");
  const bibimbeatNFTDex = await upgrades.deployProxy(BibimbeatNFTDex, [bibimbeatERC20Address, bibimbeatERC1155Address]);

  bibimbeatNFTDex.deployed();
  
  console.log("BibimbeatNFTDEX deployed to:", bibimbeatNFTDex.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
