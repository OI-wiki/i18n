author: mwsht, sshwy, ouuan, Ir1d, Henry-ZHR, hsfzLZH1

The scope the hover line applies to is a subset of the monotonic stack. Specifically, the hover line should meet the following conditions:

- Need to maintain monotonous information while scanning the sequence;
- Can be solved using the monotonic stack;
- No need to do binary search on the monotonic stack.

It seems that the hover line can be replaced and is useless, but its concept is simpler than the monotonic stack, and is more suitable for OI beginners to understand and use to solve problems like the largest sub-rectangle.

???+note "[SP1805 HISTOGRA - Largest Rectangle in a Histogram](https://www.luogu.com.cn/problem/SP1805)"
    General idea: There are $n$ rectangles with a width of $1$ on a horizontal line, find the area of the largest sub-rectangle in histograms.

Hover line is a vertical line. It has two properties: initial position and height. It can move left and right when its upper bound does not exceed the height of the rectangle at the current position.

For a hover line, we move it left or right under the premise that the upper bound does not exceed the height of the rectangle at the current position and does not move out of the boundary, and find out where it can expand to left and right at most. At this time, the area swept by this hover line is the largest possible rectangle containing it. It is easy to find that the largest sub-rectangle must contain a hover line with an initial position of $i$ and a height of $h_i$. The time complexity of enumeration to achieve this process is $O(n ^ 2)$, but we can optimize it to $O(n)$ using the hover line method.

We consider how to quickly find the leftmost endpoint that the hover line can reach.

Define $l_i$ as the leftmost endpoint to which the hover line of the current $i$-th position can reach. It is easy to get the initial value of $l_i$ as $i$ . We need to further check whether it can expand to the left.

- If the current $l_i = 1$ , then it has expanded to the boundary. Therefore, the position reached from the current hover line cannot expand anymore.
- If the current $a_i> a_{l_i-1}$ , then the position reached from the current hover line cannot expand anymore.
- If the current $a_i \le a_{l_i - 1}$ , then the current hover line can also be extended to the left, and position the hover line at $l_i-1$ can be extended to, the hover line at the position $i$ must be able to extend to as well. So we update $l_i$ to $l_{l_i-1}$ and continue to the execution.

Through amortized analysis, it can be proved that each $l_i$ will be traversed by other $l_j$ at most once, so the time complexity is $O(n)$ .

??? Sample code
    ```cpp
    #include <algorithm>
    #include <cstdio>
    using std::max;
    const int N = 100010;
    int n, a[N];
    int l[N], r[N];
    long long ans;
    int main() {
      while (scanf("%d", &n) != EOF && n) {
        ans = 0;
        for (int i = 1; i <= n; i++) scanf("%d", &a[i]), l[i] = r[i] = i;
        for (int i = 1; i <= n; i++)
          while (l[i] > 1 && a[i] <= a[l[i] - 1]) l[i] = l[l[i] - 1];
        for (int i = n; i >= 1; i--)
          while (r[i] < n && a[i] <= a[r[i] + 1]) r[i] = r[r[i] + 1];
        for (int i = 1; i <= n; i++)
          ans = max(ans, (long long)(r[i] - l[i] + 1) * a[i]);
        printf("%lld\n", ans);
      }
      return 0;
    }
    ```

???+note "[UVA1619 Feel Good](https://www.luogu.com.cn/problem/UVA1619)"
    For a sequence of length $n$ , find a sub-interval so that the product of the minimum value in the sub-interval and the length of the sub-interval is the maximum. It is required to minimize the length while meeting the maximum comfort value, and to minimize the number of the left endpoint while the length is minimum.

In this question, we can enumerate the minimum value. We consider the number $a_i$ at each position as the minimum value, expanding from $i$ to the left and right, and find that $\min\limits _ {j = l} ^ r a_j = a_i$ as much as we could. In this way, this question has been transformed into a hover line model.

??? Sample code
    ```cpp
    #include <cstdio>
    #include <cstring>
    const int N = 100010;
    int n, a[N], l[N], r[N];
    long long sum[N];
    long long ans;
    int ansl, ansr;
    bool fir = 1;
    int main() {
      while (scanf("%d", &n) != EOF) {
        memset(a, -1, sizeof(a));
        if (!fir)
          printf("\n");
        else
          fir = 0;
        ans = 0;
        ansl = ansr = 1;
        for (int i = 1; i <= n; i++) {
          scanf("%d", &a[i]);
          sum[i] = sum[i - 1] + a[i];
          l[i] = r[i] = i;
        }
        for (int i = 1; i <= n; i++)
          while (a[l[i] - 1] >= a[i]) l[i] = l[l[i] - 1];
        for (int i = n; i >= 1; i--)
          while (a[r[i] + 1] >= a[i]) r[i] = r[r[i] + 1];
        for (int i = 1; i <= n; i++) {
          long long x = a[i] * (sum[r[i]] - sum[l[i] - 1]);
          if (ans < x || (ans == x && ansr - ansl > r[i] - l[i]))
            ans = x, ansl = l[i], ansr = r[i];
        }
        printf("%lld\n%d %d\n", ans, ansl, ansr);
      }
      return 0;
    }
    ```

## Largest sub-rectangle

???+note "[P4147 Yuchan Palace](https://www.luogu.com.cn/problem/P4147) (original link in Chinese)"
    Given a $n \times m$ rectangle consists of `'F'` and `'R'`, find the area $\times 3$ of the largest sub-rectangle so that the value of all elements in this matrix are `'F'`.

We will find that the model of this question is very similar to the first one. After careful analysis, it is found that if each time we only consider all elements in a certain row, and use the distance upward as far as possible at position $(x, y)$ as the length of the hover line at that position, then the largest sub-rectangle must be these one of these rectangles that can be expanded left and right as far as possible.

??? Sample code
    ```cpp
    #include <algorithm>
    #include <cstdio>
    int m, n, a[1010], l[1010], r[1010], ans;
    int main() {
      scanf("%d%d", &n, &m);
      for (int i = 1; i <= n; i++) {
        char s[3];
        for (int j = 1; j <= m; j++) {
          scanf("%s", s);
          if (s[0] == 'F')
            a[j]++;
          else if (s[0] == 'R')
            a[j] = 0;
        }
        for (int j = 1; j <= m; j++)
          while (a[l[j] - 1] >= a[j]) l[j] = l[l[j] - 1];
        for (int j = m; j >= 1; j--)
          while (a[r[j] + 1] >= a[j]) r[j] = r[r[j] + 1];
        for (int j = 1; j <= m; j++) ans = std::max(ans, (r[j] + l[j] - 1) * a[j]);
      }
      printf("%d", ans * 3);
      return 0;
    }
    ```

## Practice problems

-  [P1169「ZJOI2007」Making Chessboard](https://www.luogu.com.cn/problem/P1169) (original link in Chinese) 
