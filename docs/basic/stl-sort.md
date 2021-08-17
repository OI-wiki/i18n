Last translate with upstream: [08eb0c5](https://github.com/OI-wiki/OI-wiki/commit/08eb0c53b1ad55b518b0f5f7a569c25b8c1215b2#diff-ed2f54cb97b0d5f18a33ec3aee84971f1e4d175d752ba48b9960ad318991206b) [PR #3333](https://github.com/OI-wiki/OI-wiki/pull/3333) on Jul 17, 2021.

This article will briefly introduce sorting algorithms implemented in C standard library and C++ standard template library.

Unless otherwise specified, all functions mentioned in this article are defined in header `<algorithm>`.

## qsort

Reference: [`qsort`](https://en.cppreference.com/w/c/algorithm/qsort), [`std::qsort`](https://en.cppreference.com/w/cpp/algorithm/qsort)

This function is an implementation of [quicksort](./quick-sort.md) in C standard library defined in `<stdlib.h>`. In C++ standard library it is defined in `<cstdlib>`.

## std::sort

Reference: [`std::sort`](https://en.cppreference.com/w/cpp/algorithm/sort)

Usage:

```cpp
// a[0] .. a[n - 1]: array needs to be sorted
std::sort(a, a + n);
// The above code directly modifies the order of elements in the array so that it is now sorted in ascending order.

// cmp is a custom comparison function
std::sort(a, a + n, cmp);  
```

`std::sort` is a sorting function in standard library that is more commonly used. The third parameter requires a binary comparison function. If `cmp` is not specified the array will be sorted from smallest to largest by default (or, `std::less<>`). 

The old version of the C++ standard only requires its **average** time complexity to reach $O(n\log n)$ , but since the C++11 standard requires its **worst** time complexity to reach $O( n\log n)$ 

However the C++ standard does not strictly specify the implementation of this function and it depends on the compiler used. In both [libstdc++](https://github.com/mirrors/gcc/blob/master/libstdc++-v3/include/bits/stl_algo.h) and [libc++](http://llvm.org/svn/llvm-project/libcxx/trunk/include/algorithm), [introsort](https://en.wikipedia.org/wiki/Introsort) is used.

## std::nth_element

Reference: [`std::nth_element`](https://en.cppreference.com/w/cpp/algorithm/nth_element)

Usage:

```cpp
std::nth_element(first, nth, last);
std::nth_element(first, nth, last, cmp);
```

It re-sorts elements between $[first, last)$, making the element pointed by $nth$ be the element at the same position in ordered version of $[first, last)$. Any elements before the new $n$-th element are equal to or smaller than the new $n$-th element.

The implementation is the unfinished introsort.

For the two usages, the C++ standard requires their average-case time complexity to be $O(n)$, where `n = std::distance(first, last)`.

Often used to build [K-D Tree](https://en.wikipedia.org/wiki/K-d_tree).

## std::stable_sort

Reference: [`std::stable_sort`](https://en.cppreference.com/w/cpp/algorithm/stable_sort)

Usage:

```cpp
std::stable_sort(begin, end);
std::stable_sort(begin, end, cmp);
```

Stable sort means that the relative positions of equal elements after the sorting are the same as the original sequence.

The time complexity is $O(n\log (n)^2)$, or $O(n\log n)$ if extra memory is available.

## std::partial_sort

Reference: [`std::partial_sort`](https://en.cppreference.com/w/cpp/algorithm/partial_sort)

Usage:

```cpp
std::partial_sort(first, mid, last);
std::partial_sort(first, mid, last, cmp);
```

Place the top $k$ smallest elements in the first $k$ positions in the sequence (the order of equal elements is not guaranteed), and the order of the remaining elements is not specified. If `cmp` is not specified the array will be sorted from smallest to largest by default (or, `std::less<>`). 

Time complexity: Approximately performing $(last-first)\log(mid-first)$ times `cmp()`.

Principle:

The principle of implementing `partial_sort` is to perform the `make_heap()` operation on the elements in the interval $[first, middle)$ in the original sequence to construct a max heap, and then take each element in $[middle, last)$ to compare with the $first$ — the maximum value in the heap. If it is less than the maximum value, the two elements are swapped, and the elements in $[first, middle)$ are adjusted to maintain the max heap. After the comparison, the elements in $[first, middle)$ are sorted by `sort_heap()` in ascending order. Please note that heap order is different ascending order.

## Define operator

Reference: [Operator Overloading](https://en.cppreference.com/w/cpp/language/operators).

For both built-in types (such as `int`) and user-defined structures, it is allowed to define a comparison function when calling the STL sorting function. You can pass a comparison function (usually the last parameter) when calling the function.

For user-defined structures, it is required to define at least one relationship operator or provide a comparison function before calling a STL sort function with it. Generally it is recommended to define `operator<`. [^note1]

Here are a few examples:

```cpp
int a[1009], n = 10;
// ......
std::sort(a + 1, a + 1 + n);                  // sort in ascending order
std::sort(a + 1, a + 1 + n, greater<int>());  // sort in descending order
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
std::sort(da + 1, da + 1 + 10);  // use the <operator defined in the structure to sort in ascending order
std::sort(da + 1, da + 1 + 10, cmp);  // use cmp function to compare, sort in descending order
```

### Strictly weak order

Reference: [Strict weak orderings](https://en.wikipedia.org/wiki/Weak_ordering#Strict_weak_orderings)
The sorting operator must satisfy the strict weak ordering, otherwise there will be unpredictable situations (such as runtime error, can not be sorted correctly, etc).

The requirements of the strict weak order:

1. $x \not< x$ (non-reflexive)
2. If $x < y$ , then $y \not< x$ (asymmetry)
3. If $x < y, y < z$ , then $x < z$ (transitivity)
4. If $x \not< y, y \not< x, y \not< z, z \not< y$ , then $x \not< z, z \not< x$ (incomparable transitivity)

Common mistakes:

- Use `<=` to define the less-than operator in sorting.
- When calling the sorting operator, reading the external value may change the array. (commonly seen in the shortest path algorithm)
- The result of comparing the maximum and minimum values of multiple numbers is used as a sorting operator. (For example, the classic error in queens game or processing production scheduling)

## External Links

- [Talking about the application of neighbor exchange sorting and problems that need attention](https://ouuan.github.io/浅谈邻项交换排序的应用以及需要注意的问题/) (Original link in Chinese).

## Footnotes

[^note1]: It is because most standard algorithms are using `operator<` for comparison.
