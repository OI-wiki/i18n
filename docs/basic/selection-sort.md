Last translate with upstream: [ade5838](https://github.com/OI-wiki/OI-wiki/commit/ade5838af091655fbe3cbfc5558be6e7bb082e2a#diff-5cef89aab399b836b51be217eb9b8d96a21c51ef118a177463160ff56a74b055)(on Jul 14, 2021)

This article will briefly introduce selection sort.

## Introduction

Selection sort is one of sort algorithms. The principle is finding the $i$-th smallest element (that is, the smallest element in $A_{i..n}$) each time, and then swapping this element with the element at position $i$ of the array.

![An animated example of selection sort](images/selection-sort-1-animate-example.svg)

## Properties

### Stability

Because of the operation of swapping two elements, the selection sort is an unstable sort.

### Time Complexity

The worst-case, average-case and best-case time complexity are all $O(n^2)$.

## Code Implementations

### Pseudocode

$$
\begin{array}{ll}
1 & \textbf{Input. } \text{An array } A \text{ consisting of }n\text{ elements.} \\
2 & \textbf{Output. } A\text{ will be sorted in nondecreasing order.} \\
3 & \textbf{Method. }  \\
4 & \textbf{for } i\gets 1\textbf{ to }n-1\\
5 & \qquad ith\gets i\\
6 & \qquad \textbf{for }j\gets i+1\textbf{ to }n\\
7 & \qquad\qquad\textbf{if }A[j]<A[ith]\\
8 & \qquad\qquad\qquad ith\gets j\\
9 & \qquad \text{swap }A[i]\text{ and }A[ith]\\
\end{array}
$$

### C++ code

```cpp
void selection_sort(int* a, int n) {
  for (int i = 1; i < n; ++i) {
    int ith = i;
    for (int j = i + 1; j <= n; ++j) {
      if (a[j] < a[ith]) {
        ith = j;
      }
    }
    int t = a[i];
    a[i] = a[ith];
    a[ith] = t;
  }
}
```

### Python

```python
# Python Version
def selection_sort(a, n):
    for i in range(1, n):
        ith = i
        for j in range(i + 1, n + 1):
            if a[j] < a[ith]:
                ith = j
        a[i], a[ith] = a[ith], a[i]
```