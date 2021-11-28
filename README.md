# Epic NFTs Contract

This project uses Hardhat to create a **Solitidy** contract to be later deployed to a **blockchain**.

You can check a sample [deployed contract here!](https://rinkeby.etherscan.io/address/0x188358414f296530692127399a1e8f134d213bdd)

<div align="center">

![](/media/testnet-etherscan.JPG)

</div>

You can test the contract locally with:
```BASH
npm start
```

Once you're ready for deployment, add a `.env` following the example and deploy to **testnet**.
```
npm run deploy-rinkeby
```

You can also create your own deployments scripts if you wish to deploy to **mainnet**, just beware of **GAS fees**.