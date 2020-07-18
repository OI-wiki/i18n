Counting sort is a stable sorting algorithm with a time complexity of $O(n+w)$ , where $w$ represents the size of the range of data to be sorted.

The counting sort consists of three steps:

1. Count how many times each number appears.
2. Find the prefix sum of the occurrence of each number.
3. Using the prefix sum of the number of occurrences, calculate the ranking of each number from right to left.

Pseudocode:

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

C++ code

```cpp
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
