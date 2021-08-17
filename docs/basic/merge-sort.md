Last translate with upstream: [de9838c](https://github.com/OI-wiki/OI-wiki/commit/de9838c4ea0d82161c370b86a154648e174e8910#diff-b97e8b19e438130ccaa688da85fce4bd7871d08b5e25c0d44b1a25947ec45ecb) on August 11, 2021.

This article will briefly introduce the merge sort algorithm.

## Introduction

Merge sort is a sorting algorithm with [divide and conquer](./divide-and-conquer.md) paradigm.

## Principles

Merge sort has three steps:

1. Divide array into two parts;
2. Recursively merge sort the two sub-sequence;
3. Combine two sorted sub-sequence into one.

It is not hard to tell that the first two steps of merge sort can be easily implemented. However, the problem is how to combine the two sub-sequences. We can notice that both sub-sequences are in order after the second step. The third step is to actually combine two **ordered** sequences.

## Properties

Merge sort is a stable sorting algorithm.

The best-case, average-case and worst-case time complexity of merge sort are all $O(n\log n)$.

The space complexity of merge sort is $O(n)$.

## Code Implementations

### Pseudo Code

$$
\begin{array}{ll}
1 & \textbf{Input. }\text{Unsorted array}A\text{and temp array}T\\text{.}\
2 & \textbf{Output. }\text{Array}A\text{will be sorted in non-descending order stably.}\\
3 & \textbf{Method.}\\
4 & \text{merge}(A,\ T)\\
5 & \qquad\text{merge0}(A,\ T,\ 0,\ A.length)\\
6 & \text{merge0}(A,\ T,\ ll,\ rr)\\
7 & \qquad \textbf{if}\ \ rr - ll \leqslant 1\\
8 & \qquad\qquad \textbf{return}\\
9 & \qquad mid \gets \large\lfloor\frac{ll+rr}{2}\rfloor\\
10& \qquad\text{merge0}(A,\ T,\ ll,\ mid)\\
11&\qquad\text{merge0}(A,\ T,\ mid,\ rr)\\
12&\\
13&\qquad p \gets rr\\
14&\qquad q \gets mid\\
15&\qquad\textbf{for}\text{ each } i \text{ in the } ll\dots rr-1\\
16&\qquad\qquad\textbf{if}\ p\geqslant mid\ or\ q < rr\ and\ A[q] < A[p]\\
17&\qquad\qquad\qquad T[i] \gets A[q]\\
18&\qquad\qquad\qquad q \gets q+1\\
19&\qquad\qquad\textbf{else}\\
20&\qquad\qquad\qquad T[i] \gets A[p]\\
21&\qquad\qquad\qquad p \gets p+1\\
22&\qquad \text{copy }T[ll\dots rr-1] \text{ to } A[ll\dots rr-1]\\
\end{array}
$$

### C++

```cpp
// C++ Version
void merge(int ll, int rr) {
    // The function's job is to sort array a[] within index range $[ll, rr-1]$, with array t[] storing ordered sub-sequences temporarily.
  if (rr - ll <= 1) return;
  int mid = ll + (rr - ll >> 1);
  merge(ll, mid);
  merge(mid, rr);
  int p = ll, q = mid, s = ll;
  while (s < rr) {
    if (p >= mid || (q < rr && a[p] > a[q])) {
      t[s++] = a[q++];
      // ans += mid - p;
    } else
      t[s++] = a[p++];
  }
  for (int i = ll; i < rr; ++i) a[i] = t[i];
}
// The key point of this code block is that only create array once to avoid time cost of allocating memory in every recursive call.
```

### Python

```python
# Python Version
def merge_sort(ll, rr):
    if rr - ll <= 1:
        return
    mid = math.floor((rr + ll) / 2)
    merge_sort(ll, mid)
    merge_sort(mid, rr)
    p = s = ll
    q = mid
    while(s < rr):
        if p >= mid or (q < rr and a[p] > a[q]):
            s += 1
            q += 1
            t[s] = a[q]
        else:
            s += 1
            p += 1
            t[s] = a[p]
    for i in range(ll, rr):
        a[i] = t[i]
```

## Inversion

Merge sort can be used to find the [inversion number](https://en.wikipedia.org/wiki/Inversion_(discrete_mathematics)#Inversion_number).

An inversion pair $(i,j)$ is, for an array $a$, a number pair that satisfied $a_{i} > a_{j}$ and $i < j$.

The commented statement `ans += mid - p` in previous code implementation is counting the inversion pairs. Specifically, when the algorithm places latter elements to former places, (since smaller elements are placed former), any other element former than the original position and greater than the element forms inversion pairs with this element. The inversion number is the number of elements not yet combined, `mid - p`.

Finding number of inverse pairs can also be solved with data structure like [Fenwick tree](../ds/fenwick.md) and [segment tree](../ds/seg.md). The time complexity of all three approaches is $O(n \log n)$. 

## External Links and footnotes

- [Merge Sort - GeeksforGeeks](https://www.geeksforgeeks.org/merge-sort/)
- [Shellsort - Wikipedia](https://en.wikipedia.org/wiki/Shellsort)
- [Inversion (discrete mathematics) - Wikipedia](https://en.wikipedia.org/wiki/Inversion_(discrete_mathematics))
