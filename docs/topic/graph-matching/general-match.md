author: accelsao

# Maximum matching in general graphs

## Blossom Algorithm

**Blossom Algorithm** can solve the maximum matching problem（[maximum cardinality matching](https://en.wikipedia.org/wiki/Matching_(graph_theory)#Maximum-cardinality_matching)) in general graphs. This algorithm was proposed by Jack Edmonds in 1961.

After some modifications, it can also be used to solve the maximum weight matching of general graphs.

This algorithm is the first confirmation to prove that maximum matching has multiple complexity.

The difference between general graph matching and bipartite matching is that there may exist odd cycle.

Taking this graph as an example, if directly inverted (swap matched edge and unmatched edge), it will make the inverted $M$ illegal, and some nodes will appear in both matching. The reason for this to happen is the odd cycle.

Now, consider the augmenting algorithm for general graphs.

For bipartite graph, each time an unmatched node is enumerated, set the starting node as the root, labeled with **"o"**. Then label **"o"** and **"i"**. It is not hard to notice that the edges from **"i"** to **"o"** are matching edge.

Assume the current node is $v$ , and the adjacent node is $u$ .

case 1: $u$ has never been visited. When $u$ is the unmatched node, find the augmenting path, otherwise find the augmenting path from the matching of $u$ .

case 2: $u$ has been visited. Marked "o" means the need to **shrink blossom**, otherwise it means the odd cycle, skip.


In the case of an even cycle, treat it as a bipartite graph, so it can be ignored. After **shrinking blossom**, continue to find augmenting path in the new graph.

![general-matching-2](./images/general-matching-2.png)

Suppose the original graph is $G$ , and the graph after **shrinking blossom** is $G$ , we only need to prove:

1.  If $G$ has augmenting path, then $G'$ also has.
2.  If $G'$ has augmenting path, then $G$ also has.

![general-matching-3](./images/general-matching-3.png)

Let the non-tree edge (the edge forming the cycle) be $(u,v)$ and define the blossom root $h=LCA(u,v)$ .

Odd cycles are alternating, and the two adjacent edges with only $h$ are of the same type and are both non-matching edges.

Then the tree edge entering $h$ must be a matching edge. The edges out of the cycle other than $h$ are all non-matching edges.

Based on observation, it shows that there are two cases of starting from the edge that is out of the ring, clockwise or counterclockwise.

![general-matching-4](./images/general-matching-4.png)

So **shrink blossom** and **NOT shrink blossom** does not affect the correctness.

In fact, after finding the **blossom** we do not actually need to **shrink blossom**. We can use array to keep track of which node is in the blossom that has itself as the root.

### Time Complexity Analysis

Each time finding augmenting path, traversing all edges, maintaing the nodes on the **blossom**, would take $O(|E|^2)$ .

Enumerating all unmatched nodes to find augmenting path would take overall $O(|V||E|^2)$ .

### Code

```cpp
// graph
template <typename T>
class graph {
 public:
  struct edge {
    int from;
    int to;
    T cost;
  };
  vector<edge> edges;
  vector<vector<int> > g;
  int n;
  graph(int _n) : n(_n) { g.resize(n); }
  virtual int add(int from, int to, T cost) = 0;
};

// undirectedgraph
template <typename T>
class undirectedgraph : public graph<T> {
 public:
  using graph<T>::edges;
  using graph<T>::g;
  using graph<T>::n;

  undirectedgraph(int _n) : graph<T>(_n) {}
  int add(int from, int to, T cost = 1) {
    assert(0 <= from && from < n && 0 <= to && to < n);
    int id = (int)edges.size();
    g[from].push_back(id);
    g[to].push_back(id);
    edges.push_back({from, to, cost});
    return id;
  }
};

// blossom / find_max_unweighted_matching
template <typename T>
vector<int> find_max_unweighted_matching(const undirectedgraph<T> &g) {
  std::mt19937 rng(chrono::steady_clock::now().time_since_epoch().count());
  vector<int> match(g.n, -1);   // matching
  vector<int> aux(g.n, -1);     // time stamp
  vector<int> label(g.n);       // "o" or "i"
  vector<int> orig(g.n);        // original node
  vector<int> parent(g.n, -1);  // parent node
  queue<int> q;
  int aux_time = -1;

  auto lca = [&](int v, int u) {
    aux_time++;
    while (true) {
      if (v != -1) {
        if (aux[v] == aux_time) {  // find the node visited, that is, LCA
          return v;
        }
        aux[v] = aux_time;
        if (match[v] == -1) {
          v = -1;
        } else {
          v = orig[parent[match[v]]];  // continue searching using the matched parent node
        }
      }
      swap(v, u);
    }
  };  // lca

  auto blossom = [&](int v, int u, int a) {
    while (orig[v] != a) {
      parent[v] = u;
      u = match[v];
      if (label[u] == 1) {  // set the source node as "o" to find an augmenting path
        label[u] = 0;
        q.push(u);
      }
      orig[v] = orig[u] = a;  // shrink blossom
      v = parent[u];
    }
  };  // blossom

  auto augment = [&](int v) {
    while (v != -1) {
      int pv = parent[v];
      int next_v = match[pv];
      match[v] = pv;
      match[pv] = v;
      v = next_v;
    }
  };  // augment

  auto bfs = [&](int root) {
    fill(label.begin(), label.end(), -1);
    iota(orig.begin(), orig.end(), 0);
    while (!q.empty()) {
      q.pop();
    }
    q.push(root);
    // set the source node as "o", replacing "o" with "0 and "i" with "1"
    label[root] = 0;
    while (!q.empty()) {
      int v = q.front();
      q.pop();
      for (int id : g.g[v]) {
        auto &e = g.edges[id];
        int u = e.from ^ e.to ^ v;
        if (label[u] == -1) {  // find unvisited node
          label[u] = 1;        // label "i"
          parent[u] = v;
          if (match[u] == -1) {  // find unmatched node
            augment(u);          // find augmenting path
            return true;
          }
          // find matched node and push its matching node in the queue, extending alternating tree
          label[match[u]] = 0;
          q.push(match[u]);
          continue;
        } else if (label[u] == 0 && orig[v] != orig[u]) {
          // find visited node & the label is also "o", meaning the "blossom" has been found
          int a = lca(orig[v], orig[u]);
          // find LCA, then shrink blossom
          blossom(u, v, a);
          blossom(v, u, a);
        }
      }
    }
    return false;
  };  // bfs

  auto greedy = [&]() {
    vector<int> order(g.n);
    // randomize order
    iota(order.begin(), order.end(), 0);
    shuffle(order.begin(), order.end(), rng);

    // matched vertices that can be matched
    for (int i : order) {
      if (match[i] == -1) {
        for (auto id : g.g[i]) {
          auto &e = g.edges[id];
          int to = e.from ^ e.to ^ i;
          if (match[to] == -1) {
            match[i] = to;
            match[to] = i;
            break;
          }
        }
      }
    }
  };  // greedy

  // randomize first
  greedy();
  // then find augmenting path for unmatched node
  for (int i = 0; i < g.n; i++) {
    if (match[i] == -1) {
      bfs(i);
    }
  }
  return match;
}
```

## Practice problems

??? note "[UOJ #79. maximum matching in general graph](https://uoj.ac/problem/79) (original link in Chinese)"
    ```cpp
    #include <bits/stdc++.h>
    using namespace std;
    
    // graph
    template <typename T>
    class graph {
     public:
      struct edge {
        int from;
        int to;
        T cost;
      };
      vector<edge> edges;
      vector<vector<int> > g;
      int n;
      graph(int _n) : n(_n) { g.resize(n); }
      virtual int add(int from, int to, T cost) = 0;
    };
    
    // undirectedgraph
    template <typename T>
    class undirectedgraph : public graph<T> {
     public:
      using graph<T>::edges;
      using graph<T>::g;
      using graph<T>::n;
    
      undirectedgraph(int _n) : graph<T>(_n) {}
      int add(int from, int to, T cost = 1) {
        assert(0 <= from && from < n && 0 <= to && to < n);
        int id = (int)edges.size();
        g[from].push_back(id);
        g[to].push_back(id);
        edges.push_back({from, to, cost});
        return id;
      }
    };
    
    // blossom / find_max_unweighted_matching
    template <typename T>
    vector<int> find_max_unweighted_matching(const undirectedgraph<T> &g) {
      std::mt19937 rng(chrono::steady_clock::now().time_since_epoch().count());
      vector<int> match(g.n, -1);   // match
      vector<int> aux(g.n, -1);     // time stamp
      vector<int> label(g.n);       // "o" or "i"
      vector<int> orig(g.n);        // blossom root
      vector<int> parent(g.n, -1);  // parent node
      queue<int> q;
      int aux_time = -1;
    
      auto lca = [&](int v, int u) {
        aux_time++;
        while (true) {
          if (v != -1) {
            if (aux[v] == aux_time) {  // find the visited node, LCA
              return v;
            }
            aux[v] = aux_time;
            if (match[v] == -1) {
              v = -1;
            } else {
              v = orig[parent[match[v]]];  // continue searching using the parent node of the matched node
            }
          }
          swap(v, u);
        }
      };  // lca
    
      auto blossom = [&](int v, int u, int a) {
        while (orig[v] != a) {
          parent[v] = u;
          u = match[v];
          if (label[u] == 1) {  // set source node as "o", find augmenting path
            label[u] = 0;
            q.push(u);
          }
          orig[v] = orig[u] = a;  // shrink bloosom
          v = parent[u];
        }
      };  // blossom
    
      auto augment = [&](int v) {
        while (v != -1) {
          int pv = parent[v];
          int next_v = match[pv];
          match[v] = pv;
          match[pv] = v;
          v = next_v;
        }
      };  // augment
    
      auto bfs = [&](int root) {
        fill(label.begin(), label.end(), -1);
        iota(orig.begin(), orig.end(), 0);
        while (!q.empty()) {
          q.pop();
        }
        q.push(root);
        // set starting node as "o", and replace "o" with "0", "i" with "1"
        label[root] = 0;
        while (!q.empty()) {
          int v = q.front();
          q.pop();
          for (int id : g.g[v]) {
            auto &e = g.edges[id];
            int u = e.from ^ e.to ^ v;
            if (label[u] == -1) {  // find unlabled node
              label[u] = 1;        // label "i"
              parent[u] = v;
              if (match[u] == -1) {  // find unmatched node
                augment(u);          // find augmenting path
                return true;
              }
              // find matched node, push matched node into queue, and extend alternating tree
              label[match[u]] = 0;
              q.push(match[u]);
              continue;
            } else if (label[u] == 0 &&
                       orig[v] !=
                           orig[u]) {  // finding visited node with label of "o" meaning the "blossom" has been found
              int a = lca(orig[v], orig[u]);
              // find LCA, then shrink blossom
              blossom(u, v, a);
              blossom(v, u, a);
            }
          }
        }
        return false;
      };  // bfs
    
      auto greedy = [&]() {
        vector<int> order(g.n);
        // randomize order
        iota(order.begin(), order.end(), 0);
        shuffle(order.begin(), order.end(), rng);
    
        // match nodes that can be matched
        for (int i : order) {
          if (match[i] == -1) {
            for (auto id : g.g[i]) {
              auto &e = g.edges[id];
              int to = e.from ^ e.to ^ i;
              if (match[to] == -1) {
                match[i] = to;
                match[to] = i;
                break;
              }
            }
          }
        }
      };  // greedy
    
      // first randomize matching
      greedy();
      // find augmenting path for unmatched node
      for (int i = 0; i < g.n; i++) {
        if (match[i] == -1) {
          bfs(i);
        }
      }
      return match;
    }
    int main() {
      ios::sync_with_stdio(0), cin.tie(0);
      int n, m;
      cin >> n >> m;
      undirectedgraph<int> g(n);
      int u, v;
      for (int i = 0; i < m; i++) {
        cin >> u >> v;
        u--;
        v--;
        g.add(u, v, 1);
      }
      auto blossom_match = find_max_unweighted_matching(g);
      vector<int> ans;
      int tot = 0;
      for (int i = 0; i < blossom_match.size(); i++) {
        ans.push_back(blossom_match[i]);
        if (blossom_match[i] != -1) {
          tot++;
        }
      }
      cout << (tot >> 1) << "\n";
      for (auto x : ans) {
        cout << x + 1 << " ";
      }
    }
    ```
