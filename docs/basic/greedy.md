Greedy algorithm, as the name suggests, is using a computer to simulate the decision-making process of a "greedy" person.

This person always chooses the best operation according to certain criteria for every movement, who always **looks at current situation, and does not consider the possible impact in the future**.

It is conceivable that the greedy algorithm cannot obtain the optimal solution all the time, so in general, when using the greedy algorithm, you must ensure that you can prove its correctness.

## Common practice

There are two types of greedy problems commonly seen in the problems of difficulty level below senior division in [NOIP](https://en.wikipedia.org/wiki/National_Olympiad_in_Informatics). One is: "We sort XXX in a certain order and then process it in a certain order (for example, from small to large)." The other is: "We take the largest/smallest element from XXX and update it every time." Sometimes "the largest/smallest thing in XXX" can be optimized, such as maintaining a priority queue.

Why there are two types? You may find that one is [offline](https://en.wikipedia.org/wiki/Online_algorithm#:~:text=In%20contrast%2C%20an%20offline%20algorithm,developed%20is%20called%20online%20optimization.) and the other is [online](https://en.wikipedia.org/wiki/Online_algorithm).

## Proof method

Please consider the following methods according to the problems. Under normal circumstances, only one method will be used to prove a question.

1. Use the [proof by contradiction](https://en.wikipedia.org/wiki/Proof_by_contradiction). If the answer is not better after any/adjacent two elements in the exchange, then you can find that the current solution is already the optimal solution.
2. Use the [induction](https://en.wikipedia.org/wiki/Mathematical_induction) technique. First calculate the optimal solution $F_1$ for the boundary condition (e.g. $n = 1$ ), and then prove that for each $n$ , result of $F_{n+1}$ can be derived by $ F_{n}$ .

## Sorting method

The common case of sorting is to input an array containing several (usually one to two) weights, and then find the optimal value by sorting and then traversing the simulation calculation.

The sorting method of some problems is very obvious. For example, [USACO1.3 Barn Repair](https://www.luogu.com.cn/problem/P1209) (original link in Chinese) is to get the difference value of the input array, sort and simulate.

However, sometimes it is difficult to directly see the sorting method at once, such as [NOIP 2012 King Game](https://vijos.org/p/1779) (original link in Chinese), it is easy to mistakenly use $a$ or $b$ as an intuitive sorting keyword. After submission, you will find WA(Wrong Answer). A common approach here is to try to swap two adjacent elements of the array to **derive** the correct sorting method. We assume that the two numbers in input are saved in one structure.

```cpp
struct {
  int a, b;
} v[n];
```

Use $m$ to represent the product of all $a$ before $i$ , then the reward for the $i$-th minister is

$$
\frac{m} {v[i].b}
$$

The reward for the first $i + 1$-th minister is

$$
\frac{m \cdot v[i].a} {v[i + 1].b}
$$

If we exchange the positions of the $i$-th minister and the $i + 1$-th minister, then the reward for the $i + 1$-th minister is

$$
\frac{m} {v[i + 1].b}
$$

The reward for the $i + 1$-th minister is

$$
\frac{m \cdot v[i + 1].a} {v[i].b}
$$

If it is more optimal before swap, if and only if

$$
\max (\frac{m} {v[i].b}, \frac{m \times v[i].a} {v[i + 1].b})  < \max (\frac{m} {v[i + 1].b}, \frac{m \times v[i + 1].a} {v[i].b})
$$

Extract the same $m$ and get the fraction

$$
\max(\frac{1} {v[i].b}, \frac{v[i].a} {v[i + 1].b}) < \max(\frac{1} {v[i + 1].b}, \frac{v[i + 1].a} {v[i].b})
$$

Then devide the fraction into equation

$$
\max(v[i + 1].b, v[i].a \times v[i].b) < \max(v[i].b, v[i + 1].a \times v[i + 1].b)
$$

Then we successfully get the sorting function!

```cpp
struct uv {
  int a, b;
  bool operator<(const uv &x) const {
    return max(x.b, a * b) < max(b, x.a * x.b);
  }
};
```

If you have understood the method above, you can try this one: [Luogu P2123 Queens Game](https://www.luogu.com.cn/problem/P2123) (original link in Chinese).

## Regret method

???+note "Sample problem[USACO09OPEN Work Scheduling](https://www.luogu.com.cn/problem/P2949) (original link in Chinese)"
    John's workdays starts at $0$ and has $10^9$ units of time. In any unit of time, he can choose any of the tasks numbered $1$ to $N$ $N(1 \leq N \leq 10^5)$ to complete. The deadline for work $i$ is $D_i(1 \leq D_i \leq 10^9)$ , and the profit after completion is $P_i( 1\leq P_i\leq 10^9 )$ . Given the working profit and deadline, what is the maximum profit John can get?

Greedy method:

-    **1** . Let's assume that every job will be done, sort the jobs according to the deadline and push to queue.
-    **2** . When deciding whether to do or not to do the i-th work, if the deadline meets the condition, compare it with the element with the smallest pay in the team. If the i-th work pays higher (regret), then ans+=a[i].pq.top().

     **PS** ：Use priority queue (min heap) to maintain the smallest element on the top.

### Code

```cpp
#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <queue>
using namespace std;
struct f {
  long long d;
  long long x;
} a[100005];
bool cmp(f A, f B) { return A.d < B.d; }
priority_queue<long long, vector<long long>, greater<long long> > q;
int main() {
  long long n, i, j;
  cin >> n;
  for (i = 1; i <= n; i++) {
    scanf("%d%d", &a[i].d, &a[i].x);
  }
  sort(a + 1, a + n + 1, cmp);
  long long ans = 0;
  for (i = 1; i <= n; i++) {
    if (a[i].d <= q.size()) {
      if (q.top() < a[i].x) {
        ans += a[i].x - q.top();
        q.pop();
        q.push(a[i].x);
      }
    } else {
      ans += a[i].x;
      q.push(a[i].x);
    }
  }
  cout << ans << endl;
  return 0;
}
```
