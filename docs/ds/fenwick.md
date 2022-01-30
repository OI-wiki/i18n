author: HeRaNO, Zhoier, Ir1d, Xeonacid, wangdehu, ouuan, ranwen, ananbaobeichicun, Ycrpro

## Introduction

The [Fenwick tree](https://en.wikipedia.org/wiki/Fenwick_tree)(or, binary indexed tree) and the segment tree are always mentioned together, but there are still some differences between them after all:

The operations that Fenwick tree can have, the segment tree must have;
The operations that segment tree have, the Fenwick tree does not necessarily have.

So it seems that choosing segment tree would be **the best choice**?

In fact, the code of Fenwick tree is much shorter, and the principle is clearer. When solving some single-node modification problems, the Fenwick tree is the best choice.

* * *

## Principle

If you want to understand the principle of the fenwick tree, please refer to the following figure:

![](./images/fenwick1.png)

The idea of this structure is somewhat similar to the segment tree: a large node is used to represent the information of some small nodes, and only some large nodes are required to be queried instead of more small nodes.

The bottom eight squares represent the eight numbers stored in $a$ , which are all decimal.

The remaining uneven squares above represent the parent of $a$-the $c$ array.

Obviously we can find:
 $c[2]$ manages $a[1]$ & $a[2]$ ;
 $c[4]$ manages $a[1]$ & $a[2]$ & $a[3]$ & $a[4]$ ;
 $c[6]$ manages $a[5]$ & $a[6]$ ; $c[8]$ manages all $8$ .

Then the principle of continuously jumping to the center nodes and scores keep increasing is the same (multiplication).

So, if you want to calculate the sum of intervals, for example, the sum of intervals from $a[51]$ ~ $a[91]$ , brute-force is of course possible. But if there are millions of numbers, we might be getting TLE.

Then the principle of continuously jumping to the center node, which is similar to jumping to the center point, is the same (multiplication).

You jump forward from $91$ and find that $c[n]$ . Just focus on $a[91]$ , then you will find $a[90]$ and that $c[n-1]$ manages $a[90]$ & $a[89]$ ; then you will jump directly to $a[88]$ , where $c [n-2]$ will take care of the numbers $a[81]$ ~ $a[88]$ , and the next query will look from $a[80]$ forwards, and so on.

* * *

## Usage and operation

So the question is, how do you know the number of $a$ $c$ manages? The $1$ , $2$ , $8$... how did you get it?
Here, we introduce a function - `lowbit`:

```cpp
int lowbit(int x) {
  // find the decimal number corresponding to the binary number of the first 1 and the 0 after this 1 from right to left of x
  return x & -x;
}
```

 The meaning of `lowbit` is explained, let’s use this statement to prove it $a[88]$ :  
 $88_{(10)}=1011000_{(2)}$   
Found that the binary composed of the first $1$ and the following $0$ is $1000$   
 $1000_{(2)} = 8_{(10)}$   
 The decimal system corresponding to $1000$ is $8$ , so $c$ manages a total of $8$ $a$ .

So this is what the `lowbit` is used for.

 **You might be wondering: what does x & -x mean?** 

> In general, for a positive number of int type, the highest bit is 0, followed by its binary representation; for negative numbers (-x), the representation method is to invert x and add 1 bitwise.

For example:
 $x =88_{(10)}=01011000_{(2)}$ ；  
 $-x = -88_{(10)} = (10100111_{(2)} + 1_{(2)}) =10101000_{(2)}$ ；  
 $x\ \& \ (-x) = 1000_{(2)} = 8_{(10)}$ 。

Then it is easier for **single node modification**:

```cpp
void add(int x, int k) {
  while (x <= n) {  // cannot cross the boundary
    c[x] = c[x] + k;
    x = x + lowbit(x);
  }
}
```

Every time updating from the parent, then you can leave it alone.

```cpp
int getsum(int x) {  // sum of a[1] ... a[x]
  int ans = 0;
  while (x >= 1) {
    ans = ans + c[x];
    x = x - lowbit(x);
  }
  return ans;
}
```

## Interval addition & interval sum

If we maintain the [finite difference](https://en.wikipedia.org/wiki/Finite_difference) array $b$ of the sequence $a$ , then we sum a prefix $r$ of $a$ , that is, $\sum_{i=1}^{r} a_i$ , which is defined by the difference array $a_i=\sum_{j=1}^i b_j$ .

Derive:

$$
\sum_{i=1}^{r} a_i\\=\sum_{i=1}^r\sum_{j=1}^i b_j\\=\sum_{i=1}^r b_i\times(r-i+1)
\\=\sum_{i=1}^r b_i\times (r+1)-\sum_{i=1}^r b_i\times i
$$

The interval sum can be obtained by subtracting two prefix sums, so we only need two fenwick trees to maintain $\sum b_i$ and $\sum i \times b_i$ respectively to find the interval sum.

Code is shown below:

```cpp
int t1[MAXN], t2[MAXN], n;

inline int lowbit(int x) { return x & (-x); }

void add(int k, int v) {
  int v1 = k * v;
  while (k <= n) {
    t1[k] += v, t2[k] += v1;
    k += lowbit(k);
  }
}

int getsum(int *t, int k) {
  int ret = 0;
  while (k) {
    ret += t[k];
    k -= lowbit(k);
  }
  return ret;
}

void add1(int l, int r, int v) {
  add(l, v), add(r + 1, -v);  // split the interval sum into two prefix sum
}

long long getsum1(int l, int r) {
  return (r + 1ll) * getsum(t1, r) - 1ll * l * getsum(t1, l - 1) -
         (getsum(t2, r) - getsum(t2, l - 1));
}
```

## Tricks

 build the tree in $O(n)$:

The value of each node is obtained by summing the values of all the children nodes directly connected to it. Therefore, you can consider the contribution backwards, that is, every time you determine the value of the child, update the direct parent with your own value.

```cpp
// O(n) build the tree
void init() {
  for (int i = 1; i <= n; ++i) {
    t[i] += a[i];
    int j = i + lowbit(i);
    if (j <= n) t[j] += t[i];
  }
}
```

 Query the $k$-th smallest/largest element in $O(\log n)$ . Here we only discuess the $k$-th smallest element problem. The $k$-th largest can be transformed into finding $k$-th smallest element problem through simple calculations.


Refer to the "Persistent Segment Tree" chapter for the idea of finding the smallest $k$-th interval. Treat all numbers as a repetitive set, that is, define the array $a$ to indicate that the element of value $i$ reappears $a_i$ times in the entire sequence. Finding the largest $k$ is to find the smallest $x$ that satisfies $\sum_{i=1}^{x}a_i \geq k$

Therefore, we can think of the algorithm: if we have found that $x$ satisfies $\sum_{i=1}^{x}a_i \le k$ , consider whether $x$ can continue increasing so that it still meets this condition. After finding the largest $x$ , $x+1$ is the value we want.

In the Fenwick tree, the nodes are divided according to the power of 2, which can be expanded each time. Let $sum$ denote the sum of the prefixes represented by the current $x$, then the following algorithm finds the largest $x$:

1. Find $depth=\left \lfloor \log_2n \right \rfloor$
2. Calculate $t=\sum_{i=x+1}^{x+2^{depth}}a_i$
3. If $sum+t \le k$ , it means the expansion is successful. Add $2^{depth}$ to $x$ ; otherwise, the expansion fails and no operation is performed on $x$
4. Decrease $depth$ by 1 and go back to step 2 until $depth$ is 0

```cpp
// Weighted fenwick tree query k-th smallest
int kth(int k) {
  int cnt = 0, ret = 0;
  for (int i = log2(n); ~i; --i) {      // i has the same meaning as depth above
    ret += 1 << i;                      // Try to expand
    if (ret >= n || cnt + t[ret] >= k)  // If the expansion fails
      ret -= 1 << i;
    else
      cnt += t[ret];  // After the expansion is successful, the previously summed value must be updated
  }
  return ret + 1;
}
```

Timestamp optimization:

A common technique for dealing with multiple sets of data. If the Fenwick tree is brute-forece cleared every time new data comes in, it may cause a timeout. Therefore, the $tag$ is used to store the last time the current node is used (that is, the last time used by the first set of data). Each time we check whether the time in this position $tag$ is the same as the current time, and then we will know whether this position should be 0 or the value in the array.

```cpp
// Timestamp optimization
int tag[MAXN], t[MAXN], Tag;
void reset() { ++Tag; }
void add(int k, int v) {
  while (k <= n) {
    if (tag[k] != Tag) t[k] = 0;
    t[k] += v, tag[k] = Tag;
    k += lowbit(k);
  }
}
int getsum(int k) {
  int ret = 0;
  while (k) {
    if (tag[k] == Tag) ret += t[k];
    k -= lowbit(k);
  }
  return ret;
}
```

## Sample problems

> Note: all original problems are in Chinese.

-    [Fenwick tree 1: single node modification, interval query](https://loj.ac/problem/130) 
-    [Fenwick tree 2: interval modification, single node query](https://loj.ac/problem/131) 
-    [Fenwick tree 3: interval modification, interval query](https://loj.ac/problem/132) 
-    [2D Fenwick tree 1: single node modification, interval query](https://loj.ac/problem/133) 
-    [2D Fenwick tree 3: interval modification, interval query](https://loj.ac/problem/135) 
