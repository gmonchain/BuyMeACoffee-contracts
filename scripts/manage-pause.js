const hre = require("hardhat");

async function getContract() {
  const BuyMeACoffee = await hre.ethers.getContractFactory("BuyMeACoffee");
  const buyMeACoffee = await BuyMeACoffee.attach(
    "YOUR_DEPLOYED_CONTRACT_ADDRESS" // TODO: Replace with your deployed contract address
  );
  return buyMeACoffee;
}

async function main() {
  const buyMeACoffee = await getContract();

  console.log("Current paused status:", await buyMeACoffee.paused());

  // To pause the contract:
  // const pauseTx = await buyMeACoffee.pause();
  // await pauseTx.wait();
  // console.log("Contract paused.");

  // To unpause the contract:
  // const unpauseTx = await buyMeACoffee.unpause();
  // await unpauseTx.wait();
  // console.log("Contract unpaused.");

  console.log("New paused status:", await buyMeACoffee.paused());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
