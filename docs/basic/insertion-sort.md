Last translated with upstream: [ade5838](https://github.com/OI-wiki/OI-wiki/commit/ade5838af091655fbe3cbfc5558be6e7bb082e2a#diff-fbb83b65764ddda9d8b8dd2ce94d74ee494cdf84a2f1f87f1e7b43fb9b2714d8)(Jun 14, 2021)

This article will briefly introduce insertion sort.

## Introduction

Insertion sort is a simple and straightforward sorting algorithm. Its working principle is by dividing the sequence into two parts, "sorted" and "unsorted". Each time, it selects one from the "unsorted" elements to insert into the correct position of the "sorted" part.

A similar operation is that, when playing poker, grab a card from deck, insert it to hand by its value, and then grab next card. Here is an animated illustration:

![insertion-sort-1-animate-example](images/insertion-sort-1-animate-example.svg)

## Properties

### Stability

Insertion sort is a stable sort.

### Time Complexity

The best-case time complexity of insertion sort is $O(n)$, whose efficiency is very high when the array is almost ordered.

The worst-case time complexity and average-case time complexity of insertion sort are both $O(n^2)$.

## Code Implementations

### Pseudocode

$$
\begin{array}{ll}
1 & \textbf{Input. } \text{An array } A \text{ consisting of }n\text{ elements.} \\
2 & \textbf{Output. } A\text{ will be sorted in nondecreasing order stably.} \\
3 & \textbf{Method. }  \\
4 & \textbf{for } i\gets 2\textbf{ to }n\\
5 & \qquad key\gets A[i]\\
6 & \qquad j\gets i-1\\
7 & \qquad\textbf{while }j>0\textbf{ and }A[j]>key\\
8 & \qquad\qquad A[j + 1]\gets A[j]\\
9 & \qquad\qquad j\gets j - 1\\
10 & \qquad A[j + 1]\gets key
\end{array}
$$

### C++ code

```cpp
void insertion_sort(int* a, int n) {
  // perform insertion sort on a[1],a[2],...,a[n]
  for (int i = 2; i <= n; ++i) {
    int key = a[i];
    int j = i - 1;
    while (j > 0 && a[j] > key) {
      a[j + 1] = a[j];
      --j;
    }
    a[j + 1] = key;
  }
}
```

### Python

```python
# Python Version
def insertion_sort(a, n):
    for i in range(2, n + 1):
        key = a[i]
        j = i - 1
        while j > 0 and a[j] > key:
            a[j + 1] = a[j]
            j = j - 1
        a[j + 1] = key
```