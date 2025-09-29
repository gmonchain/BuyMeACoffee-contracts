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
  const [owner] = await hre.ethers.getSigners();

  console.log("Current owner:", await buyMeACoffee.owner());

  // To transfer ownership to a new address (replace NEW_OWNER_ADDRESS):
  // const newOwnerAddress = "NEW_OWNER_ADDRESS";
  // const transferTx = await buyMeACoffee.connect(owner).updateOwner(newOwnerAddress);
  // await transferTx.wait();
  // console.log(`Ownership transferred to ${newOwnerAddress}`);

  console.log("New owner (after potential transfer):", await buyMeACoffee.owner());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
