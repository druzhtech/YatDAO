// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import '@openzeppelin/contracts/access/AccessControlEnumerable.sol';
import '@openzeppelin/contracts/access/AccessControl.sol';
import '@openzeppelin/contracts/access/IAccessControl.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract EduDAO is AccessControlEnumerable {
  // TODO: проверить на возможность использования eтгь как типа участника в EnmerableSet

  enum Roles {
    Student,
    Teacher,
    Governance
  }

  struct Participant {
    bytes32[] set; // студ.групп, команда проекта, сообщество
    Roles[] roles;
  }

  mapping(address => Participant) participants;
  uint256[] participantIdx;

  event ParticipantAdded(address indexed who, bytes32[] set, Roles[] role);

  event Erc20TokenSended(address recipient, address token, uint256 amount);

  struct Task {
    bytes32 task_name;
    bytes32 task_type;
    bytes32 task_deadline;
    uint256 task_tokenAmount;
    bytes32 participant_set;
    bytes32 tasl_category;
    bytes32 type_participant;
    bool requiremtnts;
  }

  mapping(uint256 => Task) tasks;

  uint256[] taskIds;

  event TaskCreated(uint256 index, bytes32 task_name);

  constructor() {
    super._setupRole('gov', msg.sender);
    super._setRoleAdmin('gov', 'gov'); // TODO: протестировать перевод типа из enym, в инеуы32
    // taskIds[0] = 1;
  }

  function getRoleMember(bytes32 role, uint256 index)
    public
    view
    virtual
    override
    returns (address)
  {
    return super.getRoleMember(role, index);
  }

  function getRoleMemberCount(bytes32 role)
    public
    view
    virtual
    override
    returns (uint256)
  {
    return super.getRoleMemberCount(role);
  }

  function setRole(bytes32 role, address account) public onlyRole('gov') {
    super._grantRole(role, account);
  }

  function deleteRole(bytes32 role, address account) public onlyRole('gov') {
    super._revokeRole(role, account);
  }

  function setRoleAdmin(bytes32 role, bytes32 adminRole)
    public
    onlyRole('gov')
  {
    super._setRoleAdmin(role, adminRole);
  }

  // название
  // типа задания: edu, dev
  // срок сдачи
  // сколько токенов
  // группа
  // категории
  // тип участия
  // обязательно или нет

  function createTask(
    bytes32 task_name,
    bytes32 task_type,
    bytes32 task_deadline,
    uint256 task_tokenAmount,
    bytes32 participant_set,
    bytes32 task_category,
    bytes32 type_participant,
    bool requiremtnts
  ) public {
    Task memory ts = Task(
      task_name,
      task_type,
      task_deadline,
      task_tokenAmount,
      participant_set,
      task_category,
      type_participant,
      requiremtnts
    );

    uint256 tskIndx = taskIds.length + 1;
    tasks[tskIndx] = ts; // TODO: создать перечисление (index)

    emit TaskCreated(tskIndx, task_name);
  }

  function addParticipant(
    address participant_addr,
    bytes32[] memory set,
    Roles[] memory role
  ) public onlyRole('gov') {
    Participant memory part = Participant(set, role);
    participants[participant_addr] = part;

    emit ParticipantAdded(participant_addr, set, role);
  }

  function getParticipants() public returns (Participant[] memory parts){

  }

  function addErc20Token(
    address recipient,
    address _token,
    uint256 amount
  ) public onlyRole('gov') {
    require(address(_token) != address(0x0), "Address of token can't be 0x0");
    require(
      address(recipient) != address(0x0),
      "Address of recipient can't be 0x0"
    );
    ERC20 token = ERC20(_token);
    require(token.balanceOf(msg.sender) >= amount, 'No such amount');

    bool isApproved = token.approve(address(this), amount);

    if (isApproved) {
      bool sended = token.transferFrom(msg.sender, recipient, amount);

      if (sended) {
        emit Erc20TokenSended(recipient, _token, amount);
      }
    }
  }
}
