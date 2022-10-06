// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import '@openzeppelin/contracts/access/AccessControlEnumerable.sol';
import '@openzeppelin/contracts/access/AccessControl.sol';
import '@openzeppelin/contracts/access/IAccessControl.sol';

contract EduDAO is AccessControlEnumerable {
  // TODO: проверить на возможность использования eтгь как типа участника в EnmerableSet
  enum Roles {
    Student,
    Teacher,
    Governance
  }

  struct Participant {
    address acc; // зачем адрес
    bytes32[] set; // студ.групп, команда проекта, сообщество
  }
  mapping(address => Participant) participants;

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
  mapping(bytes32 => Task) tasks;

  constructor() {
    super._setRoleAdmin('gov', 'gov'); // TODO: протестировать конструктор + протестировать перевод типа из enym, в инеуы32
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
    internal
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

    tasks[] = ts; // TODO: создать перечисление (index)
  }
}
