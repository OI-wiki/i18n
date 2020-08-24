Before learning IDA\*, please make sure you have completed the [A\*](./astar.md) algorithm and [iterative deepening search](./iterative.md).

## Introduction of IDA\* 

IDA\* algorithm is actually the A\* algorithm that uses iterative deepening technique. Compared with the A\* algorithm, IDA\* is more practical since it follows the depth-first rule:

1. No need to check for duplicates. No need to sort.
2. Space requirement is reduced.

     **General framework** (pseudocode):

```text
Procedure IDA_STAR(StartState)
Begin
  PathLimit := H(StartState) - 1;
  Succes := False;
  Repeat
    inc(PathLimit);
    StartState.g = 0;
    Push(OpenStack, StartState);
    Repeat
      CurrentState := Pop(OpenStack);
      If Solution(CurrentState) then
        Success = True
      Elseif PathLimit >= CurrentState.g + H(CurrentState) then
        For each Child(CurrentState) do
          Push(OpenStack, Child(CurrentState));
    until Success or empty(OpenStack);
  until Success or ResourceLimtsReached;
end;
```

### Advantage

1. The space overhead is small, and deep down is actually a depth-first search with limited depth. Also, it is well known that DFS consumes smaller space.
2. Beneficial for deep pruning.

### Disadvantage

Repetitive search: In the process of backtracking, each time the depth increases, the search must be done again from the beginning.

> In fact, the difference between the previous search and the next one is negligible.

## Sample problem

??? note "Egypt fraction"
     **Problem description**

    In ancient Egypt, people use the sum of unit fractions (that is, $\frac{1}{a}$ , $a$ is a natural number) to represent all rational numbers. For example, $\frac{2}{3}=\frac{1}{2}+\frac{1}{6}$ but $\frac{2}{3}=\frac{1}{ 3}+\frac{1}{3}$ is not allowed because same number cannot be added.

    For a fraction $\frac{a}{b}$ , there are many ways to represent it. Among them, the one with less addends is better than the one with more addends. If the number of additions is the same, the larger the minimum fraction, the better. For example, $\frac{19}{45}=\frac{1}{5}+\frac{1}{6}+\frac{1}{18}$ is the optimal solution.

    Enter integers $a,b$ ( $0<a<b<500$ ), and try to calculate the best expression.

    sample input:

    ```text
    495 499
    ```

    Sample output:

    ```text
    Case 1: 495/499=1/2+1/5+1/6+1/8+1/3992+1/14970
    ```

 **Analysis** 

Theoretically this problem can be solved by the backtracking method, but the **solution tree** would be a "horror" - not only the depth has no obvious upper bound, but the choice of addends is theoretically unlimited. In other words, if BFS is used, even one layer cannot be expanded, because each layer is **infinite**.

The solution is to use iterative deepening search: enumerate the upper limit of depth $maxd$ from small to large, and only consider nodes whose depth does not exceed $maxd$ for each execution. In this way, as long as the depth of the solution is optimized, it can be enumerated in a limited time.

The maximum depth $maxd$ can also be used for **pruning**. The expansion is carried out in the order of increasing denominator. If it is expanded to level $i$ , the sum of the first $i$th fractions is $\frac{c}{d}$ , and the $i$th fraction is $\frac{1} {e}$ , then at least $\frac{\frac{a}{b}-\frac{c}{d}}{\frac{1}{e}}$ fractions are needed to achieve the total $\frac{a}{b}$ . For example, if $\frac{19}{45}=\frac{1}{5}+\frac{1}{100}+\cdots$ is currently searched, the largest element in the following fractions is up to $\frac{1 }{101}$ , and at least $\frac{\frac{19}{45}-\frac{1}{5}}{\frac{1}{101}}=23$ is required to reach the sum of $\frac {19}{45}$ . So the first $22$ iterations will not consider this subtree at all. The key point here is that it can be estimated at least how many more steps are needed to solve the problem.

Please note that the estimates here are all optimistic, because the word **at least** is used. To be more academically specific, suppose the upper limit of depth is $maxd$ , the depth of current node $n$ is $g(n)$ , and the optimistic valuation function is $h(n)$ , then when $g(n)+h( n)>maxd$ , pruning should be carried out. Such an algorithm is IDA\*. Of course, in reality, you don’t need to strictly implement $g(n)$ and $h(n)$ . Instead, you just need to design an optimistic valuation function like the previous one, think about the circumstances under which it is impossible to solve under the current depth limit.

> If an optimistic valuation function can be designed to predict at least how many layers of nodes need to be expanded to obtain a solution, the iterative deepening search becomes the IDA\* algorithm.

 **Code** 

```cpp
// Egypt fraction problem
#include <algorithm>
#include <cassert>
#include <cstdio>
#include <cstring>
#include <iostream>
using namespace std;

int a, b, maxd;

typedef long long LL;

LL gcd(LL a, LL b) { return b == 0 ? a : gcd(b, a % b); }

// return satisfy the minimum c in 1/c <= a/b
inline int get_first(LL a, LL b) { return b / a + 1; }

const int maxn = 100 + 5;

LL v[maxn], ans[maxn];

// if the current solution v is better than the current optimal solution ans, update ans
bool better(int d) {
  for (int i = d; i >= 0; i--)
    if (v[i] != ans[i]) {
      return ans[i] == -1 || v[i] < ans[i];
    }
  return false;
}

// the current depth is d; the denominator cannot be less than `from`, and the sum of fractions is exactly aa/bb
bool dfs(int d, int from, LL aa, LL bb) {
  if (d == maxd) {
    if (bb % aa) return false;  // aa/bb must be the Egypt fraction
    v[d] = bb / aa;
    if (better(d)) memcpy(ans, v, sizeof(LL) * (d + 1));
    return true;
  }
  bool ok = false;
  from = max(from, get_first(aa, bb));  // beginning of enumeration
  for (int i = from;; i++) {
    // pruning: if the remaining maxd+1-d fractions are all 1/i, and the sum still does not exceed aa/bb, there is no solution
    if (bb * (maxd + 1 - d) <= i * aa) break;
    v[d] = i;
    // calculate aa/bb-1/i and set the result as a2/b2
    LL b2 = bb * i;
    LL a2 = aa * i - bb;
    LL g = gcd(a2, b2);  // in order to reduce
    if (dfs(d + 1, i + 1, a2 / g, b2 / g)) ok = true;
  }
  return ok;
}

int main() {
  int kase = 0;
  while (cin >> a >> b) {
    int ok = 0;
    for (maxd = 1; maxd <= 100; maxd++) {
      memset(ans, -1, sizeof(ans));
      if (dfs(0, get_first(a, b), a, b)) {
        ok = 1;
        break;
      }
    }
    cout << "Case " << ++kase << ": ";
    if (ok) {
      cout << a << "/" << b << "=";
      for (int i = 0; i < maxd; i++) cout << "1/" << ans[i] << "+";
      cout << "1/" << ans[maxd] << "\n";
    } else
      cout << "No solution.\n";
  }
  return 0;
}
```

## Practice problems

 [The rotation game UVa1343](https://www.luogu.com.cn/problem/UVA1343)(original link in Chinese)
