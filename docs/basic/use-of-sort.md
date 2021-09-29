Last translate with upstream: [58b9fe6](https://github.com/OI-wiki/OI-wiki/commit/58b9fe67d667d265261d733b70b90e6cf0eaefdd#diff-397b4d966765a70b3a6dadccf6a7d4285ae8f7f87cea4cc8cf43de673289eadf) on Feb 8, 2021.

This article will briefly introduce the usage of sorting.

## Reducing Time Complexity

Using sort, we can reduce the time complexity required to solve the problem.

???+note "[Example] Check whether an array have equivalent elements"
    Consider a sequence of numbers and you need to check whether there are any equal elements.

    A straightforward solution is to check each pair of elements and determine whether they are equal. The time complexity is $O(n^2)$ .

    We might as well sort this sequence of numbers first, and then it is not difficult to find that if there are two equal numbers, they must be in adjacent positions in the new sequence. At this point, you only need to scan the new sequence for the time complexity of $O(n)$ .
    
    The total time complexity is the sorting time complexity ( $O(n\log n)$ ).

## Preprocessing work for searching

Sorting is also the preprocessing work for [binary search](./binary.md). By making binary searches after sorting, we can find the specified element in the sequence within the time of $O(\log n)$ .
