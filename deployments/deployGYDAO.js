/* eslint-disable node/no-unpublished-import */

const main = async () => {
  const [deployer] = await ethers.getSigners();

  console.log('deployer.address: ', deployer.address);
  const tokenFactory = await ethers.getContractFactory('GovernanceYDAO');
  const contract = await tokenFactory.deploy();

  console.log('contract address: ', contract.address);
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
