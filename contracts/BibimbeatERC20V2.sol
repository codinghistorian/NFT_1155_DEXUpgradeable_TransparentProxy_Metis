// SPDX-License-Identifier: MIT
// Openzeppelin 3.4.0
pragma solidity ^0.7.6;
// pragma solidity ^0.8.2;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./BibimbeatERC20.sol";


contract BibimbeatERC20V2 is BibimbeatERC20{
    function version() pure public returns (string memory) {
        return "V2!";
    }
}
