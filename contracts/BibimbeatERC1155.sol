// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

contract BibimbeatERC1155 is Initializable, ERC1155Upgradeable, OwnableUpgradeable {
    
    using CountersUpgradeable for CountersUpgradeable.Counter;
    
    CountersUpgradeable.Counter public tokenId;

    mapping(uint256 => bytes) URIs;

   function initialize() initializer public {
        __ERC1155_init("");
        __Ownable_init();
        tokenId.increment();
    }
    // the function below is Bibimbeat way of minting and storing URI for each ID.
    // would be readjusted for Opensea compatibiliity.
    // Method we will be using is on the link below
    // https://soenkeba.medium.com/truly-decentralized-nfts-by-erc-1155-b9be28db2aae
    function mintMusic(uint256 _amount, string memory _uri) public {
        bytes memory tokenUri = bytes(_uri);
        _mint(msg.sender, tokenId.current(), _amount, tokenUri);
        URIs[tokenId.current()] = tokenUri;
        tokenId.increment();
    }

    // Maybe this code is redundant  .. I think it can possibly already exist in ERC1155 standard functions.
    // well.. obviously not. If it was ERC721, yes. but this is ERC1155. So it's good for our model at the moment.
    function getTokenURI(uint256 tokenIdThatYouWantToQueryFrom) public view returns(bytes memory uri) {
        uri = URIs[tokenIdThatYouWantToQueryFrom];
    }
}