author: Dev-jqe, HeRaNO

## Common usage

In algorithmic programming competitions, we sometimes need to maintain multi-dimensional information and we often need nested trees to record it around this time. When we need to maintain the predecessor, the successor, the largest $k$ , the ranking of a certain number, insertion/deletion, we usually need to use a balanced tree to meet our needs, that is, a segment tree nesting a balanced tree.

## Principle of implementation 

We take **erbi** as an example to explain the implementation principle.

Regarding the nested trees, we normally build an segment tree in outer layer. For a node on the segment tree, build a balanced tree, including the sequence covered by the node. In the specific operation, we can insert sequence elements one by one, and the element is added to the node's balanced tree while passing a segment tree each time.

Operation 1: Find the ranking of a certain value in a certain interval: We operate normally for the segment tree in outer layer, and for the balanced tree of nodes in a certain interval, we return the number of elements in the balanced tree that are smaller than this value. When merging intervals, We simply sum the number of small elements. Finally, return the value $+1$ , which is the ranking of a certain value in a certain range.

Operation 2, find the value of rank $k$ in a certain interval: we can use the bisection method. Because there may be more than one element, its ranking is a range, and some elements do not exist in the original sequence. So we adopt a similar idea to operation one, we use the number of elements less than this value as a reference for the bisection method, and the solution can be obtained.

Operation 3, replace a certain number with another number: we only need to delete a certain number in all balanced trees, and then insert another one. The outer layer still operates as a normal segment tree.

Operation 4: Find the predecessor of a value in a certain interval: we operate normally for the outer segment tree. For the balanced tree of nodes in a certain interval, we return the predecessor of a value in the balanced tree. When merging the intervals of segment tree, take the maximum value would be fine.

## Space complexity

We add each element to $\log n$ balanced trees, so the space complexity is $(n + q)\log{n}$ .

## Time complexity

For operations $1,2,4$ , consider that we perform $\log{n}$ operations on the segment tree in the outer layer, and each operation will be performed in $\log{n}$ time complexity on an inner balanced tree. So the overall time complexity is $\log^2{n}$ .
For the $3$ operation, one more binary process is $\log^3{n}$ .

## Classic problem

 [erbi](https://loj.ac/problem/106)(original link in Chinese): outer layer is segment tree, and inner layer is balanced tree.

## Sample code

Please refer to [Splay](./splay.md) and other list items for part of the code implementation of balanced trees.

Operation one

```cpp
int vec_rank(int k, int l, int r, int x, int y, int t) {
  if (x <= l && r <= y) {
    return spy[k].chk_rank(t);
  }
  int mid = l + r >> 1;
  int res = 0;
  if (x <= mid) res += vec_rank(k << 1, l, mid, x, y, t);
  if (y > mid) res += vec_rank(k << 1 | 1, mid + 1, r, x, y, t);
  if (x <= mid && y > mid) res--;
  return res;
}
```

Operation two

```cpp
int el = 0, er = 100000001, emid;
while (el != er) {
  emid = el + er >> 1;
  if (vec_rank(1, 1, n, tl, tr, emid) - 1 < tk)
    el = emid + 1;
  else
    er = emid;
}
printf("%d\n", el - 1);
```

Operation three

```cpp
void vec_chg(int k, int l, int r, int loc, int x) {
  int t = spy[k].find(dat[loc]);
  spy[k].dele(t);
  spy[k].insert(x);
  if (l == r) return;
  int mid = l + r >> 1;
  if (loc <= mid) vec_chg(k << 1, l, mid, loc, x);
  if (loc > mid) vec_chg(k << 1 | 1, mid + 1, r, loc, x);
}
```

Operation four

```cpp
int vec_front(int k, int l, int r, int x, int y, int t) {
  if (x <= l && r <= y) return spy[k].chk_front(t);
  int mid = l + r >> 1;
  int res = 0;
  if (x <= mid) res = max(res, vec_front(k << 1, l, mid, x, y, t));
  if (y > mid) res = max(res, vec_front(k << 1 | 1, mid + 1, r, x, y, t));
  return res;
}
```

## Related algorithms

When solving problems with multi-dimensional information, if it is not required to be online, we can also consider **CDQ divide and conquer**, or **overall bisection method** and other divide and conquer algorithms to avoid using the advanced data structures and reduce the difficulty of code implementation.
