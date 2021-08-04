Last translated with upstream: []()

This article will briefly introduce heapsort.

## Introduction

Heapsort is a sorting algorithm designed based on the data structure [binary heap](../ds/binary-heap.md). The suitable data structure of heapsort is array.

## Working Theory

It is a selection sort built on a heap essentially.

### Process of Sorting

Firstly construct a *max heap*. Then pop the top element of the heap as maximum element, swap it with the first element from the bottom of the array, and maintain the properties of the rest of heap.

Then pop the top element again as second maximum element, swap it with second element from the bottom of the array, maintain the properties of the rest of heap.

By doing so, after $n-1$ operations, the array is sorted

### Make Binary Heap on an Array

从根节点开始，依次将每一层的节点排列在数组里。

于是有数组中下标为 `i` 的节点，对应的父结点、左子结点和右子结点如下：

```cpp
iParent(i) = (i - 1) / 2;
iLeftChild(i) = 2 * i + 1;
iRightChild(i) = 2 * i + 2;
```

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
  // 建立父结点指标和子结点指标
  int dad = start;
  int son = dad * 2 + 1;
  while (son <= end) {  // 子结点指标在范围内才做比较
    if (son + 1 <= end &&
        arr[son] < arr[son + 1])  // 先比较两个子结点大小，选择最大的
      son++;
    if (arr[dad] >=
        arr[son])  // 如果父结点比子结点大，代表调整完毕，直接跳出函数
      return;
    else {  // 否则交换父子内容，子结点再和孙结点比较
      swap(arr[dad], arr[son]);
      dad = son;
      son = dad * 2 + 1;
    }
  }
}

void heap_sort(int arr[], int len) {
  // 从最后一个节点的父节点开始sift down以完成堆化(heapify)
  for (int i = (len - 1 - 1) / 2; i >= 0; i--) sift_down(arr, i, len - 1);
  // 先将第一个元素和已经排好的元素前一位做交换，再重新调整（刚调整的元素之前的元素），直到排序完毕
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
    # 建立父结点指标和子结点指标
    dad = int(start)
    son = int(dad * 2 + 1)
    while son <= end: # 子结点指标在范围内才做比较
        if son + 1 <= end and arr[son] < arr[son + 1]:
            son += 1 # 先比较两个子结点大小，选择最大的
        if arr[dad] >= arr[son]:
            return # 如果父结点比子结点大，代表调整完毕，直接跳出函数
        else: # 否则交换父子内容，子结点再和孙结点比较
            arr[dad], arr[son] = arr[son], arr[dad]
            dad = son
            son = int(dad * 2 + 1)

def heap_sort(arr, len):
  # 从最后一个节点的父节点开始sift down以完成堆化(heapify)
    i = (len - 1 - 1) / 2
    while(i >= 0):
        sift_down(arr, i, len - 1)
        i -= 1
  # 先将第一个元素和已经排好的元素前一位做交换，再重新调整（刚调整的元素之前的元素），直到排序完毕
    i = len - 1
    while(i > 0):
        arr[0], arr[i] = arr[i], arr[0]
        sift_down(arr, 0, i - 1)
        i -= 1
```

## External Links

- [Heapsort - Wikipedia](https://en.wikipedia.org/wiki/Heapsort)
