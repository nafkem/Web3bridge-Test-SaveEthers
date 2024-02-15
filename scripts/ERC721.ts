import { ethers } from "hardhat";

async function main() {
  const totalSupply = 1000000; 
  const ERC721 = await ethers.deployContract("ERC721", 1000000); 
  await ERC721.waitForDeployment();

  console.log(
    `ERC721 contract deployed to ${ERC721.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
