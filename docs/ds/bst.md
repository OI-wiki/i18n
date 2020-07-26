## Introduction to Binary Search Tree

Binary search tree is a tree-shape data structure of binary tree, which is defined as follows:

1. The empty tree is a binary search tree.

2. If the left subtree of the binary search tree is not empty, the weight sum of all nodes on the left subtree are less than the value of its root node.

3. If the right subtree of the binary search tree is not empty, the weight sum of all nodes on the right subtree are greater than the value of its root node.

4. The left and right subtrees of the binary search tree are both binary search trees.

The time spent on basic operations on a binary search tree is proportional to the height of the tree. For a binary search tree with $n$ nodes, the optimal time complexity of these operations is $O(\log n)$ and the worst is $O(n)$ . The expected height of a binary search tree that is randomly built is $O(\log n)$ .

## Basic operations

In the following code, we assume that $n$ is the number of nodes, $h$ is the height, `val[x]` is the value stored at node $x$, `cnt[x]` is the number of occurrences of the value stored in $x$ , and `lc[x]` and `rc[x]` are the left and right child nodes of node $x$, respectively.

### Traverse binary search tree

According to the recursive definition of the binary search tree, the sequence of the in-order traversal of the binary search tree is a non-decreasing sequence. The time complexity is $O(n)$ .

The code to traverse a binary search tree is shown below:

```cpp
void print(int o) {
  // traverse the binary search tree with root o
  if (!o) return;  // encounter empty tree, return
  print(lc[o]);    // recursively traverse the left subtree
  for (int i = 1; i <= cnt[o]; i++) printf("%d\n", val[o]);  // output root node information
  print(rc[o]);  // recursively traverse the right subtree
}
```

### Find min/max value

Based on the property of the binary search tree, the minimum value on the binary search tree is the leftmost vertex of the left chain in the binary search tree, and the maximum value is the rightmost vertex of the right chain in the binary search tree. The time complexity is $O(h)$ .

The findmin and findmax functions respectively return the node number $o$ corresponding to the minimum and maximum values. Use `val[o]` to get the corresponding minimum/maximum values.

```cpp
int findmin(int o) {
  if (!lc[o]) return o;
  return findmin(lc[o]);  // always go to left child
}
int findmax(int o) {
  if (!rc[o]) return o;
  return findmax(rc[o]);  // always go to right child
}
```

### Insert an element

Define `insert(o,v)` as the operation to insert a new node with value $v$ into the binary search tree with $o$ as the root node.

It can be classified as follows:

If $o$ is empty, directly return a new node with value $v$ .

If the weight of $o$ is equal to $v$ , the number of occurrences of this value in the additional field of the node is increased by $1$ .

If the weight of $o$ is greater than $v$ , insert a node with a weight of $v$ in the left subtree of $o$ .

If the weight of $o$ is less than $v$ , insert a node with a weight of $v$ in the right subtree of $o$ .

The time complexity is $O(h)$ .

```cpp
void insert(int& o, int v) {
  if (!o) {
    val[o = ++sum] = v;
    cnt[o] = siz[o] = 1;
    return;
  }
  siz[o]++;
  if (val[o] == v) {
    cnt[o]++;
    return;
  }
  if (val[o] > v) insert(lc[o], v);
  if (val[o] < v) insert(rc[o], v);
}
```

### Delete an element

Define `del(o,v)` as the operation to delete a node with a value of $v$ in a binary search tree with $o$ as the root node.

First find a node with a weight of $v$ in the binary search tree. It can be classified as follows:

If the additional $cnt$ of the node is greater than $1$ , only $cnt$ needs to be reduced.

If the additional $cnt$ of the node is $1$ :

If $o$ is a leaf node, just delete the node directly.

If $o$ is a chain node, that is, a node with only one child, return this child.

If $o$ has two non-empty child nodes, generally we replace it with the maximum value of its left subtree or the minimum value of its right subtree, and then delete it.

Time complexity is $O(h)$ .

```cpp
int deletemin(int& o) {
  if (!lc[o]) {
    int u = o;
    o = rc[o];
    return u;
  } else {
    int u = deletemin(lc[o]);
    siz[o] -= cnt[u];
    return u;
  }
}
void del(int& o, int v) {
  // Note that o may be modified
  siz[o]--;
  if (val[o] == v) {
    if (cnt[o] > 1) {
      cnt[o]--;
      return;
    }
    if (lc[o] && rc[o]) o = deletemin(rc[o]);
    // Here is an example of finding the minimum value of the right subtree
    else
      o = lc[o] + rc[o];
    return;
  }
  if (val[o] > v) del(lc[o], v);
  if (val[o] < v) del(rc[o], v);
}
```

### Find the ranking of elements

The ranking is defined as the number of numbers before the first identical element after sorting the array elements $+1$ .

Maintain the subtree size $siz$ of each root node. To find the ranking of an element, first move from the root node to this element. If you move to the right, the answer is the number of left child node of the root plus the number of duplicates of the current node, and the size of the left child subtree at the end node $+ 1$ .

Time complexity is $O(h)$ .

```cpp
int queryrnk(int o, int v) {
  if (val[o] == v) return siz[lc[o]] + 1;
  if (val[o] > v) return queryrnk(lc[o], v);
  if (val[o] < v) return queryrnk(rc[o], v) + siz[lc[o]] + cnt[o];
}
```

### Find the kth element

In a subtree, the ranking of the root node depends on the size of its left subtree.

If the size of the left subtree is greater than or equal to $k$ , then the element is in the left subtree;

If the size of the left subtree is in the interval $[k-cnt,k-1]$ ( $cnt$ is the number of occurrences of the value of the current node), then this element is the root node of the subtree;

If the size of the left subtree is less than $k-cnt$ , then the element is in the right subtree.

Time complexity is $O(h)$ .

```cpp
int querykth(int o, int k) {
  if (siz[lc[o]] >= k) return querykth(lc[o], k);
  if (siz[lc[o]] < k - cnt[o])
    return querykth(rc[o], k - siz[lc[o]] - cnt[o] + 1);
  return val[o];
  // To find the node corresponding to the kth element, just return o directly
}
```
