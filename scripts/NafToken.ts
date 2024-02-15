import { ethers } from "hardhat";

async function main() {
    
  const NafToken = await ethers.deployContract("NafToken"); 
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
