/* eslint-disable prettier/prettier */
import { expect } from 'chai';
import { ethers } from 'hardhat';
import { ethers as Ethers } from 'ethers';
import { any } from "hardhat/internal/core/params/argumentTypes";

describe('EduDAO', function (): void {

  let eduDAO: any;
  let gYDAO: any;
  let account1: Ethers.Signer; // admin for all contracts
  let account2: Ethers.Signer; // token holder


  before(async function () {
    const [acc1, acc2] = await ethers.getSigners();
    account1 = acc1;
    account2 = acc2;

    const EDAO = await ethers.getContractFactory("EduDAO");
    eduDAO = await EDAO.deploy();
    console.log("EduDAO address: ", eduDAO.address);

    const GYDAO = await ethers.getContractFactory("gYDAO");
    gYDAO = await GYDAO.deploy();
    console.log("gYDAO address: ", gYDAO.address);

    const balanceOwner1 = await gYDAO.balanceOf(account1.getAddress());
    console.log("gYDAO balance owner: ", Number(balanceOwner1));

    // let approveTx = await gYDAO.connect(account1).approve(account1.getAddress(), 100);
    // await approveTx.wait();

    // let transferTx = await testErc20.connect(account_1).transfer(account_2.getAddress(), 100, {
    //   gasLimit: 30000000,
    //   gasPrice: 908478342,
    // });

    const mintTx = await gYDAO.connect(account1).mint(account1.getAddress(), 100);
    await mintTx.wait();

    const balanceOwner2 = await gYDAO.balanceOf(account1.getAddress());
    console.log("gYDAO balance owner: ", Number(balanceOwner2));

    console.log("\n");

  })

  // it('Should return ADMIN role', async function (): Promise<void> {
  //   // const EduDAO = await ethers.getContractFactory('EduDAO');
  //   // const eduDAO = await EduDAO.deploy();
  //   // await eduDAO.deployed();

  //   // const test = ethers.utils.formatBytes32String("gov");

  //   // // expect(await eduDAO.testBytes32()).to.equal("gov");
  //   // expect(await eduDAO.getRoleAdmin(ethers.utils.formatBytes32String("gov"))).to.equal(test);

  //   // const setGreetingTx = await eduDAO.setRoleAdmin('student', 'gov3');
  //   // // wait until the transaction is mined
  //   // await setGreetingTx.wait();
  //   // expect(await eduDAO.getRoleAdmin('student')).to.equal('gov4');
  // });

  it("Should transfer ERC20 tokens correctly", async function () {

    const approveTx = await gYDAO.connect(account1).approve(account1.getAddress(), 100);
    await approveTx.wait();

    const transferTx = await gYDAO.connect(account1).transfer(account2.getAddress(), 100, {
      gasLimit: 30000000,
      gasPrice: 908478342,
    });
    await transferTx.wait();

    const balanceAcc1 = await gYDAO.balanceOf(account1.getAddress())
    const balanceAcc2 = await gYDAO.balanceOf(account2.getAddress())
    
    expect(Number(balanceAcc1)).to.equal(21000000);
    expect(Number(balanceAcc2)).to.equal(100);
  });


  it("Should transfer token by addErc20Token function", async function () {

    console.log("step 1")

    const approveTx = await gYDAO.connect(account1).approve(eduDAO.address, 50);
    await approveTx.wait();

    const addErc20TokenTx = await eduDAO.connect(account1).addErc20Token(account2.getAddress(), gYDAO.address, 50, {
      gasLimit: 30000000,
      gasPrice: 908478342,
    });
    await addErc20TokenTx.wait();
    console.log("step 2")

    const account2Balance = await gYDAO.balanceOf(account2.getAddress());

    console.log("Account 2 --- gYDAO balance: ", Number(account2Balance));
  });
});
