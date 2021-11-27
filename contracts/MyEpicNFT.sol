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
        _setTokenURI(
            newItemId,
            "data:application/json;base64,ewogICAgIm5hbWUiOiAiU3RhbmRhcmRQaXp6YUhvbWllIiwKICAgICJkZXNjcmlwdGlvbiI6ICJBbiBORlQgZnJvbSB0aGUgaGlnaGx5IGFjY2xhaW1lZCBzcXVhcmUgY29sbGVjdGlvbiIsCiAgICAiaW1hZ2UiOiAiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpSUhCeVpYTmxjblpsUVhOd1pXTjBVbUYwYVc4OUluaE5hVzVaVFdsdUlHMWxaWFFpSUhacFpYZENiM2c5SWpBZ01DQXpOVEFnTXpVd0lqNEtJQ0FnSUR4emRIbHNaVDR1WW1GelpTQjdJR1pwYkd3NklIZG9hWFJsT3lCbWIyNTBMV1poYldsc2VUb2djMlZ5YVdZN0lHWnZiblF0YzJsNlpUb2dNVFJ3ZURzZ2ZUd3ZjM1I1YkdVK0NpQWdJQ0E4Y21WamRDQjNhV1IwYUQwaU1UQXdKU0lnYUdWcFoyaDBQU0l4TURBbElpQm1hV3hzUFNKaWJHRmpheUlnTHo0S0lDQWdJRHgwWlhoMElIZzlJalV3SlNJZ2VUMGlOVEFsSWlCamJHRnpjejBpWW1GelpTSWdaRzl0YVc1aGJuUXRZbUZ6Wld4cGJtVTlJbTFwWkdSc1pTSWdkR1Y0ZEMxaGJtTm9iM0k5SW0xcFpHUnNaU0krVTNSaGJtUmhjbVJRYVhwNllVaHZiV2xsUEM5MFpYaDBQZ284TDNOMlp6ND0iCn0="
        );

        console.log(
            "An NFT with the ID of %s has been minted to %s",
            newItemId,
            msg.sender
        );

        // Increment the counter for when the next NFT is minted
        _tokenIds.increment();
    }
}
