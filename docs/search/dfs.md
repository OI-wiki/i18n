DFS is a concept in graph theory, please see [DFS (graph theory)](../graph/dfs.md) for details. In **searching algorithms**, this term usually refers to an algorithm that uses recursive functions to implement a brute force enumeration. It has certain similarities with the DFS algorithm in graph theory, but not exactly the same.

Let's consider this example:

???+note "sample problem"
    Divide the positive integer n into 3 different positive integers, such as 6=1+2+3, and the number in the back must be greater than or equal to the number in the front. Please output all solutions.

For this problem, what should I do if I don’t know about the search?

Of course use a 3-fold loop. The sample code is as follows:

```cpp
for (int i = 1; i <= n; ++i)
  for (int j = i; j <= n; ++j)
    for (int k = j; k <= n; ++k)
      if (i + j + k == n) printf("%d=%d+%d+%d\n", n, i, j, k);
```

What if we need to divide it into four integers? Add another cycle?

What about dividing into integers less than or equal to m?

This is when the recursive search is needed.

The characteristic of this type of search algorithms is that the target to be searched is divided into several "layers", and each layer makes decisions based on the state of the previous layers until the target state is reached.

Consider the above problem, that is to divide the positive integer n into the sum of m positive integers or less, and the number in the back must be greater than or equal to the number in the front, and we need to output all the solutions.

Suppose a set of solutions divide the positive integer $n$ into the sum of $k$ positive integers, and the $k$ positive integers are $a_1, a_2, \ldots, a_k$ .

We seperate the problem into layers, and the $i-th level determines $a_i$ . In order to make decisions at the $i$-th level, we need to record three state variables: $n-\sum_{j=1}^i{a_j}$ , which represents the sum of all positive integers; $a_{i-1 }$ , which represents the positive integer of the previous layer to ensure that the positive integer increases; and $i$, which is to ensure that we output at most $m$ positive integers.

To store the solution, we use the `arr` array, the $i$-th item represents $a_i$m. Note that arr is actually a stack of length $i$ .

Code show as below:

```cpp
int m, arr[103];  // arr is used to record the plan
void dfs(int n, int i, int a) {
  if (n == 0) {
    for (int j = 1; j <= i - 1; ++j) printf("%d ", arr[j]);
    printf("\n");
  }
  if (i <= m) {
    for (int j = a; j <= n; ++j) {
      arr[i] = j;
      dfs(n - j, i + 1, j);  // Please think about this line of code carefully
    }
  }
}
// main function
scanf("%d%d", &n, &m);
dfs(n, 1, 1);
```

## Sample problem

 [Luogu P1706 Permutation problem](https://www.luogu.com.cn/problem/P1706) (original link in Chinese)

C++ code:

```cpp
bool vis[N];  // visited array
int a[N];     // permutation array to store the current search results in order

void dfs(int step) {
  if (step == n + 1) {  // boundary
    for (int i = 1; i <= n; i++) {
      cout << setw(5) << a[i];
    }
    cout << endl;
    return;
  }
  for (int i = 1; i <= n; i++) {
    if (vis[i] == 0) {
      vis[i] = 1;
      a[step] = i;
      dfs(step + 1);
      vis[i] = 0;
    }
  }
  return;
}
```
