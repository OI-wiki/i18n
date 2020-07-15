[Radix sort](https://en.wikipedia.org/wiki/Radix_sort) is an algorithm that splits the elements to be sorted into $k$ keywords (when comparing two elements, first compare the first keyword, if they are the same, then compare the second keyword...), and then stable sort the $k$ th keywords, the $k-1$ th keywords, and then sort the $k-2$ th keywords...Finally, sort the first keywords stably, and the stable  pairing of the entire sequence is completed.

For the correctness of radix sort, you can refer to <https://walkccc.github.io/CLRS/Chap08/8.3/#83-3>.

In general, if the range of each keyword is not large, you can use [count sort](./counting-sort.md) as the inner sorting. The time complexity is $O(nk+\sum\limits_{i= 1}^k w_i)$ , where $w_i$ is the range of the $i$ th keyword.

(If the key value range is large, you can directly use the comparison-based sorting with $O(nk\log n)$ time complexity without using radix sort.

Pseudocode:

$$
\begin{array}{ll}
1 & \textbf{Input. } \text{An array } A \text{ consisting of }n\text{ elements, where each element has }k\text{ keys.}\\
2 & \textbf{Output. } \text{Array }A\text{ will be sorted in nondecreasing order stably.} \\
3 & \textbf{Method. }  \\
4 & \textbf{for }i\gets k\textbf{ down to }1\\
5 & \qquad\text{sort }A\text{ into nondecreasing order by the }i\text{-th key stably}
\end{array}
$$

C++ code:

```cpp
const int N = 100010;
const int W = 100010;
const int K = 100;

int n, w[K], k, cnt[W];

struct Element {
  int key[K];
  bool operator<(const Element& y) const {
    // how two elements are compared
    for (int i = 1; i <= k; ++i) {
      if (key[i] == y.key[i]) continue;
      return key[i] < y.key[i];
    }
    return false;
  }
} a[N], b[N];

void counting_sort(int p) {
  memset(cnt, 0, sizeof(cnt));
  for (int i = 1; i <= n; ++i) ++cnt[a[i].key[p]];
  for (int i = 1; i <= w[p]; ++i) cnt[i] += cnt[i - 1];
  for (int i = 1; i <= n; ++i) b[cnt[a[i].key[p]]--] = a[i];
  memcpy(a, b, sizeof(a));
}

void radix_sort() {
  for (int i = k; i >= 1; --i) {
    counting_sort(i);
  }
}
```
