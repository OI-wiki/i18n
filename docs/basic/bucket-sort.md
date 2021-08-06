Last translate with upstream: [e4431ce](https://github.com/OI-wiki/OI-wiki/commit/e4431ce5d2a45924bb9ac8db46e756208ca37f20#diff-1192f62f7a7acdbc8fe52f352916538cb5e3aa84074bb3518e0806a37ddeacc9) ([PR #3312](https://github.com/OI-wiki/OI-wiki/pull/3312)) on July 11, 2021.

This article will briefly introduce bucket sort

## Introduction

Bucket sort is a sorting algorithm. It is suitable for cases where the range of data to be sorted is large but the distribution is relatively uniform.

## Working Principles

Bucket sort performs in the following steps:[^ref1]

1. Set up a sized array of initially empty buckets.
2. Go over the original array, putting each object in its bucket.
3. Sort each non-empty bucket.
4. Visit the buckets in order and put all elements back into the original array.

## Properties

### Stability

Bucket sort is stable if using stable inner sorting algorithm and relative orders are not changed when inserting elements into buckets.

### Time Complexity

The average-case time complexity of bucket sort is $O(n + n^2/k + k)$, which means the time complexity of scattering the range equally into $n$ pieces plus sorting plus concatenating. When $k\approx n$ the complexity becomes $O(n)$.[^ref2]

The worst-case time complexity of bucket sort is $O(n^2)$.

## Code Implementations

### C++

```cpp
// C++ Version
const int N = 100010;

int n, w, a[N];
vector<int> bucket[N];

void insertion_sort(vector<int>& A) {
  for (int i = 1; i < A.size(); ++i) {
    int key = A[i];
    int j = i - 1;
    while (j >= 0 && A[j] > key) {
      A[j + 1] = A[j];
      --j;
    }
    A[j + 1] = key;
  }
}

void bucket_sort() {
  int bucket_size = w / n + 1;
  for (int i = 0; i < n; ++i) {
    bucket[i].clear();
  }
  for (int i = 1; i <= n; ++i) {
    bucket[a[i] / bucket_size].push_back(a[i]);
  }
  int p = 0;
  for (int i = 0; i < n; ++i) {
    insertion_sort(bucket[i]);
    for (int j = 0; j < bucket[i].size(); ++j) {
      a[++p] = bucket[i][j];
    }
  }
}
```

### Python

```python
# Python Version
N = 100010
w = n = 0
a = [0] * N
bucket = [[] for i in range(N)]

def insertion_sort(A):
    for i in range(1, len(A)):
        key = A[i]
        j = i - 1
        while j >= 0 and A[j] > key:
            A[j + 1] = A[j]
            j -= 1
        A[j + 1] = key

def bucket_sort():
    bucket_size = int(w / n + 1)
    for i in range(0, n):
        bucket[i].clear()
    for i in range(1, n + 1):
        bucket[int(a[i] / bucket_size)].append(a[i])
    p = 0
    for i in range(0, n):
        insertion_sort(bucket[i])
        for j in range(0, len(bucket[i])):
            a[p] = bucket[i][j]
            p += 1
```

## References and Footnotes

[^ref1]: [Bucket sort - Wikipedia](https://en.wikipedia.org/wiki/Bucket_sort)
[^ref2]: [Bucket sort - Wikipedia](https://en.wikipedia.org/wiki/Bucket_sort#Average-case_analysis) (Chapter 2.2)
