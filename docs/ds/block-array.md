## Building block arrays

块状数组，即把一个数组分为几个块，块内信息整体保存，若查询时遇到两边不完整的块直接暴力查询。一般情况下，块的长度为 $O(\sqrt{n})$ 。详细分析可以阅读 2017 年国家集训队论文中徐明宽的《非常规大小分块算法初探》。

下面直接给出一种建立块状数组的代码。

Block array is an array divided into several blocks, and the information within the block is stored as a whole. If you encounter incomplete blocks on both sides of the query, you can directly query brute-force. In general, the length of the block is $O(\sqrt{n})$ . For detailed analysis, you can read "A Preliminary Study on Unconventional Size Blocking Algorithms" by Xu Mingkuan in the 2017 National Training Team Paper.

The code for building a block array is directly given below.

```cpp
num = sqrt(n);
for (int i = 1; i <= num; i++)
  st[i] = n / num * (i - 1) + 1, ed[i] = n / num * i;
ed[num] = n;
for (int i = 1; i <= num; i++) {
  for (int j = st[i]; j <= ed[i]; j++) {
    belong[j] = i;
  }
  size[i] = ed[i] - st[i] + 1;
}
```

`st[i] ed[i]` is the start and end of the block, and `size[i]` is the size of the block.

## Save and modify information in the block

### Sample problem 1： [Master's Magic](https://www.luogu.com.cn/problem/P2801) (original link in Chinese)

We need to query the number of numbers greater than or equal to a number in a block, so we need a `t` array to sort the blocks. For the modification of the whole block, it is saved in a way similar to the permanent mark. Time complexity is $O(n\sqrt{n}\log n)$

```cpp
void Sort(int k) {
  for (int i = st[k]; i <= ed[k]; i++) t[i] = a[i];
  sort(t + st[k], t + ed[k] + 1);
}
void Modify(int l, int r, int c) {
  int x = belong[l], y = belong[r];
  if (x == y) {
    for (int i = l; i <= r; i++) a[i] += c;
    Sort(x);
    return;
  }
  for (int i = l; i <= ed[x]; i++) a[i] += c;
  for (int i = st[y]; i <= r; i++) a[i] += c;
  for (int i = x + 1; i < y; i++) dlt[i] += c;
  Sort(x);
  Sort(y);
}
int Answer(int l, int r, int c) {
  int ans = 0, x = belong[l], y = belong[r];
  if (x == y) {
    for (int i = l; i <= r; i++)
      if (a[i] + dlt[x] >= c) ans++;
    return ans;
  }
  for (int i = l; i <= ed[x]; i++)
    if (a[i] + dlt[x] >= c) ans++;
  for (int i = st[y]; i <= r; i++)
    if (a[i] + dlt[y] >= c) ans++;
  for (int i = x + 1; i <= y - 1; i++)
    ans += ed[i] - (lower_bound(t + st[i], t + ed[i] + 1, c - dlt[i]) - t) + 1;
  return ans;
}
```

### Sample problem 2: Cold Night Ark

Two operations:

1. Every number in the interval $[x,y]$ becomes $z$
2. Query the number of numbers less than or equal to $z$ in the interval $[x,y]$

Use `dlt` to save whether the entire block has been assigned. Use a value to indicate no. For corner blocks, you must `pushdown` before querying, and put the block information on each number. Remember to `sort` again after assignment. Other aspects are the same as above.

```cpp
void Sort(int k) {
  for (int i = st[k]; i <= ed[k]; i++) t[i] = a[i];
  sort(t + st[k], t + ed[k] + 1);
}
void PushDown(int x) {
  if (dlt[x] != 0x3f3f3f3f3f3f3f3fll)
    for (int i = st[x]; i <= ed[x]; i++) a[i] = t[i] = dlt[x];
  dlt[x] = 0x3f3f3f3f3f3f3f3fll;
}
void Modify(int l, int r, int c) {
  int x = belong[l], y = belong[r];
  PushDown(x);
  if (x == y) {
    for (int i = l; i <= r; i++) a[i] = c;
    Sort(x);
    return;
  }
  PushDown(y);
  for (int i = l; i <= ed[x]; i++) a[i] = c;
  for (int i = st[y]; i <= r; i++) a[i] = c;
  Sort(x);
  Sort(y);
  for (int i = x + 1; i < y; i++) dlt[i] = c;
}
int Binary_Search(int l, int r, int c) {
  int ans = l - 1, mid;
  while (l <= r) {
    mid = (l + r) / 2;
    if (t[mid] <= c)
      ans = mid, l = mid + 1;
    else
      r = mid - 1;
  }
  return ans;
}
int Answer(int l, int r, int c) {
  int ans = 0, x = belong[l], y = belong[r];
  PushDown(x);
  if (x == y) {
    for (int i = l; i <= r; i++)
      if (a[i] <= c) ans++;
    return ans;
  }
  PushDown(y);
  for (int i = l; i <= ed[x]; i++)
    if (a[i] <= c) ans++;
  for (int i = st[y]; i <= r; i++)
    if (a[i] <= c) ans++;
  for (int i = x + 1; i <= y - 1; i++) {
    if (0x3f3f3f3f3f3f3f3fll == dlt[i])
      ans += Binary_Search(st[i], ed[i], c) - st[i] + 1;
    else if (dlt[i] <= c)
      ans += size[i];
  }
  return ans;
}
```

## Practices

> Following problems are written in Chinese.

1.   [Single point modification, interval query](https://loj.ac/problem/130) 
2.   [Interval modification, interval query](https://loj.ac/problem/132) 
3.   [[Template]Segment tree 2](https://www.luogu.com.cn/problem/P3373) 
4.   [「Ynoi2019 Mock competition」Yuno loves sqrt technology III](https://www.luogu.com.cn/problem/P5048) 
5.   [「Violet」Dandelion](https://www.luogu.com.cn/problem/P4168) 
6.   [Writing poems](https://www.luogu.com.cn/problem/P4135) 
