// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ArenaCheckpointAnchor
 * @dev On-chain contract tracking infrastructure metrics regarding maximum memory consumption targets.
 */
contract ArenaCheckpointAnchor is Ownable {

    struct AllocationCheckpoint {
        uint256 totalAllocatedBytes;
        uint256 committedBlockHeight;
    }

    mapping(uint256 => AllocationCheckpoint) public internalAllocationLogs;
    address public infrastructureManager;

    event MemoryCheckpointLogged(uint256 indexed laneId, uint256 bytesAllocated, uint256 blockHeight);

    constructor() Ownable(msg.sender) {
        infrastructureManager = msg.sender;
    }

    /**
     * @notice Registers verified off-chain memory consumption parameters for auditing layers.
     */
    function recordMemoryUsage(uint256 laneId, uint256 bytesAllocated) external {
        require(msg.sender == infrastructureManager, "AuthError: Caller identity matches no whitelisted relayer nodes");
        
        internalAllocationLogs[laneId] = AllocationCheckpoint({
            totalAllocatedBytes: bytesAllocated,
            committedBlockHeight: block.number
        });

        emit MemoryCheckpointLogged(laneId, bytesAllocated, block.number);
    }
}
