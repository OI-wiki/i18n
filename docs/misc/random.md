## Overview

Randomization is widely used in various scenarios like **scaming points** and **being lazy** in OI.(JK :) )

Of course, there are some serious usage: creating random dataset during the competition and then double check.

Especially when the expected time complexity of the algorithm is correct and **independent from the input data**, randomization can be used to achieve the desired expected time complexity, such as Treap and mergable heap.

## Implementation

### rand

`rand` is used to generate a pseudo-random number. The disadvantage is that it is slow, and requires `#include<cstdlib>` .

Using `rand()` requires a random seed, you can use the `srand(seed)` function to change the random seed to `seed`. Of course, not initializing it would be totally fine.

The same `seed` runs the same program twice and the random result would be the same.

One option is using the current system time as the random seed: `srand(time(0))`.

Calling the `rand()` function will return a random non-negative integer. In the `Linux` system, the random range is $\left[0,2^{31}\right)$ . You can use modulo to limit its size.

!!! warning
    The range of the return value of `rand()` under `Windows` system is $\left[0,2^{15}\right)$ . It is recommended to use `(rand() << 15 | rand())` to generate larger random numbers when the number to be generated is no less than $2^{15}$ .

### mt19937

`mt19937` is a random number generator class and its function is the same as `rand`. The advantage is that it is more random (the period that appears cycle is longer) and the speed is much faster than `rand()`. It is required to use `#include<random>`.

 `mt19937` is based on [Mersenne Twister algorithm](https://en.wikipedia.org/wiki/Mersenne_Twister). You can use it to define a random number generator: `std::mt19937 myrand(seed)`. ` Seed` can be left blank. If `seed` is not filled, the default random seed will be used.

 `mt19937` overloads the `operator ()`. When you need to generate a random number, call `myrand()` and it will return one.

#### Example

```cpp
#include <ctime>
#include <iostream>
#include <random>

using namespace std;

int main() {
  mt19937 myrand(time(0));
  cout << myrand() << endl;
  return 0;
}
```

### random_shuffle

`random_shuffle` is used to randomly shuffle the specified sequence. It is required to use `#include<algorithm>`.

When using `random_shuffle`, you can pass in the first and last pointers of the specified range or the iterator (left-closed and right-open) : `std::random_shuffle(first, last)` or `std::random_shuffle(first, last, myrand)`

The random number generator used internally is `rand()` by default. Of course, you can always pass in a self-defined random number generator.

!!! warning
     `random_shuffle` has been deprecated in the C++14 standard and removed from the C++17 standard.

### shuffle

The utility is the same as `random_shuffle`. It is required to use `#include<algorithm>`.

The difference is that a custom random number generator must be used: `std::shuffle(first, last, myrand)`.

The following is a random generator written with `rand()` and `random_shuffle()`. The generated data is the random small dataset for ["ZJOI2012" disaster](https://www.luogu.com.cn/problem/P2597) (original link in Chinese).

```cpp
#include <algorithm>
#include <cstdlib>
#include <ctime>
#include <iostream>

int a[100];

int main() {
  srand(time(0));
  int n = rand() % 99 + 1;
  for (int i = 1; i <= n; i++) a[i] = i;
  std::cout << n << '\n';
  for (int i = 1; i <= n; i++) {
    std::random_shuffle(a + 1, a + i);
    int cnt = rand() % i;
    for (int j = 1; j <= cnt; j++) std::cout << a[j] << ' ';
    std::cout << 0 << '\n';
  }
}
```

## Example I

Let’s look at a network flow problem first: ["TJOI2015" Linear Algebra](https://loj.ac/problem/2100) (original link in Chinese).

What to do if we don't want to implement network flow or modeling?

### Solution

Randomize and reverse a position, then check the size and update the answer.

### Code

```cpp
#include <algorithm>
#include <cstdlib>
#include <iostream>

int n;

int a[510], b[510], c[510][510], d[510];
int p[510], q[510];

int maxans = 0;

void check() {
  memset(d, 0, sizeof d);
  int nowans = 0;
  for (int i = 1; i <= n; i++)
    for (int j = 1; j <= n; j++) d[i] += a[j] * c[i][j];
  for (int i = 1; i <= n; i++) nowans += (d[i] - b[i]) * a[i];
  maxans = std::max(maxans, nowans);
}

int main() {
  srand(19260817);
  std::cin >> n;
  for (int i = 1; i <= n; i++)
    for (int j = 1; j <= n; j++) std::cin >> c[i][j];
  for (int i = 1; i <= n; i++) std::cin >> b[i];
  for (int i = 1; i <= n; i++) a[i] = 1;
  check();
  for (int T = 1000; T; T--) {
    int tmp = rand() % n + 1;
    a[tmp] ^= 1;
    check();
  }
  std::cout << maxans << '\n';
}
```

## Example II

When the expected time complexity of an algorithm is correct and has nothing to do with the input data, we can achieve the expected balance through randomization (which means that the randomization cannot be optimization in bottom layer)

The randomization in Treap is very classic. Now let's look at the mergeable heap.

### Method

Then we can consider using a random heap that is extremely difficult to optimize, that is, not swapping children according to tree height, but randomly swapping them.

The most commonly used implementation of mergeable heap should be the leftist tree, and the time complexity of the merging can be maintained using the height of the tree and keeping the tree lean towards the left. However... **maintaining the tree height is not very convenient**.

Then we can consider using a random heap that is extremely difficult to card, that is, not swapping sons according to the height of the tree, but randomly swapping them.

### Code

```cpp
struct Node {
  int child[2];
  long long val;
} nd[100010];
int root[100010];

int merge(int u, int v) {
  if (!(u && v)) return u | v;
  int x = rand() & 1, p = nd[u].val > nd[v].val ? u : v;
  nd[p].child[x] = merge(nd[p].child[x], u + v - p);
  return p;
}

void pop(int &now) { now = merge(nd[now].child[0], nd[now].child[1]); }
```
