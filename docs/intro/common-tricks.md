This page mainly shares some common tricks used in the competition.

## Use locality

Locality refers to a program's tendency to refer to data items that are adjacent to other recently referenced data items, or those that were recently referenced themselves. Locality is divided into temporal locality and spatial locality.

-   Eliminate inefficiencies in loops, such as when traversing strings:
    ```cpp
    /* clang-format off */
    for (int i = 0; i < strlen(s); ++i);
    // better:
    for (int i = 0, len = strlen(s); i < len; ++i);
    ```
-   The loop unfolds. The number of operations on the critical path in the entire calculation can be reduced by using appropriate loop expansion.
    ```cpp
    for (int i = 0; i < n; ++i) {
      res = res OP a[i];
    }
    // better:
    int i;
    for (i = 0; i < n; i += 2) {
      res = res OP a[i];
      res = res OP a[i + 1];
    }
    for (; i < n; ++i) {
      res = res OP a[i];
    }
    ```
-   Reintegration of transforms increases the number of operations that can be performed in parallel:
    ```cpp
    // Of course, the plus sign can be replaced with other operators
    for (int i = 0; i < n; ++i) res = (res + a[i]) + a[i + 1];
    // better:
    for (int i = 0; i < n; ++i) res = res + (a[i] + a[i + 1]);
    ```

## Loop macro definition

When we are writing the code, there will be a lot of loop code like the following:

```cpp
for (int i = 0; i < N; i++) {
}
```

To simplify such code, we can use macro definition:

```cpp
#define f(x, y, z) for (int x = (y), __ = (z); x < __; ++x)
```

When writing loop code in this way, it can be simplified to `f(i, 0, N)`. E.g:

```cpp
// a is a STL container
f(i, 0, a.size()) { ... }
```

Another recommended macro definition:

```cpp
#define _rep(i, a, b) for (int i = (a); i <= (b); ++i)
```

## Make good use of namespace

Using namespace can make the program more readable and easy to debug.

??? note "Sample code"
    ```cpp
    // NOI 2018 Dragon Warrior 40 points partial code
    #include <algorithm>
    #include <cmath>
    #include <cstring>
    #include <iostream>
    using namespace std;
    long long n, m, a[100005], p[100005], aw[100005], atk[100005];
    namespace one_game {
    // We could actually declare variables in the namespace
    void solve() {
      for (int y = 0;; y++)
        if ((a[1] + p[1] * y) % atk[1] == 0) {
          cout << (a[1] + p[1] * y) / atk[1] << endl;
          return;
        }
    }
    }  // namespace one_game
    namespace p_1 {
    void solve() {
      if (atk[1] == 1) {  // solve 1-2
        sort(a + 1, a + n + 1);
        cout << a[n] << endl;
        return;
      } else if (m == 1) {  // solve 3-4
        long long k = atk[1], kt = ceil(a[1] * 1.0 / k);
        for (int i = 2; i <= n; i++)
          k = aw[i - 1], kt = max(kt, (long long)ceil(a[i] * 1.0 / k));
        cout << k << endl;
      }
    }
    }  // namespace p_1
    int main() {
      int T;
      cin >> T;
      while (T--) {
        memset(a, 0, sizeof(a));
        memset(p, 0, sizeof(p));
        memset(aw, 0, sizeof(aw));
        memset(atk, 0, sizeof(atk));
        cin >> n >> m;
        for (int i = 1; i <= n; i++) cin >> a[i];
        for (int i = 1; i <= n; i++) cin >> p[i];
        for (int i = 1; i <= n; i++) cin >> aw[i];
        for (int i = 1; i <= m; i++) cin >> atk[i];
        if (n == 1 && m == 1)
          one_game::solve();  // solve 8-13
        else if (p[1] == 1)
          p_1::solve();  // solve 1-4 or 14-15
        else
          cout << -1 << endl;
      }
      return 0;
    }
    ```

## Use identifiers for debugging

While testing locally, we often add some debugging statements. But we have to delete them all when submitting to OJ. This could be a bit inconvenient.

We can do local debugging by defining identifiers.

The general program framework is this:

```cpp
#define DEBUG
#ifdef DEBUG
// do something
#endif
// or
#ifndef DEBUG
// do something
#endif
```

`#ifdef` will check whether there is a corresponding identifier defined by `#define` in the program, if there is, it will execute the following content, `#ifndef`, on the other hand, will be executed without defining the corresponding identifier The following statement.

In this case, when submitting the program, we only need to comment out the `#define DEBUG` line.

Of course, we can also not define the identifier in the program, but define the DEBUG identifier at compile time through the compilation option of `-DDEBUG`. This way you don't need to modify the program when submitting.

Many OJs have turned on the `-DONLINE_JUDGE` compilation option, which could save a lot of time.

## Double Compare

Sometimes we don't know if the code we write is correct or not. At this time, we can use the "double compare" method to verify or debug.

What is "Double Compare"? Specifically, the correctness of the program is verified by comparing the output of the two programs. You can compare the output of your program with the output of other programs (brute force or other contestants') to judge whether your program is correct.

Of course, since the "Double Compare" process needs to be carried out many times, we need to automate it by batch processing.

Specifically, we need a data generator, and two programs to be compared with.

Run [Data Generator](../topic/problemsetting/#_17) once each time, write the generated data to the input file, make the two programs read the data through the redirection method, and write the output to the specified file , Use the `fc` command under Windows to compare files (`diff` command under Linux) to verify the correctness of the program.

If you find an error in the program, you can use the data you just generated for debugging.

The general framework of the double compare is as follows:

```cpp
#include <stdio.h>
#include <stdlib.h>
int main() {
  // For Windows
  // Do not use file input and output
  // Of course, this program can also be rewritten into a batch form
  while (1) {
    system("gen > test.in");  // The data generator writes the generated data to the input file
    system("test1.exe < test.in > a.out");  // Get program 1 output
    system("test2.exe < test.in > b.out");  // Get program 2 output
    if (system("fc a.out b.out")) {
      // This line of statements compares input and output
      // When fc returns 0, it means that the output is consistent
      // otherwise there is a difference
      system("pause");  // Easy to check the difference
      return 0;
      // The input data has been stored in the test.in file and can be used directly for debugging
    }
  }
}
```

## <span id="mempool">Memory pool</span>

When we need to allocate memory dynamically, frequent use of new/malloc will occupy a lot of time and space, and even generate a lot of memory fragments to reduce the performance of the program, which may make the originally correct program TLE/MLE.

In this case, we need to use the "memory pool" technique: before actually using the memory, first we apply for the allocation of a certain size of memory as a spare. When dynamic allocation is needed, we can directly allocate a block from the spare memory.

Of course, in most OI problems, we can calculate the maximum memory required in advance and apply for allocation at one time.

For example, the code to dynamically allocate $32$ signed integer array:

```cpp
inline int* newarr(int sz) {
  static int pool[maxn], *allocp = pool;
  return allocp += sz, allocp - sz;
}
```

Code for dynamic allocating nodes of the segment tree:

```cpp
inline Node* newnode() {
  static Node pool[maxn << 1], *allocp = pool - 1;
  return ++allocp;
}
```

Note: [part of this page(CN Version)](https://github.com/OI-wiki/OI-wiki/commit/e9fa69af9d7f1583cb5ddad837c04bb1b03d7939) was originally published in [洛谷日报#86](https://studyingfather.blog.luogu.org/some-coding-tips-for-oiers), sorted, slightly modified, and published by the original author to this point.
