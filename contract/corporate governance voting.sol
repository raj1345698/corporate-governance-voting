// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Decentralized Task Manager
 * @dev A simple contract that allows users to create and manage tasks on-chain.
 */
contract Project {
    struct Task {
        string description;
        bool completed;
        address owner;
    }

    Task[] public tasks;

    event TaskCreated(uint256 taskId, string description, address owner);
    event TaskCompleted(uint256 taskId);
    event TaskUpdated(uint256 taskId, string newDescription);

    /**
     * @notice Create a new task
     * @param _description description of the task
     */
    function createTask(string memory _description) external {
        tasks.push(Task(_description, false, msg.sender));
        emit TaskCreated(tasks.length - 1, _description, msg.sender);
    }

    /**
     * @notice Mark an owned task as completed
     * @param _taskId the ID of the task
     */
    function completeTask(uint256 _taskId) external {
        Task storage task = tasks[_taskId];
        require(msg.sender == task.owner, "Not task owner");
        task.completed = true;
        emit TaskCompleted(_taskId);
    }

    /**
     * @notice Update the description of an owned task
     * @param _taskId the ID of the task
     * @param _newDescription new description text
     */
    function updateTask(uint256 _taskId, string memory _newDescription) external {
        Task storage task = tasks[_taskId];
        require(msg.sender == task.owner, "Not task owner");
        task.description = _newDescription;
        emit TaskUpdated(_taskId, _newDescription);
    }

    /**
     * @notice Get total number of tasks
     */
    function getTaskCount() external view returns (uint256) {
        return tasks.length;
    }
}

