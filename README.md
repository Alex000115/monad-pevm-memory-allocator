# Monad Parallel EVM Memory Arena Allocator

In massive multi-threaded runtime environments like **Monad**, thread contention during dynamic heap allocations can degrade overall throughput. Traditional memory allocation strategies rely on centralized thread locks to manage heap regions. When multiple parallel EVM workers attempt to allocate memory for temporary variables simultaneously, lock contention introduces severe processing bottlenecks.

This repository features an advanced reference framework for a **Thread-Isolated Memory Arena Allocator**. By instantiating pre-allocated, separate memory spaces for each active hardware worker thread, this architecture allows concurrent execution channels to secure memory arenas instantly without global thread locks, maximizing transaction processing speeds.

## Engineering Topography
- **Thread-Isolated Arenas:** Allocates independent memory pools to execution threads to eliminate global lock contention.
- **Microsecond Deallocation Passes:** Implements pointer-reset garbage collection to clear transient worker memory instantly between blocks.

## Quick Start
1. Install project dependencies: `npm install`
2. Configure worker threshold metrics and memory limits inside `.env`.
3. Launch the high-concurrency arena allocator simulation: `node testArenaAllocation.js`
