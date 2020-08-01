author: hsfzLZH1, cesonic

WBLT, abbreviation for weight balanced leafy tree, is an uncommon way of implementing a balanced tree. However, it has the advantage that its constant is relatively small and can be used as [mergeable heap](https://en.wikipedia.org/wiki/Mergeable_heap).

Similar to WBT (weight-balanced trees), WBLT shows the property of leafy, that is, it has many nodes. But why we would we say that?

For $n$ numbers, unlike [treap](./treap) and others, WBLT will create $2n$ nodes with the weight equal to that of its right child, which is greater than or equal to left child.

Each insertion, similar to the heap, we swap one by one downwards and update with `pushup`. The operation is similar for deletion.

Of course, if the input data is ascending or descending, WBLT will degenerate into a linked list. So we need to use rotation to maintain balance.

Because WBLT satisfies the propertity of the heap at the same time, we can use it to implement heap and mergable heap.

And in the process of rotation, many garbage nodes will be generated. We can use garbage collection to recycle them. Only slightly modifying the operation of constructing nodes would be enough.

Here we offer the code implementation of common balanced tree:

```cpp
#include <cstdio>
#include <iostream>

using namespace std;

const int maxn = 400005;

const int ratio = 5;
int n, cnt, fa, root;
int size[maxn], ls[maxn], rs[maxn], val[maxn];

void newnode(int &cur, int v) {
  cur = ++cnt;
  size[cur] = 1;
  val[cur] = v;
}
void copynode(int x, int y) {
  size[x] = size[y];
  ls[x] = ls[y];
  rs[x] = rs[y];
  val[x] = val[y];
}
void merge(int l, int r) {
  size[++cnt] = size[l] + size[r];
  val[cnt] = val[r];
  ls[cnt] = l, rs[cnt] = r;
}
void rotate(int cur, bool flag) {
  if (flag) {
    merge(ls[cur], ls[rs[cur]]);
    ls[cur] = cnt;
    rs[cur] = rs[rs[cur]];
  } else {
    merge(rs[ls[cur]], rs[cur]);
    rs[cur] = cnt;
    ls[cur] = ls[ls[cur]];
  }
}
void maintain(int cur) {
  if (size[ls[cur]] > size[rs[cur]] * ratio)
    rotate(cur, 0);
  else if (size[rs[cur]] > size[ls[cur]] * ratio)
    rotate(cur, 1);
  if (size[ls[cur]] > size[rs[cur]] * ratio)
    rotate(ls[cur], 1), rotate(cur, 0);
  else if (size[rs[cur]] > size[ls[cur]] * ratio)
    rotate(rs[cur], 0), rotate(cur, 1);
}
void pushup(int cur) {
  if (!size[ls[cur]]) return;
  size[cur] = size[ls[cur]] + size[rs[cur]];
  val[cur] = val[rs[cur]];
}
void insert(int cur, int x) {
  if (size[cur] == 1) {
    newnode(ls[cur], min(x, val[cur]));
    newnode(rs[cur], max(x, val[cur]));
    pushup(cur);
    return;
  }
  maintain(cur);
  insert(x > val[ls[cur]] ? rs[cur] : ls[cur], x);
  pushup(cur);
}
void erase(int cur, int x) {
  if (size[cur] == 1) {
    cur = ls[fa] == cur ? rs[fa] : ls[fa];
    copynode(fa, cur);
    return;
  }
  maintain(cur);
  fa = cur;
  erase(x > val[ls[cur]] ? rs[cur] : ls[cur], x);
  pushup(cur);
}
int find(int cur, int x) {
  if (size[cur] == x) return val[cur];
  maintain(cur);
  if (x > size[ls[cur]]) return find(rs[cur], x - size[ls[cur]]);
  return find(ls[cur], x);
}
int rnk(int cur, int x) {
  if (size[cur] == 1) return 1;
  maintain(cur);  // asdasdasdasd
  if (x > val[ls[cur]]) return rnk(rs[cur], x) + size[ls[cur]];
  return rnk(ls[cur], x);
}
int main() {
  scanf("%d", &n);
  newnode(root, 2147383647);  // make root unchanged
  while (n--) {
    int s, a;
    scanf("%d %d", &s, &a);
    if (s == 1) insert(root, a);
    if (s == 2) erase(root, a);
    if (s == 3) printf("%d\n", rnk(root, a));
    if (s == 4) printf("%d\n", find(root, a));
    if (s == 5) printf("%d\n", find(root, rnk(root, a) - 1));
    if (s == 6) printf("%d\n", find(root, rnk(root, a + 1)));
  }
  return 0;
}
```
