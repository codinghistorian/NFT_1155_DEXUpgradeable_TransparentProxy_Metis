require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");
require("@metis.io/hardhat-mvm");
require("dotenv").config();

module.exports = {
  networks: {
    hardhat: {
    },
    // rinkeby: {
    //   url: process.env.rinkebyUrl,
    //   accounts: [process.env.privateKey],
    // },
    metis: {
      url: process.env.metisUrl,
      accounts: [process.env.privateKey],
      // gasPrice: 15000000,
    },
  },
  solidity: "0.7.6",
};




// module.exports = {
//   networks: {
//     metis: {
//           url: process.env.url,
//           accounts: [process.env.privateKey],
//           gasPrice: 15000000,
//           ovm: true,
//     }
// },
// solidity: '0.7.6',
// ovm: {
//     solcVersion: '0.7.6', // Currently, we only support 0.5.16, 0.6.12, and 0.7.6 of the Solidity compiler
//     optimizer: true,
//     runs: 20
// },
// };
