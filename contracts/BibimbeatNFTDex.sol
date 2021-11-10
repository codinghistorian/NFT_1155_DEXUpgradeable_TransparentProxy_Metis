// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/IERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/IERC1155ReceiverUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/introspection/IERC165Upgradeable.sol";

// interface UpdateOwnedToken {
//    function updateOwnedTokenList(uint256 tokenId, uint256 amount, address newOwner, address oldOwner) external;
// }

contract BibimbeatNFTDex is IERC1155ReceiverUpgradeable, Initializable, OwnableUpgradeable{
     
     using SafeMathUpgradeable for uint256;
    
        struct Trade {
        address poster;
        address creator;
        uint256 item;
        uint256 amount;
        uint price;
        bytes32 status; // Open, Executed, Cancelled
    }
    
    mapping(uint256 => Trade) public trades;
    
    IERC20Upgradeable public currencyToken;
    IERC1155Upgradeable public itemToken;
    uint256 public tradeCounter;
    address public feeReceiver;
    

    event TradeStatusChange(uint256 tradeCounter, bytes32 status);
    event TradeLog(address poster, address creator, uint256 item, uint256 amount, uint price, bytes32 status, uint256 tradeCounter);
    
    // NFTs not minted not from our smart cotract should not pass
    
    function initialize(address _currencyTokenAddress, address _itemTokenAddress) public initializer {
        __Ownable_init();
        currencyToken = IERC20Upgradeable(_currencyTokenAddress);
        itemToken = IERC1155Upgradeable(_itemTokenAddress);
        tradeCounter = 0;
        feeReceiver = msg.sender;
    }
    

    //  Logged in EoA should be able to see tradeblock status of his MTs. mapping(eoa => tradeCounter[]);
    
    // when the trade is open, it should also adjust struct in MusicFactory.
    
    function openTrade(address _creator, uint256 _item, uint256 _price, uint _amount) public {
        require(itemToken.balanceOf(msg.sender, _item) >= _amount, "insufficient amount of NFT!");
        itemToken.safeTransferFrom(msg.sender, address(this), _item, _amount, "");
        trades[tradeCounter] = Trade(msg.sender, _creator, _item, _amount, _price, "OPEN");
        emit TradeLog(msg.sender, _creator, _item, _amount, _price, "OPEN", tradeCounter);
        tradeCounter++;
        emit TradeStatusChange(tradeCounter - 1, "OPEN");
    }
    
    function executeTrade(uint256 _tradeCounter, uint256 _amount) payable public {
        Trade memory trade = trades[_tradeCounter];
        require(trade.amount >= _amount, "insufficient amount of NFT!");
        require(trade.status == "OPEN", "Trade is not open.");
        
        uint256 totalPrice = trade.price.mul(_amount); // 200 * 450 = 90000
        
        uint256 creatorFee = totalPrice*25/1000; // 2250
        uint256 marketFee = totalPrice*25/1000; // 2250
        uint256 priceWithoutFee = totalPrice - (creatorFee + marketFee); // 90000 - 4500 = 85500
        
        currencyToken.transferFrom(msg.sender, trade.poster, priceWithoutFee);
        currencyToken.transferFrom(msg.sender, trade.creator, creatorFee);
        currencyToken.transferFrom(msg.sender, feeReceiver, marketFee);
        
        itemToken.safeTransferFrom(address(this), msg.sender, trade.item, _amount, "");
        if (trades[_tradeCounter].amount == _amount) {
            trades[_tradeCounter].status = "EXECUTED";
            emit TradeStatusChange(_tradeCounter, "EXECUTED");
        }
        else {
            trades[_tradeCounter].amount -= _amount;
            trades[_tradeCounter].status = "OPEN";
            emit TradeStatusChange(_tradeCounter, "OPEN");

        }
                
        // UpdateOwnedToken(factoryAddress).updateOwnedTokenList(trade.item, trade.amount, msg.sender, trade.poster);
        
    }
    
    //cancel trade should also shange state in Music Factory's amoutn state
    
    function cancelTrade(uint256 _tradeCounter) public {
        Trade memory trade = trades[_tradeCounter];
        require(msg.sender == trade.poster, "Trade can be cancelled only by poster.");
        require(trade.status == "OPEN", "Trade is not open.");
        itemToken.safeTransferFrom(address(this), trade.poster, trade.item, trade.amount, "");
        trades[_tradeCounter].status = "CANCELLED";
        emit TradeStatusChange(_tradeCounter, "CANCELLED");
    }
    
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IERC165Upgradeable).interfaceId;
    }
    
  function onERC1155Received(
    address operator,
    address from,
    uint256 id,
    uint256 value,
    bytes calldata data
    )
    external
    override
    returns(bytes4)
    {
      return   this.onERC1155Received.selector;
    }

function onERC1155BatchReceived(
    address operator,
    address from,
    uint256[] calldata ids,
    uint256[] calldata values,
    bytes calldata data
    )
    external
    override
    returns(bytes4)
    {
      return   this.onERC1155BatchReceived.selector;
    }
    
}