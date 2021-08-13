Last translated with upstream: [8eecffd](https://github.com/OI-wiki/OI-wiki/commit/8eecffd73630b0637ebf06fb0817c56dcf8d4858) ([PR #3408](https://github.com/OI-wiki/OI-wiki/pull/3408)) on Aug 7, 2021.

This article will briefly introduce heapsort.

## Introduction

Heapsort is a sorting algorithm designed based on the data structure [binary heap](../ds/binary-heap.md) suitable for applying on arrays.

## Working Principles

It is a selection sort built on a heap essentially.

### Process of Sorting

Firstly construct a *max heap*. Then pop the top element of the heap as maximum element, swap it with the last element in the array, and maintain the properties of the rest of heap.

Then pop the top element again as second maximum element, swap it with second element from the end of the array, and maintain the properties of the rest of heap.

By doing so, the array is sorted after $n-1$ operations.

### Make Binary Heap on an Array

Consider using an array to represent heap. The two child nodes of $h_i$ are $h_2i$ and $h_{2i+1}$. Root node is $h_1$

```cpp
iParent(i) = (i - 1) / 2;
iLeftChild(i) = 2 * i + 1;
iRightChild(i) = 2 * i + 2;
```
(An alternative description can be found on [Binary Heap - OI Wiki](../ds/binary-heap.md#Implementation).)

## Properties

### Stability

Heapsort is an unstable sorting algorithm due to swapping operations, just like selection sort.

### Time Complexity

The worst-case, average-case, best-case time complexity of heapsort are all $O(n\log n)$.

### Space Complexity

Heapsort is an in-place algorithm because it is possible to make heap on input array.

## Example Code Implementations

### C++

```cpp
// C++ Version
void sift_down(int arr[], int start, int end) {
  // Calculate pointer of parent and child nodes.
  int parent = start;
  int child = parent * 2 + 1;
  while (child <= end) {  // Only compare when child node is in given interval of subscript.
    // Firstly compare two child nodes and choose the greater.
    if (child + 1 <= end && arr[child] < arr[child + 1])  
      child++;
    // If parent node is greater than child node, the adjustment is complete and ready to return.
    if (arr[parent] >= arr[child])  
      return;
    else {  // Otherwise, swap parent and child node, and compare between child and child's child node.
      swap(arr[parent], arr[child]);
      parent = child;
      child = parent * 2 + 1;
    }
  }
}

void heap_sort(int arr[], int len) {
  // Heapify the array by performing sifting down from the parent node of the last node.
  for (int i = (len - 1 - 1) / 2; i >= 0; i--) 
    sift_down(arr, i, len - 1);
  // Firstly swap the first element and the element before ordered part of elements, then re-adjust remaining heap, until the array is sorted.
  for (int i = len - 1; i > 0; i--) {
    swap(arr[0], arr[i]);
    sift_down(arr, 0, i - 1);
  }
}
```

### Python

```python
# Python Version
def sift_down(arr, start, end):
    # Calculate pointer of parent and child nodes.
    parent = int(start)
    child = int(parent * 2 + 1)
    while child <= end: # Only compare when child node is in given range.
        # Firstly compare two child nodes and choose the greater.
        if child + 1 <= end and arr[child] < arr[child + 1]:
            child += 1 
        # If parent node is greater than child node, the adjustment is complete and ready to return.
        if arr[parent] >= arr[child]:
            return 
        else: # Otherwise, swap parent and child node, and compare between child and child's child node.
            arr[parent], arr[child] = arr[child], arr[parent]
            parent = child
            child = int(parent * 2 + 1)

def heap_sort(arr, len):
  # Heapify the array by performing sifting down from the parent node of the last node.
    i = (len - 1 - 1) / 2
    while(i >= 0):
        sift_down(arr, i, len - 1)
        i -= 1
  # Firstly swap the first element and the element before ordered part of elements, then re-adjust remaining heap, until the array is sorted.
    i = len - 1
    while(i > 0):
        arr[0], arr[i] = arr[i], arr[0]
        sift_down(arr, 0, i - 1)
        i -= 1
```

## External Links

- [Heapsort - Wikipedia](https://en.wikipedia.org/wiki/Heapsort)
