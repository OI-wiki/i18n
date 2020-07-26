Using sort, we can reduce the time complexity required to solve the problem.

Consider a sequence of numbers and you need to check whether there are any equal elements.

A naive solution is to check each pair of elements and determine whether they are equal. The time complexity is $O(n^2)$ .

We might as well sort this sequence of numbers first, and then it is not difficult to find that if there are two equal numbers, they must be in adjacent positions in the new sequence. At this point, you only need to scan the new sequence for $O(n)$ . The total time complexity is the sorting time complexity( $O(n\log n)$ ).

Sorting is also the preprocessing work for [binary search](./binary.md). By making binary searches after sorting, we can find the specified element in the sequence within the time of $O(\log n)$ .
