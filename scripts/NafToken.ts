import { ethers } from "hardhat";

async function main() {
  const totalSupply = 1000000; 
  const NafToken = await ethers.deployContract("NafToken", 1000000); 
  await NafToken.waitForDeployment();

  console.log(
    `NafToken contract deployed to ${NafToken.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
