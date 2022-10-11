# YatDAO

- Token yDAO is ERC20.
- Supply: 21,000
- Mintable: yes
- Vesting: yes

npx hardhat node
npx hardhat run tasks/deploy.ts --network goerli 

## Deploy

```bash
npx hardhat run scripts/deployGYDAO.ts --network goerli
npx hardhat run scripts/deployEduDAO.ts --network goerli
```

## Contract
gYDAO: 0x53F2130E2F51b70aB875F68165F690142Ee94e15
EduDAO: 0x21fdcAd37a9CFd4d0a2af22908170d14EaF800e1

# TODO

- [] фабрика по созданию токенов для проектов с автоматическим отчислением в казну
- 