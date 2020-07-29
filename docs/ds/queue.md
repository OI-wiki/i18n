This article introduces the queue-related data structure and its applications.

## Queue

Queue, [std::queue](https://en.cppreference.com/w/cpp/container/queue) and [std::priority_queue](https://en.cppreference.com/w/cpp/container/priority_queue) in C++ STL, is a data structure that can be modified on one end of the seuquence and removal from the other.

The element that enters the queue first must be out of the queue first, so the queue follows the First-in First-out rule, or FIFO for short.

Note: `std::stack` and `std::queue` are both container adapters, and the default underlying container is `std::deque` (double-ended queue).

## Deque

A deque is a queue that can insert or delete elements at the head/end of the queue. It is equivalent to a combination of stack and queue functions. Specifically, there are 4 operations supported by the deque:

1. Insert an element at the beginning of the deque
2. Insert an element at the end of the deque
3. Delete an element at the head of the deque
4. Delete an element at the end of the deque

## Array simulates queue

Usually an array is used to simulate the queue, and two variables are used to mark the beginning and the end of the queue.

```cpp
int q[SIZE], ql = 1, qr;
```

Insert element: `q[++qr]=x;` 

Delete element: `++ql;` 

Query front/end of queue: `q[ql]` / `q[qr]` 

Empty deque: `ql=1;qr=0;` 

Above rules work the same for array simulation deque.

## Circular queue

This will cause a problem: as time goes by, the entire queue will move to the end of the array. Once it reaches the end, even if there is a empty place at the front of the array, the enqueue operation will cause overflow. (This kind of situation where there is actually empty space in the array and overflow still occurs is called "false overflow".)

The solution to false overflow is to organize the array storing the queue elements in a circular manner, that is, the 0 index of the array is regarded as the successor of the last position. (The successor of `x` is `(x + 1)% Size` ). This would form a circular queue.

## Double stack simulates queue

In fact, not only arrays can be used to simulate queues, there is also a less popular method which is using double stacks to simulate queues.

We use two stacks F and S to simulate a queue, where F is the stack at the end of the queue, and S is the stack at the head of the queue. Push (insert at the end of the queue) and pop (pop at the beginning of the queue) operations are supported:

1. Push: insert into stack F.
2. Pop: if S is not empty, pop S; otherwise, turn the elements of F upside down and push them into S (which just means pop them one by one and insert, so that the first position is reversed after completion), and then pop S.

有人问这个东西有什么用吗？参见下面这道题。这道题顺便可以给大家一个 **双栈模拟双端队列** 的方法。

It is easy to prove that each element will only enter/transfer/pop once, and the amortized time complexity is $O(1)$ .

Someone might be wondering why this is usaful? Please see the problem below. It can also help you understand the **double stacks simulate deque** method.

## Sample problem

 [LOJ6515 'Yali Training 2018 Day10' Playful Blue Moon](https://loj.ac/problem/6515) (Original link in Chinese)

> One deque, m operations:
>
> 1.  Insert (w,v) at the front:
> 2.  Insert (w,v) in the end;
> 3.  Delete the tuple at the front;
> 4.  Delete the tuple in the end;
> 5.  For l, r, choose a subset S from deque so $\sum_{(w,v)\in S}w\bmod p\in[l,r]$ , and optimize $\sum_{(w,v)\in S}v$ .
>
>      $m\leq 5\times 10^4,p\leq 500$ .

### Offline algorithm

Each tuple has a survival time, so we create a segment tree of time, and each tuple is marked with log survival times. So what we have to do is to find an optimal subset of the labels on the path to the root node for each query. Obviously this can be done by DP. $f[S,j]$ represents the maximum value of j with the remainder of the items in the selection set S. (In fact, the implementation is in order, so we can use f[i,j] directly)

There are a total of $O(m\log m)$ tokens, so the overall time complexity is $O(mp\log m)$ .

### Online algorithm

This is an interesting problem where online algorithms are faster than offline algorithms. And it’s easier to write than offline.

The above offline algorithm is actually a little bit of an overkill, because if the deque of the title is changed to directly maintain a set (that is, the elements in the set are randomly deleted), then the offline algorithm is also applicable. Since it is a deque, you might as well operate on the data structure.

### Stack

What if the data structure in the problem is a stack?

Direct DP would be good enough. $f[i,j]$ represents the maximum value of the first $i$ tuples and the remainder is $j$ .

$$
f[i,j]=\max(f[i-1,j],f[i-1,(j-w_i)\bmod p]+v_i)
$$

This is clearly a knapsack problem.

When deleting, just move the pointer forward directly. The overall time complexity is $O(mp)$ .

### Queue

If the data structure in the problem is a queue?

There is an operation called double stack simulating queue. This is when it comes in. Because the stack can easily maintain the DP process, and the time complexity is evenly amortized, so the overall time complexity is still $O(mp)$ .

### Deque

Back to the original problem, what does Deque do?

Similarly, we can try simulating a double-ended queue with a stack, and it seems like we can easily extend the method of maintaining the queue. But if all elements in the stack are transferred each time, the time complexity of a single operation can easily degenerate to $O(m)$ .

But what if we only use half of it?

Such complexity is actually on constant level. Specifically, removing half refers to turning the half of a stack near the bottom of the stack upside down and putting it into another stack. In other words, the stack must be handwritten to support such operations.

### Time complexity of losing half

It seems that it can be proved by [potential energy analysis method](https://yhx-12243.github.io/OI-transit/records/cf601E.html) (original link in Chinese). We might consider the overall complexity of this double stack structure and m events. What to do if we hope to increase the complexity of this structure as much as possible?

First of all, if it is all insertion operations, it is strictly $\Theta(m)$ because the time complexity of insertion is $O(1)$ .

When is the "losing half" operation triggered? When a certain stack is empty and an element is requested to be deleted. Suppose the number of elements in another stack is $O(k)$ , then the time complexity of losing half is $O(k)\geq O(1)$.  Therefore, we need to increase the number of "losing half" operations as much as possible.

In order to increase the number of operations to halve, it is necessary to keep deleting elements until a certain stack is empty. Since the insertion operation is meaningless for increasing the complexity, we do not consider it here. There are $m$ elements at the beginning, assuming they are all in one stack. Then the complexity of losing half the first time is $O(m)$ . Then the two stacks each have $\frac{m}{2}$ elements. At this time, we need $O(\frac{m}{2})$ to delete one of the stacks, and then we can trigger the operation to lose half with complexity of $O(\frac{m}{2})$ again.

Consider the overall time complexity for this operation:

$$
T(m)=2\cdot O(m)+T\left(\frac{m}{2}\right)
$$

we have $T(m)=O(m)$ .

Therefore, the overall time complexity is $O(mp)$ .

### Query operation

When querying, we need to deal with the problem of "selecting the greatest value of several elements in the two stacks". Therefore, it is necessary to query the DP value at the top of the stack, that is, the maximum value of two $f,g$ for querying [l,r]:

$$
\max_{0\leq i<p}\left\{f[i]+\max_{l\leq i+j\leq r}g_j\right\}
$$

The brute force solution has $O(p^2)$ time complexity, but the monotonic queue can solve it in $O(p)$ .

```cpp
#include <algorithm>
#include <cctype>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <vector>
using namespace std;
typedef long long lld;
typedef long double lf;
typedef unsigned long long uld;
typedef pair<int, int> pii;
#define fi first
#define se second
#define pb push_back
#define mk make_pair
#define FOR(i, a, b) for (int i = (a); i <= (b); ++i)
#define ROF(i, a, b) for (int i = (a); i >= (b); --i)
/******************heading******************/
const int M = 5e4 + 5, P = 505;
int I, m, p;

inline int _(int d) { return (d + p) % p; }
namespace DQ {       // double-ended stack to simulate deque
pii fr[M], bc[M];    // front,back; fi:w,se:v;
int tf = 0, tb = 0;  // top
int ff[M][P], fb[M][P];
void update(pii *s, int f[][P], int i) {  // update f[i] from f[i-1]
  FOR(j, 0, p - 1) {
    f[i][j] = f[i - 1][j];
    if (~f[i - 1][_(j - s[i].fi)])
      f[i][j] = max(f[i][j], f[i - 1][_(j - s[i].fi)] + s[i].se);
  }
}
void push_front(pii x) { fr[++tf] = x, update(fr, ff, tf); }
void push_back(pii x) { bc[++tb] = x, update(bc, fb, tb); }
void pop_front() {
  if (tf) {
    --tf;
    return;
  }
  int mid = (tb + 1) / 2, top = tb;
  ROF(i, mid, 1) push_front(bc[i]);
  tb = 0;
  FOR(i, mid + 1, top) push_back(bc[i]);
  --tf;
}
void pop_back() {
  if (tb) {
    --tb;
    return;
  }
  int mid = (tf + 1) / 2, top = tf;
  ROF(i, mid, 1) push_back(fr[i]);
  tf = 0;
  FOR(i, mid + 1, top) push_front(fr[i]);
  --tb;
}
int q[M], ql, qr;
int query(int l, int r) {
  const int *const f = ff[tf], *const g = fb[tb];
  int ans = -1;
  ql = 1, qr = 0;
  FOR(i, l - p + 1, r - p + 1) {
    int x = g[_(i)];
    while (ql <= qr && g[q[qr]] <= x) --qr;
    q[++qr] = _(i);
  }
  ROF(i, p - 1, 0) {
    if (ql <= qr && ~f[i] && ~g[q[ql]]) ans = max(ans, f[i] + g[q[ql]]);
    // delete l-i，and add r-i+1
    if (ql <= qr && _(l - i) == q[ql]) ++ql;
    int x = g[_(r - i + 1)];
    while (ql <= qr && g[q[qr]] <= x) --qr;
    q[++qr] = _(r - i + 1);
  }
  return ans;
}
void init() { FOR(i, 1, P - 1) ff[0][i] = fb[0][i] = -1; }
}  // namespace DQ
int main() {
  DQ::init();
  scanf("%d%d%d", &I, &m, &p);
  FOR(i, 1, m) {
    char op[5];
    int x, y;
    scanf("%s%d%d", op, &x, &y);
    if (op[0] == 'I' && op[1] == 'F')
      DQ::push_front(mk(_(x), y));
    else if (op[0] == 'I' && op[1] == 'G')
      DQ::push_back(mk(_(x), y));
    else if (op[0] == 'D' && op[1] == 'F')
      DQ::pop_front();
    else if (op[0] == 'D' && op[1] == 'G')
      DQ::pop_back();
    else
      printf("%d\n", DQ::query(x, y));
  }
  return 0;
}
```
