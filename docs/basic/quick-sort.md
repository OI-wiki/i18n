Last translate with upstream: [08eb0c5](https://github.com/OI-wiki/OI-wiki/commit/08eb0c53b1ad55b518b0f5f7a569c25b8c1215b2#diff-ea0b9b48dae6cd78146f9bde808d9630d61b1eb979a84522ca24ba3380f12514)(Jul 17, 2021)

This article will briefly introduce quicksort.

## Introduction

Quicksort, as known as partition-exchange sort, is a widely used sorting algorithm.

## Basic Principles and Implementations

### Principles

The working principle of quicksort is to sort a sequence using [divide and conquer](./divide-and-conquer.md).

Quicksort contains three steps:

1. Divide the sequence into two parts (with relationship of relative size kept);
2. Recurse into two subsequences for quicksorting separately;
3. No need to merge, because the sequence is already completely ordered.

Unlike merge sort, the first step of quicksort is not to directly divide into two sequences, but to ensure the relative size relationship is kept during the division process. Specifically, the first step is to divide the sequence into two parts which ensure that the numbers in the former sub-sequence are all less than the numbers in the latter one. To ensure average time complexity, a number $m$ is generally selected randomly as the boundary between two sub-sequences.

After that, maintain two pointers $p$ and $q$, one after the other, and check whether the current number is placed in the position it should be placed in turn (front or back). What if the current number is not placed correctly? For example, if the following pointer $q$ encounters a number less than $m$, then you can swap the numbers at index $p$ and $q$, and then move $p$ back by one. After the current position is placed correctly, move the pointer to continue processing until the two pointers meet.

In fact, quicksort does not specify how to implement the first step in detail, whether it is the process of selecting $m$ or division, there is more than one implementation.

The sequences in the third step are already ordered and the numbers in the first sequence are all less than those in the second, so simply join them together directly.

### Implementation (C++) [^ref2]

```cpp
// C++ Version
struct Range {
  int start, end;
  Range(int s = 0, int e = 0) { start = s, end = e; }
};

template <typename T>
void quick_sort(T arr[], const int len) {
  if (len <= 0) return;
  Range r[len];
  int p = 0;
  r[p++] = Range(0, len - 1);
  while (p) {
    Range range = r[--p];
    if (range.start >= range.end) continue;
    T mid = arr[range.end];
    int left = range.start, right = range.end - 1;
    while (left < right) {
      while (arr[left] < mid && left < right) left++;
      while (arr[right] >= mid && left < right) right--;
      std::swap(arr[left], arr[right]);
    }
    if (arr[left] >= arr[range.end])
      std::swap(arr[left], arr[range.end]);
    else
      left++;
    r[p++] = Range(range.start, left - 1);
    r[p++] = Range(left + 1, range.end);
  }
}
```

### Implementation (Python) [^ref2]

```python
# Python Version
def quick_sort(alist, first, last):
    if first >= last:
        return
    mid_value = alist[first]
    low = first
    high = last
    while low < high:
        while low < high and alist[high] >= mid_value:
            high -= 1
        alist[low] = alist[high]
        while low < high and alist[low] < mid_value:
            low += 1
        alist[high] = alist[low]
    alist[low] = mid_value
    quick_sort(alist, first, low - 1)
    quick_sort(alist, low + 1, last)
```

## Properties

### Stability

Quicksort is an unstable sorting algorithm.

### Time Complexity

The best-case and average-case time complexity of quicksort is $O(n\log n)$. The worst-case time complexity of it is $O(n^2)$.

## Optimizations

### Straightforward Optimization 

If we only implement quicksort using basic principles described before (or just copy the straightforward template code), then it is barely possible pass [Luogu P1177 Quicksort Template](https://www.luogu.com.cn/problem/P1177) (Chinese), because some toxic data may make time complexity of straightforward implementation $O(n^2)$.

Thus, we need to apply optimizations to our straightforward quicksort. Most commonly used optimization ideas are listed below: [^ref3]

- Choose pivot of two sub-sequence by picking the medium among first element, last element and middle element. By doing so can avoid degrading algorithm complexity brought by extreme input (e.g., ascending or descending sequence);
- **Insertion sort** might be more efficient than quicksort when the sequence is relatively short.
- After every sorting, cluster elements which are equal to the pivot around the pivot. By doing so can avoid degeneracy of algorithm by extreme data (e.g., if most of elements in the sequence are equivalent)


Below are some relatively established ways to optimize quicksort.

### 3-way Radix Quicksort

3-way radix quicksort is a hybrid algorithm of [radix sort](./radix-sort.md) and quicksort. The idea of algorithm is based on the solution of [Dutch national flag problem](https://en.wikipedia.org/wiki/Dutch_national_flag_problem).

Being different from original quicksort, after picking three pivot $m$ randomly, the algorithm divides original sequence into three parts: less than, equal to, and greater than $m$. By doing so could cluster elements equal to the pivot to be around it.  

While processing array with duplicated values, 3-way radix quicksort is far more efficient than straightforward quicksort with best-case complexity of $O(n)$ 

The implementation of 3-way radix quicksort is very straightforward. Below is a C++ implementation of it.

```cpp
// C++ Version
// Template parameter should have a definition of less than `<` operator.
template <typename T>
// `arr` represents the array need to be sorted. `len` is the length of `arr`.
void quick_sort(T arr[], const int len) {
  if (len <= 1) return;
  // Choose the pivot randomly 
  const T pivot = arr[rand() % len];
  // i: Element being operated on;
  // j: First element equal to the pivot;
  // k: First element greater than the pivot.
  int i = 0, j = 0, k = len;
  // Perform a 3-way radix quicksort and divide the sequence into three parts:
  // - Elements less than the pivot;
  // - Elements equal to the pivot;
  // - Elements greater than the pivot.
  while (i < k) {
    if (arr[i] < pivot)
      swap(arr[i++], arr[j++]);
    else if (pivot < arr[i])
      swap(arr[i], arr[--k]);
    else
      i++;
  }
  // Recursively perform quicksort on two sub-sequences.
  quick_sort(arr, j);
  quick_sort(arr + k, len - k);
}
```

And this is an implementation in Python:

```python
# Python Version
def quick_sort(arr, l, r):
    if l >= r:
        return
    random_index = random.randint(l, r)
    pivot = arr[random_index]
    arr[l], arr[random_index] = arr[random_index], arr[l]
    i = l + 1
    j = l 
    k = r + 1
    while i < k:
        if arr[i] < pivot:
            arr[i], arr[j + 1] = arr[j + 1], arr[i]
            j += 1
            i += 1
        elif arr[i] > pivot:
            arr[i], arr[k - 1] = arr[k - 1], arr[i]
            k -= 1
        else: 
            i += 1
    arr[l], arr[j] = arr[j], arr[l]
    quick_sort(arr, l, j - 1)
    quick_sort(arr, k, r)
```

### Introsort[^ref4]

Introsort, or introspective sort, is a hybrid algorithm of quicksort and [heapsort](./heap-sort.md), invented by David Musser in 1997. Introsort is an optimization to quicksort, ensuring the worst-case time complexity of $O(n\log n)$.

Introsort restricts the maximum recursion depth of quicksort to $\lfloor \log_2n \rfloor$, beyond which it will converted to heapsort.

Started from June 2000, introsort becomes the implementation of `sort()` from `stl_algo.h` in SGI C++ STL.

## Find the k-th largest number in linear time complexity

In the following example code, the definition of $k$-th largest number is the number in $k$-th place when the sequence is in ascending order. (Index starts from 0.)

To find the $k$-th largest value (aka. $k$-th [order statistic](https://en.wikipedia.org/wiki/Order_statistic)) , the simplest solution is to sort first, and then directly find the element at the k-th index. The time complexity is $O(n\log n)$ , which is not really cost-effective. 

To solve the problem, we can use the idea from quicksort.Consider the dividing process of quicksort. After the "division" of quicksort is over, the array $A_{p} \cdots A_{r}$ is divided into $A_{p} \cdots A_{q}$ and $A_{q+1} \cdots A_{r}$ . According to the relationship between the number of elements on the left ( $q - p + 1$ ) and the size of k, we can determine whether to solve recursively on the left or only on the right.

It can be proved that the expected value of time complexity is $O(n)$ .

### Implementation (C++)

```cpp
// Template parameter should have a definition of less than `<` operator.
template <typename T>
// `arr` represents the array to search. `rk` represents the rank need to be searched. `len` is the length of `arr`.
T find_kth_element(T arr[], int rk, const int len) {
  if (len <= 1) return arr[0];
  // Choose the pivot randomly.
  const T pivot = arr[rand() % len];
  // i: Current operating element;
  // j: First element equal to the pivot;
  // k: First element greater than the pivot.
  int i = 0, j = 0, k = len;
  // Perform a 3-way radix quicksort and divide the sequence into three parts:
  // - Elements less than the pivot;
  // - Elements equal to the pivot;
  // - Elements greater than the pivot.
  while (i < k) {
    if (arr[i] < pivot)
      swap(arr[i++], arr[j++]);
    else if (pivot < arr[i])
      swap(arr[i], arr[--k]);
    else
      i++;
  }
  // Search for the $k$-th number recursively in different intervals based on the rank and two dividing lines. <!---这里有点问题-->
  // If the number of elements less than pivot is more than $k$, then the $k$-th largest element must be less than pivot.
  if (rk < j) return find_kth_element(arr, rk, j);
  // Otherwise, if the number of elements less than or equal to pivot is less than $k$, then the $k$-th largest element must be greater than pivot.
  else if (rk >= k)
    return find_kth_element(arr + k, rk - k, len - k);
  // Otherwise, pivot is the $k$-th largest element.
  return pivot;
}
```

## References and Footnotes

[^ref1]: [C++ 性能榨汁机之局部性原理 - I'm Root lee !](http://irootlee.com/juicer_locality/)

[^ref2]: [Quicksort - Wikibooks](https://en.wikibooks.org/wiki/Algorithm_Implementation/Sorting/Quicksort)

[^ref3]: [三种快速排序以及快速排序的优化(Three types of quicksort and their optimizations)](https://blog.csdn.net/insistGoGo/article/details/7785038)

[^ref4]: [introsort](https://en.wikipedia.org/wiki/Introsort)
