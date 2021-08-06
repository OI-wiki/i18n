This article will briefly introduce sorting algorithms implemented in C/C++ standard template library.

Unless otherwise specified, all functions mentioned in this article are defined in header `<algorithm>`.

## qsort

## sort

The standard C library implements quick sort, which is `qsort` in `stdlib.h`.

But in OI-related competitions, the library sorting function more commonly used is the `std::sort` from the C++ `algorithm` library.

The C++ standard does not strictly specify the implementation of this function and it depends on the compiler used.

The old version of the C++ standard only requires its **average** time complexity to reach $O(n\log n)$ , but the C++11 standard requires its **worst** time complexity to reach $O( n\log n)$ . You can refer to [std::sort()](https://en.cppreference.com/w/cpp/algorithm/sort).

In both [libstdc++](https://github.com/mirrors/gcc/blob/master/libstdc++-v3/include/bits/stl_algo.h) and [libc++](http://llvm.org/svn/llvm-project/libcxx/trunk/include/algorithm), [introsort](https://en.wikipedia.org/wiki/Introsort) is used.

Introsort limits the divide and conquer depth of quicksort. When divide and conquer reaches a certain depth, use a sorting algorithm (such as heap sort) with the worst time complexity of $O(n\log n)$ to sort the sub-arrays.

This limitation of Introsort makes its worst time complexity $O(n\log n)$ .

Usage:

```cpp
// a[0] .. a[n - 1]: array needs to be sorted
std::sort(a, a + n);
// The above code directly modifies the order of elements in the array so that it is now sorted ascendingly.

std::sort(a, a + n, cmp);  // cmp is a custom comparison function
```

## std::nth_element

The function is to find with the $k$-th largest number in the selected interval, put all the elements smaller and larger than it on both sides respectively, and return its address.

The principle is the unfinished quick sort.

Usage:

```cpp
std::nth_element(begin, mid, end);
std::nth_element(begin, mid, end, cmp);
```

Time complexity: Expected value of $O(n)$.

Often used to build [K-D Tree](https://en.wikipedia.org/wiki/K-d_tree).

## std::stable_sort

Stable $O(n\log n)$ sort means that the relative positions of equal elements after the sorting are the same as the original sequence.

Usage:

```cpp
std::stable_sort(begin, end);
std::stable_sort(begin, end, cmp);
```

## std::partial_sort

Place the top $k$ smallest elements in the first $k$ positions in the sequence (the order of equal elements is not guarnteed), and the order of the remaining elements is not specified.

Time complexity: $O(n\log k)$ 

Usage:

```cpp
std::partial_sort(begin, begin + k, end);
std::partial_sort(begin, begin + k, end, cmp);
```

Principle:

The principle of implementing `partial_sort` is to perform the `make_heap()` operation on the elements in the interval $[first, middle)$ in the original sequence to construct a max heap, and then take each element in $[middle, last)$ to compare with the $first$ — the maximum value in the heap. If it is less than the maximum value, the two elements are swapped, and the elements in $[first, middle)$ are adjusted to maintain the max heap. After the comparison, the elements in $[first, middle)$ are sorted by `sort_heap()` in ascending order. Please note that heap order is different ascending order.

## Define operator

For both built-in types (such as `int`) and user-defined structures, you can define the **less than operator** when calling the STL sorting function. You can pass a comparison operator function (usually the last parameter) when calling the function, or directly override the default operator of this type. See [cppreference](https://en.cppreference.com/w/cpp/language/operators).

Here are a few examples:

```cpp
int a[1009], n = 10;
// ......
std::sort(a + 1, a + 1 + n);                  // sort ascendingly
std::sort(a + 1, a + 1 + n, greater<int>());  // sort descendingly
```

```cpp
struct data {
  int a, b;
  bool operator<(const data rhs) const {
    return (a == rhs.a) ? (b < rhs.b) : (a < rhs.a);
  }
} da[1009];
bool cmp(const data u1, const data u2) {
  return (u1.a == u2.a) ? (u1.b > u2.b) : (u1.a > u2.a);
}
// ......
std::sort(da + 1, da + 1 + 10);  // use the <operator defined in the structure to sort ascendingly
std::sort(da + 1, da + 1 + 10, cmp);  // use cmp function to compare, sort descendingly
```

### Strictly weak order

The sorting operator must satisfy the [strict weak ordering](https://en.wikipedia.org/wiki/Weak_ordering#:~:text=A%20strict%20weak%20ordering%20is,b%20%3C%20a%22%20is%20transitive.&text=For%20all%20x%2C%20y%2C%20z,x%20%3C%20z%20(transitivity).), otherwise there will be unpredictable situations (such as runtime error, can not be sorted correctly, etc).

The requirements of the strict weak order:

1. $x \not< x$ (non-reflexive)
2. If $x < y$ , then $y \not< x$ (asymmetry)
3. If $x < y, y < z$ , then $x < z$ (transitivity)
4. If $x \not< y, y \not< x, y \not< z, z \not< y$ , then $x \not< z, z \not< x$ (incomparable transitivity)

Common mistakes:

- Use `<=` to define the less-than operator in sorting.
- When calling the sorting operator, reading the external value may change the array. (commonly seen in the shortest path algorithm)
- The result of comparing the maximum and minimum values of multiple numbers is used as a sorting operator. (For example, the classic error in queens game/processing production scheduling, you may refer to the article [Talking about the application of neighbor exchange sorting and problems that need attention](https://ouuan.github.io/浅谈邻项交换排序的应用以及需要注意的问题/) (Original link in Chinese).
