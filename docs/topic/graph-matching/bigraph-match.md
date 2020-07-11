author: accelsao

# Maximum Bipartite Matching

A **matching** of a graph is a subset of edges such that no two edges share a vertex. A **maximum matching** of a graph is a matching with the maximum number of edges (matching as many vertices as possible).  

For the convenience of description, we assume ( $n$ vertices and $m$ edges, and a set $M$ if no two edges in $M$ have a common vertex) and partition the graph into two disjoint sets - left and right. All matching edges connects to both left and right sets. One common example of bipartite graph matching is matching a group of men and women.

## Augmenting Path Algorithm

Because the length of augmenting path is odd, and the starting vertex of the path is either on the left or right, we first consider finding the augmenting path from the unmatched vertices on the left.

Please note that because of the [alternating path](./augment.md), the odd-numbered edges on the augmenting path are all unmatched edges, and the even-numbered edges are all matched edges. So left-to-right edges are all unmatched, and right-to-left edges are all matched.

So we define the **direction** for the bipartite graph, and the problem is converted to finding a directed path starting from a given vertex to an unmatched vertex in a directed graph, which is actually equivalent to whether the given starting vertex $s$ can reach the ending vertex $t$.

This means that we can just do the DFS traversal from the starting vertex until a certain unmatched vertex is found. The time complexity for this step is $O(m)$ .

When the augmenting path has not been found, the path formed was called an **alternating tree**.

> **alternating tree**: a tree whose root is an unmatched vertex. All root-to-leaf paths in an alternating tree are alternating paths with respect to $M$ . If we can add an unmatched vertex other than the root vertex to an alternating tree, we have found an augmenting path.

Because we want to enumerate $n$ points, the overall time complexity is $O(nm)$ .

### Code

```cpp
struct augment_path {
  vector<vector<int> > g;
  vector<int> pa;  // pair
  vector<int> pb;
  vector<int> vis;  // visit
  int n, m;         // number of vertices and edges
  int dfn;          // time stamp
  int res;          // result: number of matched paris

  augment_path(int _n, int _m) : n(_n), m(_m) {
    assert(0 <= n && 0 <= m);
    pa = vector<int>(n, -1);
    pb = vector<int>(m, -1);
    vis = vector<int>(n);
    g.resize(n);
    res = 0;
    dfn = 0;
  }

  void add(int from, int to) {
    assert(0 <= from && from < n && 0 <= to && to < m);
    g[from].push_back(to);
  }

  bool dfs(int v) {
    vis[v] = dfn;
    for (int u : g[v]) {
      if (pb[u] == -1) {
        pb[u] = v;
        pa[v] = u;
        return true;
      }
    }
    for (int u : g[v]) {
      if (vis[pb[u]] != dfn && dfs(pb[u])) {
        pa[v] = u;
        pb[u] = v;
        return true;
      }
    }
    return false;
  }

  int solve() {
    while (true) {
      dfn++;
      int cnt = 0;
      for (int i = 0; i < n; i++) {
        if (pa[i] == -1 && dfs(i)) {
          cnt++;
        }
      }
      if (cnt == 0) {
        break;
      }
      res += cnt;
    }
    return res;
  }
};
```

## Dinic's algorithm

Bipartite graph maximum matching can be converted into the flow network model. The **Dinic's algorithm** can also be used to compute the maximum flow in a network.

Connect all vertices on the left to the source vertex, and all points on the right to the sink vertex. The capacity is $1$ . Each original edge is connected from left to right, and the capacity is also $1$ . The maximum flow is the maximum match, which can be found in $O(\sqrt{n}m)$ .

Dinic's algorithm contains two parts. The first part uses BFS to construct network flow in $O(m)$ time complexity; The second part performs DFS for augmentation in $O(nm)$ time complexity.

But because the capacity is $1$ , the actual time complexity is $O(m)$ .

Next, for the first $O(\sqrt{n})$ rounds, the time complexity is $O(\sqrt{n}m)$ . After $O(\sqrt{n})$ rounds, the length of each augmenting path is at least $\sqrt{n}$ , and such path does not exceed $\sqrt{n}$ .

So it only needs to run $\sqrt{n}$ rounds. The overall time complexity is $O(\sqrt{n}m)$ .

### Code

TBC.

## Additional information

### Maximum independent set in bipartite graph

Choose the maximum vertices to satisfy the requirement that there are no connected edges between each other.

In bipartite graphs, the maximum independent set = $n$ - maximum matching.

### Minimum vertex cover in bipartite graph

Choose the minimum vertices to satisfy the requirement that at least one endpoint of each edge is selected. It is not difficult to find that the complement set is an independent set.

In bipartite graphs, the minimum vertex cover = $n$ - maximum independent set.

## Practice problems

??? note "[UOJ #78. Bipartite graph maximum matching(original link in Chinese)](https://uoj.ac/problem/78) "

    Template problems
    ```cpp
    #include <bits/stdc++.h>
    using namespace std;

    struct augment_path {
      vector< vector<int> > g;
      vector<int> pa; // pair
      vector<int> pb;
      vector<int> vis; // visited
      int n, m; // number of vertices
      int dfn; // time stamp
      int res; // result: number of matched pairs

      augment_path(int _n, int _m) : n(_n), m(_m) {
      assert(0 <= n && 0 <= m);
      pa = vector<int> (n, -1);
      pb = vector<int> (m, -1);
      vis = vector<int> (n);
      g.resize(n);
      res = 0;
      dfn = 0;
      }

      void add(int from, int to) {
      assert(0 <= from && from < n && 0 <= to && to < m);
      g[from].push_back(to);
      }

      bool dfs(int v) {
      vis[v] = dfn;
      for(int u: g[v]) {
        if(pb[u] == -1) {
        pb[u] = v;
        pa[v]= u;
        return true;
        }
      }
      for(int u: g[v]) {
        if(vis[pb[u]] != dfn && dfs(pb[u])) {
        pa[v] = u;
        pb[u] = v;
        return true;
        }
      }
      return false;
      }

      int solve() {
      while(true) {
        dfn++;
        int cnt = 0;
        for(int i = 0; i < n; i++) {
        if(pa[i] == -1 && dfs(i)) {
          cnt++;
        }
        }
        if(cnt == 0) {
        break;
        }
        res += cnt;
      }
      return res;
      }
    };

    int main(){
      int n, m, e;
      cin >> n >> m >> e;
      augment_path solver(n, m);
      int u, v;
      for(int i = 0; i < e; i++){
      cin >> u >> v;
      u--, v--;
      solver.add(u, v);
      }
      cout << solver.solve() << "\n";
      for(int i = 0; i < n; i++) {
      cout << solver.pa[i] + 1 << " ";
      }
      cout << "\n";
    }

    ```

??? note "[P1640 [SCOI2010]Continuous attack game](https://www.luogu.com.cn/problem/P1640) (original link in Chinese)"

    None

??? note "[Codeforces 1139E - Maximize Mex](https://codeforces.com/problemset/problem/1139/E) "

    None
