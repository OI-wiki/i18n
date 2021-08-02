Last translate with upstream: [ade5838](https://github.com/OI-wiki/OI-wiki/commit/ade5838af091655fbe3cbfc5558be6e7bb082e2a#diff-fe99b49a9a2b29780730e50ad1eb6e603080062597b08ac87a3e029159e9330d)(Jul 14, 2021)

This article will briefly introduce bubble sort.

## Introduction

Bubble sort is a simple sorting algorithm. It is called so because during the process of algorithm, smaller element "float" to the top of array like bubbles.

## Working Principles

Taking ascending order as an example, the bubble sort checks two adjacent elements each time. If the previous element is larger than the following element, the adjacent two elements are swapped. When no adjacent elements need to be exchanged, the sorting is complete.

After $i$ scans, the $i$-th item at the end of the sequence must be among the largest $i$ items, so at most $n-1$ scans through the array is needed to complete the sorting.

## Properties

### Stability

Bubble sorting is a stable sorting algorithm.

### Time Complexity

When the sequence is completely ordered, the algorithm only needs to traverse the array once, without performing any swap operation, and the time complexity is $O(n)$. 

In the worst case, bubble sorting needs to perform $\frac{(n-1)n}{2}$ exchange operations, and the time complexity is $O(n^2)$. 

In average, the time complexity of bubble sort is also $O(n^2)$.

## Code Implementations

### Pseudocode

$$
\begin{array}{ll}
1 & \textbf{Input. } \text{An array } A \text{ consisting of }n\text{ elements.} \\
2 & \textbf{Output. } A\text{ will be sorted in nondecreasing order stably.} \\
3 & \textbf{Method. }  \\
4 & flag\gets True\\
5 & \textbf{while }flag\\
6 & \qquad flag\gets False\\
7 & \qquad\textbf{for }i\gets1\textbf{ to }n-1\\
8 & \qquad\qquad\textbf{if }A[i]>A[i + 1]\\
9 & \qquad\qquad\qquad flag\gets True\\
10 & \qquad\qquad\qquad \text{Swap } A[i]\text{ and }A[i + 1]
\end{array}
$$

### C++ code:

```cpp
// Assuming that the size of the array is n+1, and the index starts from 1
void bubble_sort(int *a, int n) {
  bool flag = true;
  while (flag) {
    flag = false;
    for (int i = 1; i < n; ++i) {
      if (a[i] > a[i + 1]) {
        flag = true;
        int t = a[i];
        a[i] = a[i + 1];
        a[i + 1] = t;
      }
    }
  }
}
```

### Python

```python
# Python Version
def bubble_sort(a, n):
    flag = True
    while flag:
        flag = False
        for i in range(1, n):
            if a[i] > a[i + 1]:
                flag = True
                a[i], a[i + 1] = a[i + 1], a[i]
```
