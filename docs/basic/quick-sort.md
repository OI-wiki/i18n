## Algorithm

Quick sort is used to sort an array using [divide and conquer](./divide-and-conquer.md).

Quick sort contains three steps:

1. Divide the sequence into two parts (not to divide directly, but to ensure the relationship of relative size)
2. Recurse into two subsequences for quick sorting separately
3. No need to merge, because the sequence is already completely ordered

Unlike merge sort, first step of quick sort is not to directly divide into two sequences, but to ensure the relative size relationship during the division process.

The sequences in the third step are already ordered and the numbers in the first sequence are smaller than those in the second, so joining them together would be fine.

Specifically, the first step is to divide the sequence into two parts, and then ensure that the numbers in the former sub-sequence are smaller than the numbers in the latter sub-sequence.

How to achieve this? To ensure the average time complexity, a number $m$ is generally selected randomly as the boundary between two sub-sequences.

After that, maintain two pointers p and q, one after the other, and check whether the current number is placed in the position it should be placed in turn (front or back). After the current position is placed correctly, move the pointer to continue processing until the two pointers meet.

What if the current number is not placed correctly? For example, if the following pointer q encounters a number smaller than m, then you can swap the numbers at index p and q, and then move p back by one.

In fact, quick sort does not specify how to implement the first step in detail, whether it is the process of selecting m or division, there is not only one method of implementation.

Generally speaking, the average time complexity of quick sort is $O(n\log n)$ , and the worst time complexity is $O(n^2)$ , which is almost impossible to achieve the worst case in practice. And because the memory access of quick sort follows the principle of locality, in most cases, the performance of quick sort is much better than other sorting algorithms with time complexity of $O(n \log n)$ such as heap sort.

In fact, using the [Median of Medians](https://en.wikipedia.org/wiki/Median_of_medians) algorithm in the process of selecting m can guarantee the worst time complexity of $O(n\log n)$ . However, due to its complexity of coding, it is generally not used in practice.

## Find the k-th largest number in linear time complexity

To find the k-th largest element ([K-th order statistic](https://en.wikipedia.org/wiki/Order_statistic#:~:text=In%20statistics%2C%20the%20kth%20order,to%20its%20kth%2Dsmallest%20value.&text=Important%20special%20cases%20of%20the,median%20and%20other%20sample%20quantiles.)), the simplest solution is to sort first, and then directly find the element at the k-th index. The time complexity is $O(n\log n)$ , which is not really cost-effective. In fact, we have a solution with time complexity of $O(n)$ .

Consider the dividing process of quick sort. After the "division" of quick sort is over, the sequence $A_{p} \cdots A_{r}$ is divided into $A_{p} \cdots A_{q}$ and $A_{q+1} \cdots A_{r}$ . According to the relationship between the number of elements on the left ( $q - p + 1$ ) and the size of k, we can determine whether to solve recursively on the left or only on the right.

It can be proved that the expected valye of time complexity is $O(n)$ .

### Reference

 <https://stackoverflow.com/questions/22339240/what-algorithms-are-used-in-c11-stdsort-in-different-stl-implementations> 

 <https://en.cppreference.com/w/cpp/algorithm/sort> 

 <http://irootlee.com/juicer_locality/> (Original link in Chinese)