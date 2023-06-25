// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTMarketplace is ERC721URIStorage{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    Counters.Counter private _itemsSold;

    uint256 listingPrice = 0.0025 ether;

    address payable owner;

    struct MarketItem
    {
        uint256 tokenId;
        address payable seller;
        
        address payable owner;
        uint256 price;

        bool sold;
    }

    mapping (uint256 => MarketItem) private idToMarketItem;
    
    constructor() ERC721("Web3 DAO Tokens","WDAO")
    {
        owner = payable(msg.sender);
    }

    function createToken(string memory tokenURI, uint256 price) public payable returns (uint256)
    {
        //Increment the token Id is important
        _tokenIds.increment();

        uint256 newTokenId = _tokenIds.current();

        _mint(msg.sender, newTokenId);

        // underscore mint calls from the ERC

        _setTokenURI(newTokenId, tokenURI);

        createMarketItem(newTokenId, price);

        return newTokenId;

    }

    // public, internal, external and private functions.
// token id and price
    function createMarketItem(uint256 tokenId, uint256 price) private 
    {
        require(price > 0, "price must be greater than 0");
        require(msg.value == listingPrice, "Price not equal to listing price");

        idToMarketItem[tokenId] = MarketItem(tokenId,payable(msg.sender),payable (address(this)),price,false);

        _transfer(msg.sender, address(this), tokenId);

    }

    function fetchMarketItems() public view returns (MarketItem[] memory) {
        uint itemCount = _tokenIds.current();
        uint unsoldItemCount = _tokenIds.current() - _itemsSold.current();
        uint currentIndex = 0;

        MarketItem[] memory items = new MarketItem[](unsoldItemCount);
        for (uint i = 0; i < itemCount; i++) {
            if (idToMarketItem[i + 1].owner == address(this)) {
                uint currentId = i + 1;

                MarketItem storage currentItem = idToMarketItem[currentId];

                items[currentIndex] = currentItem;

                currentIndex += 1;
            }
        }

        return items;
    }

    function getListingPrice() public view returns(uint256){
        return listingPrice;
    }


}