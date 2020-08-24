## Introduction

In simple terms, heuristic search is a technique that analyzes both taking and non-taking operations, and select a better solution (or delete the invalid solution).

Since the concept is too abstract, we will take a few examples to explain.

??? note " Sample problem [「NOIP2005 general level」Gather herbs](https://www.luogu.com.cn/problem/P1048) (original link in Chinese)"
    Problem: There are $N$ items and a backpack with a capacity of $W$ . Each item has two attributes: weight $wi$ and value $vi$ . It is required to select several items (each item can only be selected once) to put in the backpack to maximize the total value and the total weight of the items while not exceeding the capacity of the backpack.

## Code

We write an evaluation function $f$ that can cut all invalid 0 branches (that is, cut a large number of useless branches without selecting).

The running process of the evaluation function $f$ is as follows:

When taking the items, we need to check whether it exceeds the specified volume (feasible pruning).

When not taking it, check whether the value of the remaining medicine + the existing value is greater than the optimal solution found so far (optimal pruning).

## Sample code

```cpp
#include <algorithm>
#include <cstdio>
using namespace std;
const int N = 105;
int n, m, ans;
struct Node {
  int a, b;  // a represents time; b represents value
  double f;
} node[N];

bool operator<(Node p, Node q) { return p.f > q.f; }

int f(int t, int v) {
  int tot = 0;
  for (int i = 1; t + i <= n; i++)
    if (v >= node[t + i].a) {
      v -= node[t + i].a;
      tot += node[t + i].b;
    } else
      return (int)(tot + v * node[t + i].f);
  return tot;
}

void work(int t, int p, int v) {
  ans = max(ans, v);
  if (t > n) return;
  if (f(t, p) + v > ans) work(t + 1, p, v);
  if (node[t].a <= p) work(t + 1, p - node[t].a, v + node[t].b);
}

int main() {
  scanf("%d %d", &m, &n);
  for (int i = 1; i <= n; i++) {
    scanf("%d %d", &node[i].a, &node[i].b);
    node[i].f = 1.0 * node[i].b / node[i].a;
  }
  sort(node + 1, node + n + 1);
  work(1, m, 0);
  printf("%d\n", ans);
  return 0;
}
```
