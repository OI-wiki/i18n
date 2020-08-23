## Introduction

Backtracking is a technique often used in depth-first search (DFS) and breadth-first search (BFS) problems.

The principle of backtracking is: go back if you can't get through.

## Implementation process

1. Construct the potential search tree.

2. Start the traversal.

3. If the boundary condition is met, the current search will no longer continue, instead, it will turn to another path.

4. When the target condition is reached, output the result.

## Classic sample problems

### DFS implementation

The traceback code for the Eight Queens problem ([USACO version](https://www.programmersought.com/article/92334981585/)):

```cpp
#include <bits/stdc++.h>
using namespace std;
int ans[14], check[3][28] = {0}, sum = 0, n;
void eq(int line) {
  if (line > n) {
    sum++;
    if (sum > 3)
      return;
    else {
      for (int i = 1; i <= n; i++) printf("%d ", ans[i]);
      printf("\n");
      return;
    }
  }
  for (int i = 1; i <= n; i++) {
    if ((!check[0][i]) && (!check[1][line + i]) && (!check[2][line - i + n])) {
      ans[line] = i;
      check[0][i] = 1;
      check[1][line + i] = 1;
      check[2][line - i + n] = 1;
      eq(line + 1);
      check[0][i] = 0;
      check[1][line + i] = 0;
      check[2][line - i + n] = 0;
    }
  }
}
int main() {
  scanf("%d", &n);
  eq(1);
  printf("%d", sum);
  return 0;
}
```

### BFS implementation

The traceback code for the maze problem (USACO version):

```cpp
using namespace std;
int n, m, k, x, y, a, b, ans;
int dx[4] = {0, 0, 1, -1}, dy[4] = {1, -1, 0, 0};
bool vis[6][6];
struct oo {
  int x, y, used[6][6];
};

oo sa;

void bfs() {
  queue<oo> q;
  sa.x = x;
  sa.y = y;
  sa.used[x][y] = 1;
  q.push(sa);
  while (!q.empty()) {
    oo now = q.front();
    q.pop();
    for (int i = 0; i < 4; i++) {
      int sx = now.x + dx[i];
      int sy = now.y + dy[i];
      if (now.used[sx][sy] || vis[sx][sy] || sx == 0 || sy == 0 || sx > n ||
          sy > m)
        continue;
      if (sx == a && sy == b) {
        ans++;
        continue;
      }
      sa.x = sx;
      sa.y = sy;
      memcpy(sa.used, now.used, sizeof(now.used));
      sa.used[sx][sy] = 1;
      q.push(sa);
    }
  }
}

int main() {
  scanf("%d%d%d", &n, &m, &k);
  scanf("%d%d%d%d", &x, &y, &a, &b);
  for (int i = 1, aa, bb; i <= k; i++) {
    scanf("%d%d", &aa, &bb);
    vis[aa][bb] = 1;
  }
  bfs();
  printf("%d", ans);
  return 0;
}
```
