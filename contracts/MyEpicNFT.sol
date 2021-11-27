//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
    // Keep track of tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Sort of like ("Ethereum", "ETH')
    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("Epic NFT contract is working!");
    }

    // Function a user will hit to make/mint their NFT
    function makeAnEpicNFT() public {
        // Get the current token id, starting at 0
        uint256 newItemId = _tokenIds.current();

        // Actually mint the NFT assigning it to the sender public address
        _safeMint(msg.sender, newItemId);

        // Set the NFT data
        _setTokenURI(newItemId, "https://jsonkeeper.com/b/3UIV");

        console.log(
            "An NFT with the ID of %s has been minted to %s",
            newItemId,
            msg.sender
        );

        // Increment the counter for when the next NFT is minted
        _tokenIds.increment();
    }
}
