/* eslint-disable prettier/prettier */
import { expect } from 'chai';
import { ethers } from 'hardhat';

describe('EduDAO', function (): void {
  it('Should return ADMIN role', async function (): Promise<void> {
    const EduDAO = await ethers.getContractFactory('EduDAO');
    const eduDAO = await EduDAO.deploy();
    await eduDAO.deployed();

    const test = ethers.utils.formatBytes32String("gov");

    // expect(await eduDAO.testBytes32()).to.equal("gov");
    expect(await eduDAO.getRoleAdmin(ethers.utils.formatBytes32String("gov"))).to.equal(test);

    // const setGreetingTx = await eduDAO.setRoleAdmin('student', 'gov3');
    // // wait until the transaction is mined
    // await setGreetingTx.wait();
    // expect(await eduDAO.getRoleAdmin('student')).to.equal('gov4');
  });
});
