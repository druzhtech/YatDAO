// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract YatDAO {
  mapping(address => bool) members;
  mapping(address => bool) teachers;
  address owner;
  address gToken;

  mapping(bytes32 => Task) tasks;

  struct Task {
    bytes32 description;
    uint256 deadline;
    bool finished;
  }

  event NewMemberAdded(address indexed member);
  event TaskCreated(bytes32 description, uint256 deadline);

  constructor() {}

  modifier onlyMembers() {
    require(members[msg.sender] != false, '');
    _;
  }

  modifier onlyTeacher() {
    require(teachers[msg.sender] != false, '');
    _;
  }

  modifier onlyDAO() {
    require(msg.sender == owner, '');
    _;
  }

  function addMember(address member) public onlyDAO {
    // add teacher
    members[member] = true;
    emit NewMemberAdded(member);
  }

  // send ETH (v1), Stable(v2) and get DAO token for partitioate
  function buyDAOToken() public payable {
    members[msg.sender] = true;
  }

  // создание ДЗ
  function setTask(bytes32 description, uint256 deadline) public onlyMembers {
    bytes32 taskId = keccak256(abi.encodePacked(description, deadline));
    tasks[taskId] = Task(description, deadline, false);
    emit TaskCreated(description, deadline);
  }

  function finishTask(bytes32 taskId) public onlyTeacher {
    // check deadline
  }
}
