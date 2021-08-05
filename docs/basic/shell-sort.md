Last translate with upstream: []()

This article will briefly introduce the shellsort.

## Introduction

Shellsort is an optimization of [insertion sort](./insertion-sort.md). <!---「缩小增量排序法」找不到对应的名词，可能thesis翻得不够多-->Shellsort is named after its inventor, also known as reduced incremental sorting. 

## Working Theory

Shellsort compares and moves non-adjacent records:

1. Divide the sequence to be sorted into several sub-sequences (the elements of each sub-sequence have the same spacing in the original array);
2. Perform insertion sort on these sub-sequences;
3. Reduce the spacing between elements in each sub-sequence and repeat the above process until the spacing is reduced to 1.

## Properties

### Stability

Shellsort is an unstable sorting algorithm.

### Time Complexity

The best-case time complexity of shellsort is $O(n)$

The average-case and worst-case complexity of shellsort is related to the selection of the spacing sequence (that is, how the spacing is reduced to 1). For example, the complexity of the shellsort of "spacing divided by 3 each time" is $O(n^{3/2})$. The best worst-case time complexity of shellsort is $O(n \log^2n)$.

### Space Complexity

The space complexity of shellsort is $O(n)$

## Example Code Implementations

### C++[^ref1]

```cpp
// C++ Version
template <typename T>
void shell_sort(T array[], int length) {
  int h = 1;
  while (h < length / 3) {
    h = 3 * h + 1;
  }
  while (h >= 1) {
    for (int i = h; i < length; i++) {
      for (int j = i; j >= h && array[j] < array[j - h]; j -= h) {
        std::swap(array[j], array[j - h]);
      }
    }
    h = h / 3;
  }
}
```

### Python

```python
# Python Version
def shell_sort(array, length):
    h = 1
    while h < length / 3:
        h = int(3 * h + 1)
    while h >= 1:
        for i in range(h, length):
            j = i
            while j >= h and array[j] < array[j - h]:
                array[j], array[j - h] = array[j - h], array[j]
                j -= h
        h = int(h / 3)
```

## 参考资料与注释

[^ref1]: [Shellsort - Wikipedia](https://en.wikipedia.org/wiki/Shellsort)
