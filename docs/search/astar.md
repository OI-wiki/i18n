A\* algorithm is an improvement based on [BFS](./bfs.md).

Define the starting node as $s$ and the ending node as $t$ .

Define the distance function from the starting node as $g(x)$ (initial state).

Define the distance function to the ending node, or the final state, as $h(x), h*(x)$ .

Define the evaluation function for each node as $f(x)=g(x)+h(x)$ .

Each time the algorithm takes out the smallest element $f$ from the **priority queue**, and then updates the states of adjacent nodes.

The algorithm can find the optimal solution if $h\leq h*$.

Under the condition above, the algorithm **will not add duplicate nodes to the queue** if $h$ satisfies the triangle inequality.

In fact, when $h=0$ , the algorithm is the [DFS](./dfs.md) ; when $h=0$ and the edge weight is $1$ , it is [BFS](./bfs.md).

## Sample problem [Eight Digits](https://www.luogu.com.cn/problem/P1379) 

> NOTE: original link is in Chinese.

Problem: There are eight chess pieces on a $3\times 3$ chessboard whose chess pieces are is numbered from 1 to 8. There is an empty space in the board represented by 0. The pieces around the empty space can be moved to that space with making original position of that piece become an empty space. Give an initial layout and target layout (in order to make the topic simple, the target state is set as

    123
    804
    765

）, find a way to move from the initial layout to the target layout with the fewest steps.

 The function $h$ can be defined as the number of misplaced chesses.

It is easy to find that $h$ satisfies the two properties above, so this problem can be solved using the A\* algorithm.

Code implementation:

```cpp
#include <algorithm>
#include <cstdio>
#include <cstring>
#include <queue>
#include <set>
using namespace std;
const int dx[4] = {1, -1, 0, 0}, dy[4] = {0, 0, 1, -1};
int fx, fy;
char ch;
struct matrix {
  int a[5][5];
  bool operator<(matrix x) const {
    for (int i = 1; i <= 3; i++)
      for (int j = 1; j <= 3; j++)
        if (a[i][j] != x.a[i][j]) return a[i][j] < x.a[i][j];
    return false;
  }
} f, st;
int h(matrix a) {
  int ret = 0;
  for (int i = 1; i <= 3; i++)
    for (int j = 1; j <= 3; j++)
      if (a.a[i][j] != st.a[i][j]) ret++;
  return ret;
}
struct node {
  matrix a;
  int t;
  bool operator<(node x) const { return t + h(a) > x.t + h(x.a); }
} x;
priority_queue<node> q;
set<matrix> s;
int main() {
  st.a[1][1] = 1;
  st.a[1][2] = 2;
  st.a[1][3] = 3;
  st.a[2][1] = 8;
  st.a[2][2] = 0;
  st.a[2][3] = 4;
  st.a[3][1] = 7;
  st.a[3][2] = 6;
  st.a[3][3] = 5;
  for (int i = 1; i <= 3; i++)
    for (int j = 1; j <= 3; j++) {
      scanf(" %c", &ch);
      f.a[i][j] = ch - '0';
    }
  q.push({f, 0});
  while (!q.empty()) {
    x = q.top();
    q.pop();
    if (!h(x.a)) {
      printf("%d\n", x.t);
      return 0;
    }
    for (int i = 1; i <= 3; i++)
      for (int j = 1; j <= 3; j++)
        if (!x.a.a[i][j]) fx = i, fy = j;
    for (int i = 0; i < 4; i++) {
      int xx = fx + dx[i], yy = fy + dy[i];
      if (1 <= xx && xx <= 3 && 1 <= yy && yy <= 3) {
        swap(x.a.a[fx][fy], x.a.a[xx][yy]);
        if (!s.count(x.a)) s.insert(x.a), q.push({x.a, x.t + 1});
        swap(x.a.a[fx][fy], x.a.a[xx][yy]);
      }
    }
  }
  return 0;
}
```

## Sample problem [k shortest paths](https://www.luogu.com.cn/problem/P2483)

> NOTE: original link is in Chinese.

Problem: find any number of paths from the node $s$ to the node $t$ on a directed graph that are the smallest (may be set as $k$ ) in order.

It is easy to find that this problem can easily be transformed into a standard A\* algorithm problem.

The initial state is at the node $s$ , the final state is at the node $t$ , the distance function is the distance traveled from $s$ to the current node, and the evaluation function is the least distance to travel from the current node to the node $t$, that is, the shortest path from the current node to the node $t$ .

In this way, we build the graph in reverse order during preprocessing, calculate the shortest path from the node $t$ to all nodes, and then insert the initial state into the priority queue. Each time we take out the smallest element in $f(x)=g(x)+h(x)$ , calculate the information of the connected point, and insert it in the queue as well. When we reach the node $t$ for the first $k$th time , we also calculate the short path of $k$ from node $s$ to node $t$ .

Due to the designed distance function and evaluation function, each state needs to store two parameters: the current node $x$ and the distance traveled $v$ .

We can also optimize a little bit based on the current solution: since only the $k$th shortest path is required, when we reach the node for the $k+1$th time or more, we skip this state directly. The reason is that since the previous $k$ reaches of this node undoubtedly enabled $k$ paths to be constructed, it is unnecessary to add edges later.

Code implementation:

```cpp
#include <algorithm>
#include <cstdio>
#include <cstring>
#include <queue>
using namespace std;
const int maxn = 5010;
const int maxm = 400010;
const double inf = 2e9;
int n, m, k, u, v, cur, h[maxn], nxt[maxm], p[maxm], cnt[maxn], ans;
int cur1, h1[maxn], nxt1[maxm], p1[maxm];
double e, ww, w[maxm], f[maxn];
double w1[maxm];
bool tf[maxn];
void add_edge(int x, int y, double z) {
  cur++;
  nxt[cur] = h[x];
  h[x] = cur;
  p[cur] = y;
  w[cur] = z;
}
void add_edge1(int x, int y, double z) {
  cur1++;
  nxt1[cur1] = h1[x];
  h1[x] = cur1;
  p1[cur1] = y;
  w1[cur1] = z;
}
struct node {
  int x;
  double v;
  bool operator<(node a) const { return v + f[x] > a.v + f[a.x]; }
};
priority_queue<node> q;
struct node2 {
  int x;
  double v;
  bool operator<(node2 a) const { return v > a.v; }
} x;
priority_queue<node2> Q;
int main() {
  scanf("%d%d%lf", &n, &m, &e);
  while (m--) {
    scanf("%d%d%lf", &u, &v, &ww);
    add_edge(u, v, ww);
    add_edge1(v, u, ww);
  }
  for (int i = 1; i < n; i++) f[i] = inf;
  Q.push({n, 0});
  while (!Q.empty()) {
    x = Q.top();
    Q.pop();
    if (tf[x.x]) continue;
    tf[x.x] = true;
    f[x.x] = x.v;
    for (int j = h1[x.x]; j; j = nxt1[j]) Q.push({p1[j], x.v + w1[j]});
  }
  k = (int)e / f[1];
  q.push({1, 0});
  while (!q.empty()) {
    node x = q.top();
    q.pop();
    cnt[x.x]++;
    if (x.x == n) {
      e -= x.v;
      if (e < 0) {
        printf("%d\n", ans);
        return 0;
      }
      ans++;
    }
    for (int j = h[x.x]; j; j = nxt[j])
      if (cnt[p[j]] <= k && x.v + w[j] <= e) q.push({p[j], x.v + w[j]});
  }
  printf("%d\n", ans);
  return 0;
}
```
