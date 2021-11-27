//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// Import helper functions
import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    // Keep track of tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Keep track of minted NFTs
    uint256 MAX_MINTS = 5;
    uint256 totalMinted = 0;

    // Make a baseSvg variable here that all our NFTs can use
    // SVGs will have a randomly generated word
    string svgPartOne = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='";
    string svgPartTwo = "'/><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    // Random arrays with their own theme of random words.
    string[] firstWords = ["Loving", "Wise", "Noxious", "Hulking", "Third", "Merciful", "Cloudy", "Taboo", "Four", "Royal", "Encouraging", "Mad", "Unfair", "Onerous", "Nappy"];
    string[] secondWords = ["Onion", "Vermicelli", "Kale", "Cream", "Passata", "Garlic", "Pepper", "Chorizo", "Chocolate", "Fish", "Tofu", "Panini", "Stew", "Leaf"];
    string[] thirdWords = ["Menu", "Atmosphere", "Vehicle", "Length", "Disease", "Worker", "Artisan", "Steak", "Hall", "Meat", "Payment", "Cluster", "Node", "Resource", "Database"];
    string[] colors = ["#ff0000", "#08C2A8", "#000000", "#ffff00", "#00e6e6", "#00df38"];

    event NewEpicNFTMinted(address sender, uint256 tokenId);

    // Sort of like ("Ethereum", "ETH')
    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("Epic NFT contract is working!");
    }

    // No actual source of randomness in the blockchain
    function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("Loving", Strings.toString(tokenId))));
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("Onion", Strings.toString(tokenId))));
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("Menu", Strings.toString(tokenId))));
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function pickRandomColor(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("COLOR", Strings.toString(tokenId))));
        rand = rand % colors.length;
        return colors[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function getMaxMints() public view returns (uint256) {
        return MAX_MINTS;
    }

    function getTotalMinted() public view returns (uint256) {
        return totalMinted;
    }

    // Function a user will hit to make/mint their NFT
    function makeAnEpicNFT() public {
        // Get the current token id, starting at 0
        uint256 newItemId = _tokenIds.current();

        require(totalMinted < MAX_MINTS, "Cannot mint anymore NFTs, limit reached!");

        // Randomly grab one word from each of the three arrays.
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);
        string memory combinedWord = string(abi.encodePacked(first, second, third));
        string memory randomColor = pickRandomColor(newItemId);

        // Concatenate the words and then close the <text> and <svg> tags.
        string memory finalSvg = string(abi.encodePacked(svgPartOne, randomColor, svgPartTwo, combinedWord, "</text></svg>"));
        
        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // We set the title of our NFT as the generated word.
                        combinedWord,
                        '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // Prepend data:application/json;base64, to our data.
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        // console.log("\n--------------------");
        // console.log(finalTokenUri);
        // console.log("--------------------\n");

        console.log("\n--------------------");
        console.log(
            string(
                abi.encodePacked(
                    "https://nftpreview.0xdev.codes/?code=",
                    finalTokenUri
                )
            )
        );
        console.log("--------------------\n");

        // Actually mint the NFT assigning it to the sender public address
        _safeMint(msg.sender, newItemId);

        // Set the NFT data
        _setTokenURI(newItemId, finalTokenUri);

        console.log(
            "An NFT with the ID of %s has been minted to %s",
            newItemId,
            msg.sender
        );

        // Increment the counter for when the next NFT is minted
        _tokenIds.increment();

        totalMinted++;

        emit NewEpicNFTMinted(msg.sender, newItemId);
    }
}
