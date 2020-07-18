**There are many sorting algorithms**, and most of them are different in nature.

## Stability

Stability refers to whether the relative order of equal elements has changed after sorting.

Radix sort, counting sort, insertion sort, bubble sort, and merging sort are stable sorting algorithms.

Selection sort, heap sort, and quick sort are not stable sorting algorithms.

## Time complexity

Time complexity is used to measure the relationship between the running time of an algorithm and the input scale. Similarly, there is space complexity, which is used to describe the scale of the memory consumption of the algorithm.

The simple method of calculating the complexity is generally to count the number of executions of "simple operations", and sometimes it can be approximated by directly counting the number of cycles.

Time complexity is divided into worst time complexity, average time complexity, best time complexity and so on. The worst time complexity usually needs to be considered in the OI competitions, because it represents the lower bound of the algorithm's operation, and there will be no worse results in the evaluation.

The lower bound of the time complexity of the comparison-based sorting algorithms is $O(n\log n)$ .

Of course, there are ones without $O(n\log n)$ . The time complexity of counting sort is $O(n+w)$ , where $w$ represents the size of the input data.

When the key sequence is relatively ordered, the insertion sort is the fastest.
