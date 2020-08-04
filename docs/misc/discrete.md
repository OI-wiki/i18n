author: GavinZhengOI

## Introduction

Discretization can be seen as a type of [hash](../string/hash.md) in essence, which ensures that the data still maintains the original full/partial order relationship after hashing.

In layman's terms, when some data is too large or the data type is not supported, it cannot be easily processed as an array subscript by itself, and only the relative size relationship between the elements affects the final result. We can use the original data according to the serial number from large to small to deal with the problem, that is, discretization.

The data used for discretization can be large integers, floating-point numbers, strings... etc.

## Implementation

C++ discretization has ready-made STL algorithms:

### Discretize array

Discretizing and querying an array is a common application scenario:

```cpp
// a[i] is the initial array, and the subscript range is [1, n]
// len is the effective length of the discretized array
std::sort(a + 1, a + 1 + n);
len = std::unique(a + 1, a + n + 1) - a -
      1;  // when discretizing the entire array, find the number of essentially different numbers after discretization.
```

After completing the above discretization, you can use the `std::lower_bound` function to find the rank (that is, the new serial number):

```cpp
std::lower_bound(a + 1, a + len + 1, x) - a;  // query the corresponding serial number of x after discretization
```

Similarly, we can also discretize `vector`:

```cpp
// std::vector<int> a, b; // b is a copy of a
std::sort(a.begin(), a.end());
a.erase(std::unique(a.begin(), a.end()), a.end());
for (int i = 0; i < n; ++i)
  b[i] = std::lower_bound(a.begin(), a.end(), b[i]) - a.begin();
```
