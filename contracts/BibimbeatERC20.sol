// SPDX-License-Identifier: MIT
// Openzeppelin 3.4.0
pragma solidity ^0.7.6;
// pragma solidity ^0.8.2;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/Initializable.sol";

// import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";   these two paths are for the latest version
// import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";  these two paths are for the latest version
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract BibimbeatERC20 is Initializable, ERC20Upgradeable, OwnableUpgradeable {

    //initializer modifier ensures that the function below runs only once.
    function initialize() public initializer {
        __ERC20_init("Bibimbeat", "BBB");
        __Ownable_init();
        _mint(msg.sender, 1000000000 * 10 ** decimals());

    } 

    // function below is also not needed for normal trasnparent proxy
    // function _authorizeUpgrade(address newImplementation) internal override onlyOwner {
    // }
}

// contract BibimbeatERC20V2 is BibimbeatERC20 {
//     function version() pure public returns (string memory) {
//         return "V2!";
//     }
// }