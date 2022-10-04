import '@nomiclabs/hardhat-waffle';
import { ethers } from 'ethers';
import { task } from 'hardhat/config';
import { HardhatRuntimeEnvironment } from 'hardhat/types';

task('deploy', 'Deploy Greeter contract').setAction(
  async (_, hre: HardhatRuntimeEnvironment): Promise<void> => {

    const Greeter = await hre.ethers.getContractFactory('gEDAO');
    // @ts-ignore
    const greeter = await Greeter.deploy();
    await greeter.deployed();
    console.log('Greeter deployed to:', greeter.address);
  }
);
