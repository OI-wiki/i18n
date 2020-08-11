author: StudyingFather, Backl1ght, countercurrent-time, Ir1d, greyqz, MicDZ, ouuan

## Mo's algorithm on bracket order tree

The common Mo's algorithm can only solve linear problems. We have to forcibly convert the tree into a sequence.

We can obtain the bracket order of the tree, divide the it into blocks, and run the Mo's algorithm on each one.

How to do this exactly?

Run DFS on a tree, and if DFS reaches the node x, it will be `push_back(x)`. And after the node x is traversed, it will be directly `push_back(-x)`. Then move the pointer.

- The newly added value is x  ---> `add(x)` 
- The newly added value is - x ---> `del(x)` 
- The newly deleted value is x  ---> `del(x)` 
- The newly deleted value is - x ---> `add(x)` 

In this case, we have processed a tree into a sequence.

???+note "Sample problem[「WC2013」Candy park](https://uoj.ac/problem/58)"
    Question: Given a tree, and each node has a color. Every time query

    $$\sum_{c}val_c\sum_{i=1}^{cnt_c}w_i$$

    Among them: $val$ represents the value of the color, $cnt$ represents the number of times the color appears, and $w$ represents the value after the color appears $i$ times

First we turn the tree into a sequence, and then add/remove a point each time. The contribution of this point to the answer can be obtained in $O(1)$ time, that is, $val_c\times w_{cnt_{c+1 }}$

What should we do if the algorithm would also scan the starting node of subtree and produce extra contributions?

Because the node in the starting subtree will definitely be scanned twice during the scanning process, but the contribution is 0.

So we can create a $vis$ array, and each time we scan to the node x, XOR $vis_x$ by 1.

If $vis_x=0$ , then the contribution of this node can be ignored.

So we can use the Mo's algorithm on the tree to solve this.

If we modify it, we can add a one-dimensional time dimension, and it becomes the Mo's algorithm with a modified tree.

Then because there may be no LCA in the included interval, if there is no LCA, delete the extra contribution, and then it's done.

