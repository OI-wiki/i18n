## Introduction

Iterative deepening search, abbreviated as IDS or IDDFS, is a depth-first search that **restricts the search depth each time**. 

The principle of IDS is still depth-first search, but a depth $d$ is also maintained during the search, and returns when $d$ reaches the depth set. This algorithm is generally used to find the optimal solution. If a search fails to find a legal solution, let the depth set increase by one and start the search from the root again.

Since the goal is to find the optimal solution, why not use BFS? We know that the basis of BFS is a queue, and the space complexity of queues are very large. When there are multiple states or a single state is relatively large, BFS with queue is disadvantageous. In fact, iterative deepening search is like a BFS implemented by DFS, and its space complexity is relatively small.

When the search tree has more branches, the time complexity of searching each additional layer will exponentially increase. At this time, the complexity caused by the previous repeated parts can be almost ignored, which is the reason why the iterative deepening search can be approximately seen as BFS.

## Steps

First we set a smaller depth as a global variable for DFS. Each time DFS is entered, the current depth $d++$ , and search returns when $d$ is greater than the set depth. If the answer is found during the search, we can start the backtrack, and record the path during the process. If no answer is found, go back to the function entry, increase the set depth, and continue searching.

## Code structure

```text
IDDFS(u,d)
    if d>set_depth
        return
    else
        for each edge (u,v)
            IDDFS(v,d+1)
  return
```

## Note

In most problems, breadth-first search is more convenient and easiser to check duplicates. However, when its space complexity is not good enough and the problem requires finding the optimal solution, iterativen deepening search should be considered.
