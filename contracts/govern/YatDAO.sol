// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts-upgradeable/governance/GovernorUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/governance/extensions/GovernorSettingsUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/governance/compatibility/GovernorCompatibilityBravoUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/governance/extensions/GovernorVotesUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/governance/extensions/GovernorTimelockControlUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol';

contract YatDAOGovern is
  Initializable,
  GovernorUpgradeable,
  GovernorSettingsUpgradeable,
  GovernorCompatibilityBravoUpgradeable,
  GovernorVotesUpgradeable,
  GovernorTimelockControlUpgradeable,
  OwnableUpgradeable,
  UUPSUpgradeable
{
  /// @custom:oz-upgrades-unsafe-allow constructor
  constructor() {
    _disableInitializers();
  }

  function initialize(
    IVotesUpgradeable _token,
    TimelockControllerUpgradeable _timelock
  ) public initializer {
    __Governor_init('YatDAO');
    __GovernorSettings_init(1 /* 1 block */, 45818 /* 1 week */, 0);
    __GovernorCompatibilityBravo_init();
    __GovernorVotes_init(_token);
    __GovernorTimelockControl_init(_timelock);
    __Ownable_init();
    __UUPSUpgradeable_init();
  }

  function quorum(uint256 blockNumber) public pure override returns (uint256) {
    return 3e18;
  }

  function _authorizeUpgrade(
    address newImplementation
  ) internal override onlyOwner {}

  // The following functions are overrides required by Solidity.

  function votingDelay()
    public
    view
    override(IGovernorUpgradeable, GovernorSettingsUpgradeable)
    returns (uint256)
  {
    return super.votingDelay();
  }

  function votingPeriod()
    public
    view
    override(IGovernorUpgradeable, GovernorSettingsUpgradeable)
    returns (uint256)
  {
    return super.votingPeriod();
  }

  function state(
    uint256 proposalId
  )
    public
    view
    override(
      GovernorUpgradeable,
      IGovernorUpgradeable,
      GovernorTimelockControlUpgradeable
    )
    returns (ProposalState)
  {
    return super.state(proposalId);
  }

  function propose(
    address[] memory targets,
    uint256[] memory values,
    bytes[] memory calldatas,
    string memory description
  )
    public
    override(
      GovernorUpgradeable,
      GovernorCompatibilityBravoUpgradeable,
      IGovernorUpgradeable
    )
    returns (uint256)
  {
    return super.propose(targets, values, calldatas, description);
  }

  function proposalThreshold()
    public
    view
    override(GovernorUpgradeable, GovernorSettingsUpgradeable)
    returns (uint256)
  {
    return super.proposalThreshold();
  }

  function _execute(
    uint256 proposalId,
    address[] memory targets,
    uint256[] memory values,
    bytes[] memory calldatas,
    bytes32 descriptionHash
  ) internal override(GovernorUpgradeable, GovernorTimelockControlUpgradeable) {
    super._execute(proposalId, targets, values, calldatas, descriptionHash);
  }

  function _cancel(
    address[] memory targets,
    uint256[] memory values,
    bytes[] memory calldatas,
    bytes32 descriptionHash
  )
    internal
    override(GovernorUpgradeable, GovernorTimelockControlUpgradeable)
    returns (uint256)
  {
    return super._cancel(targets, values, calldatas, descriptionHash);
  }

  function _executor()
    internal
    view
    override(GovernorUpgradeable, GovernorTimelockControlUpgradeable)
    returns (address)
  {
    return super._executor();
  }

  function supportsInterface(
    bytes4 interfaceId
  )
    public
    view
    override(
      GovernorUpgradeable,
      IERC165Upgradeable,
      GovernorTimelockControlUpgradeable
    )
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }
}