??? Sample code
    ```cpp
    #include <algorithm>
    #include <cmath>
    #include <cstdio>
    using namespace std;
    
    const int maxn = 200010;
    
    int f[maxn], g[maxn], id[maxn], head[maxn], cnt, last[maxn], dep[maxn],
        fa[maxn][22], v[maxn], w[maxn];
    int block, index, n, m, q;
    int pos[maxn], col[maxn], app[maxn];
    bool vis[maxn];
    long long ans[maxn], cur;
    
    struct edge {
      int to, nxt;
    } e[maxn];
    int cnt1 = 0, cnt2 = 0;  // timestamp
    
    struct query {
      int l, r, t, id;
      bool operator<(const query &b) const {
        return (pos[l] < pos[b.l]) || (pos[l] == pos[b.l] && pos[r] < pos[b.r]) ||
               (pos[l] == pos[b.l] && pos[r] == pos[b.r] && t < b.t);
      }
    } a[maxn], b[maxn];
    
    inline void addedge(int x, int y) {
      e[++cnt] = (edge){y, head[x]};
      head[x] = cnt;
    }
    
    void dfs(int x) {
      id[f[x] = ++index] = x;
      for (int i = head[x]; i; i = e[i].nxt) {
        if (e[i].to != fa[x][0]) {
          fa[e[i].to][0] = x;
          dep[e[i].to] = dep[x] + 1;
          dfs(e[i].to);
        }
      }
      id[g[x] = ++index] = x;  // bracket sequence
    }
    
    inline int lca(int x, int y) {
      if (dep[x] < dep[y]) swap(x, y);
      if (dep[x] != dep[y]) {
        int dis = dep[x] - dep[y];
        for (int i = 20; i >= 0; i--)
          if (dis >= (1 << i)) dis -= 1 << i, x = fa[x][i];
      }  // reach the same height
      if (x == y) return x;
      for (int i = 20; i >= 0; i--) {
        if (fa[x][i] != fa[y][i]) x = fa[x][i], y = fa[y][i];
      }
      return fa[x][0];
    }
    
    inline void add(int x) {
      if (vis[x])
        cur -= (long long)v[col[x]] * w[app[col[x]]--];
      else
        cur += (long long)v[col[x]] * w[++app[col[x]]];
      vis[x] ^= 1;
    }
    
    inline void modify(int x, int t) {
      if (vis[x]) {
        add(x);
        col[x] = t;
        add(x);
      } else
        col[x] = t;
    }  // move on time dimentions
    
    int main() {
      scanf("%d%d%d", &n, &m, &q);
      for (int i = 1; i <= m; i++) scanf("%d", &v[i]);
      for (int i = 1; i <= n; i++) scanf("%d", &w[i]);
      for (int i = 1; i < n; i++) {
        int x, y;
        scanf("%d%d", &x, &y);
        addedge(x, y);
        addedge(y, x);
      }
      for (int i = 1; i <= n; i++) {
        scanf("%d", &last[i]);
        col[i] = last[i];
      }
      dfs(1);
      for (int j = 1; j <= 20; j++)
        for (int i = 1; i <= n; i++)
          fa[i][j] = fa[fa[i][j - 1]][j - 1];  // 预处理祖先
      int block = pow(index, 2.0 / 3);
      for (int i = 1; i <= index; i++) {
        pos[i] = (i - 1) / block;
      }
      while (q--) {
        int opt, x, y;
        scanf("%d%d%d", &opt, &x, &y);
        if (opt == 0) {
          b[++cnt2].l = x;
          b[cnt2].r = last[x];
          last[x] = b[cnt2].t = y;
        } else {
          if (f[x] > f[y]) swap(x, y);
          a[++cnt1] = (query){lca(x, y) == x ? f[x] : g[x], f[y], cnt2, cnt1};
        }
      }
      sort(a + 1, a + cnt1 + 1);
      int L, R, T;  // position index of pointers
      L = R = 0;
      T = 1;
      for (int i = 1; i <= cnt1; i++) {
        while (T <= a[i].t) {
          modify(b[T].l, b[T].t);
          T++;
        }
        while (T > a[i].t) {
          modify(b[T].l, b[T].r);
          T--;
        }
        while (L > a[i].l) {
          L--;
          add(id[L]);
        }
        while (L < a[i].l) {
          add(id[L]);
          L++;
        }
        while (R > a[i].r) {
          add(id[R]);
          R--;
        }
        while (R < a[i].r) {
          R++;
          add(id[R]);
        }
        int x = id[L], y = id[R];
        int llca = lca(x, y);
        if (x != llca && y != llca) {
          add(llca);
          ans[a[i].id] = cur;
          add(llca);
        } else
          ans[a[i].id] = cur;
      }
      for (int i = 1; i <= cnt1; i++) {
        printf("%lld\n", ans[i]);
      }
      return 0;
    }
    ```

## The real Mo's algorithm on trees

The Mo's algorithm on the tree just transforms the tree into a chain, and the real Mo's algorithm below is on-tree version.

Since the questions related to Mo's algorithm are all template questions, we will not explain too much about the implementation part.

### Sorting of the query

First of all, we know that Mo's algorithm is based on the blocking algorithm, so we need to find a tree blocking method to ensure the time complexity.

Conditions:

- The distance between nodes of the same block does not exceed the size of the given block
- There cannot be too many or too few nodes in each block
- Each node must belong to a block
- The distance between numbered adjacent blocks cannot be too large

