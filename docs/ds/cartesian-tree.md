author: sshwy, zhouyuyang2002, StudyingFather, Ir1d, ouuan, Enter-tainer

This article introduces the [Cartesian tree](https://en.wikipedia.org/wiki/Cartesian_tree) — a data structure that is not very commonly used, but is closely related to the well-known balanced tree and heap.

Cartesian tree is a kind of binary tree, in which each node consists of a key value tuple $(k,w)$ . It is required that $k$ satisfy the properties of a binary search tree, and $w$ satisfy the properties of a heap. An interesting fact is that if the $k,w$ key value of the Cartesian tree is already determined, and both $k$ and $w$ are different from each other, then the structure of the Cartesian tree is unique. Please see the figure below：

![eg](./images/cartesian-tree1.png)

(Figure from Wikipedia)

The Cartesian tree above is equivalent to taking the array element value as the value $w$ and the array index as the key $k$ . Obviously, it can be found that the key of this tree, $k$, satisfies the property of the binary search tree, and the value $w$ satisfies the property of min heap.

In fact, the Cartesian tree in the figure is a special case, because the key of the tuple $k$ corresponds to the array index. This kind of the Cartesian tree has a special property, that is, the index in a subtree is a continuous interval (so that the properties of the binary search tree can be satisfied). A more general case is a Cartesian tree constructed from arbitrary tuples.

## Construction

### Building the stack

We consider sorting the elements according to the key value $k$ , and insert them one by one into the current Cartesian tree. Then each time we insert an element, it must be at the end of the right chain of the tree (right chain: the chain formed by the passing nodes from the root node to the right subtree). So we follow such a process to compare the $w$ of the right chain node with the current node $u$ from bottom to top. If we find a node $x$ on the right chain that satisfies $x_w<u_w$ , then $u$ is connected to the right child of $x$, and the original right subtree of $x$ becomes the left subtree of $u$.

We could directly refer to the figure below. The red box in the picture is the right chain that we always maintain:

![build](./images/cartesian-tree2.png)

It is obvious that each number enters and exits the right chain at most once (or each node exists in the right chain for a continuous period of time). During this process, we can use stack to maintain the nodes on the right chain of the current Cartesian tree. If a node is not on the right chain, we could just pop it off. In this way, each node can enter and exit at most once, and the time complexity is $O(n)$ . The pseudo code is shown as follows:

```text
Create an empty stack of size n. Use top to denote the top of the stack before the operation, and k to denote the top of the current stack.
For i := 1 to n
    k := top
    While (stack is not empty) and (top stack element > current element) 
        k--
    if stack is not empty
        top stack element.right child := current element
    if k < top
        current element.left child := top stack element
    push current element to stack
    top := k
```

```cpp
for (int i = 1; i <= n; i++) {
  int k = top;
  while (k > 0 && h[stk[k]] > h[i]) k--;
  if (k) rs[stk[k]] = i;  // rs represents the right child of each node in the Cartesian tree
  if (k < top) ls[i] = stk[k + 1];  // ls represents the left child of each node in the Cartesian tree
  stk[++k] = i;
  top = k;
}
```

## Cartesian tree and Treap

When it comes to Cartesian trees, it is easy to think of a well-known structure — [Treap](https://en.wikipedia.org/wiki/Treap). Yes, Treap is a kind of Cartesian tree, but the value of $w$ is completely random. Treap also has a linear construction algorithm. If you sort the elements in advance, obviously you can use the above monotonic stack algorithm to complete the construction process, but it is rarely used.

## Sample problem

[HDU 1506 Largest Rectangle in a Histogram](http://acm.hdu.edu.cn/showproblem.php?pid=1506)

> The general idea of the problem: there are $n$ positions, the height of each which is $h_i$ , find the largest sub-matrix. Example is shown below:
>
> ![eg](./images/cartesian-tree3.jpeg)
>
> The shaded part is the largest rectangle in a histogram in the figure.

This problem clearly can be solved using DP or monotonous stack, but actually it can also be solved with a Cartesian tree. Specifically, we take the index as the key $k$ and $h_i$ as the value $w$ to satisfy property of the min heap, and build a Cartesian tree of $(i,h_i)$ .

In this way, we enumerate each node $u$ and take $u_w$ (that is, the key value $h$ of height of node u) as the height of the largest sub-matrix. Since the Cartesian tree we built satisfies the property of min heap, the height of the nodes in the subtree of $u$ is greater than or equal to $u$ . And we know that the index in the $u$ subtree is a continuous interval. So we only need to know the size of the subtree, and then we can calculate the area of the largest submatrix in this interval. Update the answer with the value calculated at each node. Obviously this can be solved using a single pass DFS, so the time complexity is still $O(n)$ .

```cpp
#include <algorithm>
#include <cstdio>
#include <cstring>
#include <iostream>
using namespace std;
typedef long long ll;
const int N = 100000 + 10, INF = 0x3f3f3f3f;

struct node {
  int idx, val, par, ch[2];
  friend bool operator<(node a, node b) { return a.idx < b.idx; }
  void init(int _idx, int _val, int _par) {
    idx = _idx, val = _val, par = _par, ch[0] = ch[1] = 0;
  }
} tree[N];

int root, top, stk[N];
ll ans;
int cartesian_build(int n) {
  for (int i = 1; i <= n; i++) {
    int k = i - 1;
    while (tree[k].val > tree[i].val) k = tree[k].par;
    tree[i].ch[0] = tree[k].ch[1];
    tree[k].ch[1] = i;
    tree[i].par = k;
    tree[tree[i].ch[0]].par = i;
  }
  return tree[0].ch[1];
}
int dfs(int x) {
  if (!x) return 0;
  int sz = dfs(tree[x].ch[0]);
  sz += dfs(tree[x].ch[1]);
  ans = max(ans, (ll)(sz + 1) * tree[x].val);
  return sz + 1;
}
int main() {
  int n, hi;
  while (scanf("%d", &n), n) {
    tree[0].init(0, 0, 0);
    for (int i = 1; i <= n; i++) {
      scanf("%d", &hi);
      tree[i].init(i, hi, 0);
    }
    root = cartesian_build(n);
    ans = 0;
    dfs(root);
    printf("%lld\n", ans);
  }
  return 0;
}
```

## Reference

[Cartesian tree - wikipedia](https://en.wikipedia.org/wiki/Cartesian_tree)
