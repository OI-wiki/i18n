Last translate with upstream: [59c5913](https://github.com/OI-wiki/OI-wiki/commit/59c591359e60c50f1a6e3be7de222f7b2dc0236d#diff-43b88384525dc3568b4191bb3204f6306a62b4feb0b2c6d1fd7e36424a7eeb91)(Jul 20, 2021)

This article will briefly introduce counting sort.

## Introduction

Counting sort is an algorithm with linear time complexity.

## Principles

Counting sort works with an extra array $S$, in which the $i$-th element is the number of elements from original unsorted array whose value is equal to $i$. Then sort the elements in array $A$ to the correct order based on their positions in $C$.

The counting sort consists of three steps:

1. Count how many times each number appears.
2. Find the [prefix sum](./prefix-sum.md) of the occurrence of each number.
3. Using the prefix sum of the number of occurrences, calculate the ranking of each number from right to left.

## Properties

### Stability

Counting sort is a stable sorting algorithm.

### Time Complexity

Time complexity of counting sort is $O(n+w)$ , where $w$ represents the size of the range of data to be sorted.

## Code Implementations

### Pseudocode

$$
\begin{array}{ll}
1 & \textbf{Input. } \text{An array } A \text{ consisting of }n\text{ positive integers no greater than } w. \\
2 & \textbf{Output. } \text{Array }A\text{ after sorting in nondecreasing order stably.} \\
3 & \textbf{Method. }  \\
4 & \textbf{for }i\gets0\textbf{ to }w\\
5 & \qquad cnt[i]\gets0\\
6 & \textbf{for }i\gets1\textbf{ to }n\\
7 & \qquad cnt[A[i]]\gets cnt[A[i]]+1\\
8 & \textbf{for }i\gets1\textbf{ to }w\\
9 & \qquad cnt[i]\gets cnt[i]+cnt[i-1]\\
10 & \textbf{for }i\gets n\textbf{ downto }1\\
11 & \qquad B[cnt[A[i]]]\gets A[i]\\
12 & \qquad cnt[A[i]]\gets cnt[A[i]]-1\\
13 & \textbf{return } B
\end{array}
$$

### C++

```cpp
// C++ Version
const int N = 100010;
const int W = 100010;

int n, w, a[N], cnt[W], b[N];

void counting_sort() {
  memset(cnt, 0, sizeof(cnt));
  for (int i = 1; i <= n; ++i) ++cnt[a[i]];
  for (int i = 1; i <= w; ++i) cnt[i] += cnt[i - 1];
  for (int i = n; i >= 1; --i) b[cnt[a[i]]--] = a[i];
}
```

### Python

```python
# Python Version
N = W = 100010
n = w = 0
a = b = [0] * N
cnt = [0] * W

def counting_sort():
    for i in range(1, n + 1):
        cnt[a[i]] += 1
    for i in range(1, w + 1):
        cnt[i] += cnt[i - 1]
    for i in range(n, 0, -1):
        b[cnt[a[i]] - 1] = a[i]
        cnt[a[i]] -= 1
```

## References and Footnotes

[^ref1]: [Counting Sort - Wikipedia](https://en.wikipedia.org/wiki/Counting_sort)
