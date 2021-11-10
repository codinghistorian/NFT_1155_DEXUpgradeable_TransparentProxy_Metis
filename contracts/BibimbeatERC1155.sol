// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

contract BibimbeatERC1155 is Initializable, ERC1155Upgradeable, OwnableUpgradeable {
    
    using CountersUpgradeable for CountersUpgradeable.Counter;
    
    CountersUpgradeable.Counter public tokenId;
	event AddMintedMusic(uint256 tokenId, address account, uint256 amount, string uri); 
    mapping(uint256 => bytes) URIs;

   function initialize() initializer public {
        __ERC1155_init("");
        __Ownable_init();
        tokenId.increment();
    }

    //@Dev this line of code is to make sure that this ERC1155 is opensea compatible.
    function uri(uint256 _tokenId) override public view returns (string memory) {
    return string(URIs[_tokenId]);
    }

    function mintMusic(uint256 _amount, string memory _uri) public {
        bytes memory tokenUri = bytes(_uri);
        _mint(msg.sender, tokenId.current(), _amount, tokenUri);
        URIs[tokenId.current()] = tokenUri;
        emit AddMintedMusic(tokenId.current(), msg.sender, _amount, _uri); 
        tokenId.increment();
    }
    //@Dev this line of code is for our Web. Will be ommited when we launch our service. 
    //but for sake of not spending time changing our front-end, this function will be here.
    //Omit 211109 19:36
 //   function getTokenURI(uint256 _tokenId) public view returns(bytes memory) {
 //       return URIs[_tokenId];
 //   }
}
