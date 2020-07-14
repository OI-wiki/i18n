Bubble sorting is a stable sorting algorithm.

Taking ascending order as an example, the bubble sort checks two adjacent elements each time. If the previous element is larger than the following element, the adjacent two elements are swapped. When no adjacent elements need to be exchanged, the sorting is complete.

After $i$ scans, the $i$ item at the end of the sequence must be the largest $i$ item, so you need to scan at most $n-1$ through the array to complete the sorting.

When the sequence is completely ordered, the algorithm only needs to traverse the array once, without performing any swap operation, and the time complexity is $O(n)$ . In the worst case, bubble sorting needs to perform $\frac{(n-1)n}{2}$ exchange operations, and the time complexity is $O(n^2)$ . In the average case, the time complexity of bubble sort is also $O(n^2)$ .

Pseudocode：

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

C++ code:

```cpp
// Assuming that the size of the array is n+1, the bubble sort usually starts from the index 1
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