After understanding these conditions, we can try this problem ["SCOI2005" Royal Federation](https://loj.ac/problem/2152)(original link in Chinese).

On the basis of this problem, we can solve the problem of blocking as long as we guarantee one last condition.

!!! Method
    Let lim be the size of the desired block. First, do the dfs for the entire tree. When the size of the subtree is greater than lim, divide them into one. It is easy to get that: for the root, there may be some nodes left, so we divide these nodes into the last block.

Method: Use the stack to maintain the current node as the parent node to access its child nodes. When the distance from the top of the stack to the parent node is greater than the size of the desired block, pop the element into one block, and use the remaining block as a single block.

If the first dimension timestamp is greater than the second dimension, swap them, and sort by the block to which the first dimension belongs as the first key, and the second dimension timestamp as the second key.

### Movement of pointers

It is easy to think that we can mark the points that are included in the answer. Let the pointer move directly to the target, and at the same time reverse the point on the path.

However, there is a problem. If the pointers are on x at the beginning, obviously x is marked. When the two pointers move to the same child node (there are many cases), x should not be marked. But the actual situation is that x is marked. Because the two pointers are marked once and offset.

How to solve this?

There is an obvious property: these points must be certain LCAs. Because the LCA may be repeatedly revoked that leas to revocation fails.

So we do not mark the LCA every time, but only mark the LCA when we need to ask for the answer, and then revoke it.

```cpp
// reverse all nodes on the path except LCA
void move(int x, int y) {
  if (dp[x] < dp[y]) swap(x, y);
  while (dp[x] > dp[y]) update(x), x = fa[x];
  while (x != y) update(x), update(y), x = fa[x], y = fa[y];
  // x!=y to ensure LCA is not reversed
}
```

For LCA, we can use a tree section, and then put the blocking step into the first dfs inside. And the timestamp can also directly use the dfs order of the second dfs.

```cpp
int bl[100002], bls = 0;  // block belonged, number of blocks
unsigned step;            // size of block
int fa[100002], dp[100002], hs[100002] = {0}, sz[100002] = {0};
// parent node, depth, heavy child, size
stack<int> sta;
void dfs1(int x) {
  sz[x] = 1;
  unsigned ss = sta.size();
  for (int i = head[x]; i; i = nxt[i])
    if (ver[i] != fa[x]) {
      fa[ver[i]] = x;
      dp[ver[i]] = dp[x] + 1;
      dfs1(ver[i]);
      sz[x] += sz[ver[i]];
      if (sz[ver[i]] > sz[hs[x]]) hs[x] = ver[i];
      if (sta.size() - ss >= step) {
        bls++;
        while (sta.size() != ss) bl[sta.top()] = bls, sta.pop();
      }
    }
  sta.push(x);
}
// main
if (!sta.empty()) {
  bls++;  // this line can be left out
  while (!sta.empty()) bl[sta.top()] = bls, sta.pop();
}
```

### Time complexity

The main point here is that the time complexity is actually related to the value of block size.

Let the block size be $unit$ :

- For pointer x, since the distance between the nodes in each block is around $unit$ , the x pointer in each block moves $unit^2$ times ( $unit\times dis_max$ ). So in total they move $n\times unit$ ( $unit^2 \times (n\div unit)$ ) times.
- For pointer y, there are at most $O(n)$ moves in each block. So in total they move $n^2\div unit$ ( $n \times (n \div unit)$ ) times.

Add up to get the minimum value at the root number (because the size of the block on the tree is not fixed, it is unnecessary to strictly follow the rule).

### Sample problem「WC2013」Candy park

Due to the additional time dimension, the size of the block should be taken to almost the same as $0.6n$ .

??? Sample code
    ```cpp
    #include <bits/stdc++.h>
    using namespace std;
    inline int gi() {
      register int x, c, op = 1;
      while (c = getchar(), c < '0' || c > '9')
        if (c == '-') op = -op;
      x = c ^ 48;
      while (c = getchar(), c >= '0' && c <= '9')
        x = (x << 3) + (x << 1) + (c ^ 48);
      return x * op;
    }
    int head[100002], nxt[200004], ver[200004], tot = 0;
    void add(int x, int y) {
      ver[++tot] = y, nxt[tot] = head[x], head[x] = tot;
      ver[++tot] = x, nxt[tot] = head[y], head[y] = tot;
    }
    int bl[100002], bls = 0;
    unsigned step;
    int fa[100002], dp[100002], hs[100002] = {0}, sz[100002] = {0}, top[100002],
                                id[100002];
    stack<int> sta;
    void dfs1(int x) {
      sz[x] = 1;
      unsigned ss = sta.size();
      for (int i = head[x]; i; i = nxt[i])
        if (ver[i] != fa[x]) {
          fa[ver[i]] = x, dp[ver[i]] = dp[x] + 1;
          dfs1(ver[i]);
          sz[x] += sz[ver[i]];
          if (sz[ver[i]] > sz[hs[x]]) hs[x] = ver[i];
          if (sta.size() - ss >= step) {
            bls++;
            while (sta.size() != ss) bl[sta.top()] = bls, sta.pop();
          }
        }
      sta.push(x);
    }
    int cnt = 0;
    void dfs2(int x, int hf) {
      top[x] = hf, id[x] = ++cnt;
      if (!hs[x]) return;
      dfs2(hs[x], hf);
      for (int i = head[x]; i; i = nxt[i])
        if (ver[i] != fa[x] && ver[i] != hs[x]) dfs2(ver[i], ver[i]);
    }
    int lca(int x, int y) {
      while (top[x] != top[y]) {
        if (dp[top[x]] < dp[top[y]]) swap(x, y);
        x = fa[top[x]];
      }
      return dp[x] < dp[y] ? x : y;
    }
    struct qu {
      int x, y, t, id;
      bool operator<(const qu a) const {
        return bl[x] == bl[a.x] ? (bl[y] == bl[a.y] ? t < a.t : bl[y] < bl[a.y])
                                : bl[x] < bl[a.x];
      }
    } q[100001];
    int qs = 0;
    struct ch {
      int x, y, b;
    } upd[100001];
    int ups = 0;
    long long ans[100001];
    int b[100001] = {0};
    int a[100001];
    long long w[100001];
    long long v[100001];
    long long now = 0;
    bool vis[100001] = {0};
    void back(int t) {
      if (vis[upd[t].x]) {
        now -= w[b[upd[t].y]--] * v[upd[t].y];
        now += w[++b[upd[t].b]] * v[upd[t].b];
      }
      a[upd[t].x] = upd[t].b;
    }
    void change(int t) {
      if (vis[upd[t].x]) {
        now -= w[b[upd[t].b]--] * v[upd[t].b];
        now += w[++b[upd[t].y]] * v[upd[t].y];
      }
      a[upd[t].x] = upd[t].y;
    }
    void update(int x) {
      if (vis[x])
        now -= w[b[a[x]]--] * v[a[x]];
      else
        now += w[++b[a[x]]] * v[a[x]];
      vis[x] ^= 1;
    }
    void move(int x, int y) {
      if (dp[x] < dp[y]) swap(x, y);
      while (dp[x] > dp[y]) update(x), x = fa[x];
      while (x != y) update(x), update(y), x = fa[x], y = fa[y];
    }
    int main() {
      int n = gi(), m = gi(), k = gi();
      step = (int)pow(n, 0.6);
      for (int i = 1; i <= m; i++) v[i] = gi();
      for (int i = 1; i <= n; i++) w[i] = gi();
      for (int i = 1; i < n; i++) add(gi(), gi());
      for (int i = 1; i <= n; i++) a[i] = gi();
      for (int i = 1; i <= k; i++)
        if (gi())
          q[++qs].x = gi(), q[qs].y = gi(), q[qs].t = ups, q[qs].id = qs;
        else
          upd[++ups].x = gi(), upd[ups].y = gi();
      for (int i = 1; i <= ups; i++) upd[i].b = a[upd[i].x], a[upd[i].x] = upd[i].y;
      for (int i = ups; i; i--) back(i);
      fa[1] = 1;
      dfs1(1), dfs2(1, 1);
      if (!sta.empty()) {
        bls++;
        while (!sta.empty()) bl[sta.top()] = bls, sta.pop();
      }
      for (int i = 1; i <= n; i++)
        if (id[q[i].x] > id[q[i].y]) swap(q[i].x, q[i].y);
      sort(q + 1, q + qs + 1);
      int x = 1, y = 1, t = 0;
      for (int i = 1; i <= qs; i++) {
        if (x != q[i].x) move(x, q[i].x), x = q[i].x;
        if (y != q[i].y) move(y, q[i].y), y = q[i].y;
        int f = lca(x, y);
        update(f);
        while (t < q[i].t) change(++t);
        while (t > q[i].t) back(t--);
        ans[q[i].id] = now;
        update(f);
      }
      for (int i = 1; i <= qs; i++) printf("%lld\n", ans[i]);
      return 0;
    }
    ```
