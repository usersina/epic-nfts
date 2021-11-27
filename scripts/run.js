const main = async () => {
  // Compile the .sol contract
  const nftContractFactory = await hre.ethers.getContractFactory('MyEpicNFT');

  // Create a local Ethereum network (blockchain) specific to the contract
  const nftContract = await nftContractFactory.deploy();

  // Wait for the contract to be mined and deployed to the blockchain
  await nftContract.deployed();

  console.log('Contract deployed to:', nftContract.address);
};

(async () => {
  try {
    await main();
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
})();
