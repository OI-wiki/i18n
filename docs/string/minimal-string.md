Minimal string representation is a method used to solve problems concerning what its name shows (i.e. minimal string representation itself). 

## Minimum representation of the string

### Cyclic isomorphism

When a position $i$ in the string $S$ can be selected to satisfy:

$$
S[i\cdots n]+S[1\cdots i-1]=T
$$

Then we can say that $S$ and $T$ are cyclically isomorphic.

### Minimal representation

The minimal representation of the string $S$ is a string with the smallest lexicographical order among all strings that are isomorphic to the $S$ loop.

## The simple brute force

Each time we compare the isomorphism of the loop starting from $i$ and $j$ , record the current position as $k$ , and skip the larger one each time we encounter a different character. The rest is the optimal solution.

```cpp
int k = 0, i = 0, j = 1;
while (k < n && i < n && j < n) {
  if (sec[(i + k) % n] == sec[(j + k) % n]) {
    ++k;
  } else {
    if (sec[(i + k) % n] > sec[(j + k) % n])
      ++i;
    else
      ++j;
    k = 0;
    if (i == j) i++;
  }
}
i = min(i, j);
```

The performance is good using random data, but it may get stuck with special cases.

For example: for string $\texttt{aaa}\cdots\texttt{aab}$ , it is not difficult to find that the time complexity of this algorithm degenerates to $O(n^2)$ .

We find that when there are multiple consecutive repeated substrings in the string, the efficiency of this algorithm is reduced. So we have to consider optimizing this process.

## Minimal representation algorithm

### The principle of the algorithm

For a pair of strings $A,B$ , their starting positions in the original string $S$ are respectively $i,j$ , and their first $k$ characters are the same, that is

$$
A[i \cdots i+k-1]=B[j \cdots j+k-1]
$$

First we consider the case where $A[i+k]>B[j+k]$ . We find that the strings whose starting position subscript $l$ satisfies the string of $i\le l\le i+k$ cannot be the answer. Because for any string $S_{i+p}$ (representing a string starting with $i+p$ ), there must be a string $S_{j+p}$ that is better than it.

So when comparing, we can skip the subscript $l\in [i,i+k]$ and directly compare $S_{i+k+1}$ .

In this way, we have completed the optimization of the above brute force solution.

### Time complexity
 $O(n)$ 

### Steps of the algorithm

1. Initialize pointer $i$ to $0$ , $j$ to $1$ , and initial matching length $k$ to $0$ ;
2. Compare the size of the $k$-th element, and jump to the corresponding pointer according to the comparison result. If the two pointers are the same after the jump, choose a pointer randomly and increase it by one to ensure that the two strings compared are different;
3. Repeat the process above until the comparisons are over;
4. The answer is the smaller one of $i,j$ ;

### Code

```cpp
int k = 0, i = 0, j = 1;
while (k < n && i < n && j < n) {
  if (sec[(i + k) % n] == sec[(j + k) % n]) {
    k++;
  } else {
    sec[(i + k) % n] > sec[(j + k) % n] ? i = i + k + 1 : j = j + k + 1;
    if (i == j) i++;
    k = 0;
  }
}
i = min(i, j);
```
