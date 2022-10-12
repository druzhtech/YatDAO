import { HardhatUserConfig } from 'hardhat/config';
import '@nomiclabs/hardhat-etherscan';
import '@nomiclabs/hardhat-waffle';
import '@typechain/hardhat';
import 'hardhat-gas-reporter';
import 'solidity-coverage';
import * as dotenv from 'dotenv';

import './tasks/deploy';

dotenv.config();

const privateKey = process.env.PRIVATE_KEY;
const endpoint = process.env.INFURA_GOERLI_URL;
const etherscanKey = process.env.ETHERSCAN_KEY;

const config: HardhatUserConfig = {
  solidity: {
    version: '0.8.4',
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000
      }
    }
  },
  paths: {
    artifacts: './frontend/src/artifacts'
  },
  networks: {
    hardhat: {
      mining: {
        auto: false,
        interval: 1000
      }
    },
    goerli: {
      url: endpoint,
      accounts: [`0x${privateKey}`],
      gas: 2100000,
      gasPrice: 8000000000,
      allowUnlimitedContractSize: true
    }
    // goerli: {
    //   url: process.env.GOERLI_URL || '',
    //   accounts:
    //     process.env.TEST_ETH_ACCOUNT_PRIVATE_KEY !== undefined
    //       ? [process.env.TEST_ETH_ACCOUNT_PRIVATE_KEY]
    //       : []
    // }
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: 'USD'
  },
  etherscan: {
    apiKey: etherscanKey
  }
};

export default config;
