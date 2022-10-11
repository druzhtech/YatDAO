import '@nomiclabs/hardhat-waffle';
import { task } from 'hardhat/config';
import { HardhatRuntimeEnvironment } from 'hardhat/types';

task('deploy', 'Deploy gYDAO contract').setAction(
  async (_, hre: HardhatRuntimeEnvironment): Promise<void> => {
    const GYDAO = await hre.ethers.getContractFactory('gYDAO');
    // @ts-ignore
    const gYDAO = await GYDAO.deploy();
    await gYDAO.deployed();
    console.log('gYDAO deployed to:', gYDAO.address);
  }
);

task('deploy', 'Deploy EduDAO contract').setAction(
  async (_, hre: HardhatRuntimeEnvironment): Promise<void> => {
    const EDAO = await hre.ethers.getContractFactory('EduDAO');
    // @ts-ignore
    const eDAO = await EDAO.deploy();
    await eDAO.deployed();
    console.log('eDAO deployed to:', eDAO.address);
  }
);
