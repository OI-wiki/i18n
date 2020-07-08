## Introduction

RMQ is the abbreviation of [Range Maximum/Minimum Query](https://en.wikipedia.org/wiki/Range_minimum_query), which means the maximum (minimum) value of an interval.

In the following descriptions, the default initial array size is $n$ , and the default time complexity is $O($ data preprocessing $)-O($ single query $)$ .

## Monotonic stack

Since **OI wiki** already has a detailed [description](../ds/monotonous-stack.md) of monotonic stack, we will not get into details here.

Time Complexity: $O(m\log m)-O(\log n)$ 

Space Complexity: $O(n)$ 

## Sparse Table

Since **OI wiki** already has a detailed [description](../ds/sparse-table.md) of sparse table, we will not get into details here.

Time Complexity: $O(n\log n)-O(1)$ 

Space Complexity: $O(n\log n)$ 

## Segment Tree

Since **OI wiki** already has a detailed [description](../ds/seg.md) of segment tree, we will not get into details here.

Time Complexity: $O(n)-O(\log n)$ 

Space Complexity: $O(n\log n)$ 

## Four Russian

The [Method of Four Russians](https://en.wikipedia.org/wiki/Method_of_Four_Russians) is an algorithm based on ST table proposed by four Russian computer scientists.

The improvement made by the Four Russians algorithm based on the ST table is sequence blocking.

Specifically speaking, we divide the original array, let's call it array A, into blocks with equal length $S$, for a total of $n/S$ blocks.

For each block, we preprocess the elements within to get the minimum value of the block, then create an array B with a length of $n/S$, and precomputate the array B using the ST table.

At the same time, we also create a ST table for each fragmented block of array A.

When making queries, we can divide the query interval into no more than one continuous block interval of array B and no more than two continuous intervals within the entire block of array A. Obviously, these problems can be solved by interval query in the ST table.

When $S=\log n$ , the precomputation complexity reaches the optimal, $O((n / \log n)\log n+(n / \log n)\times\log n\times\log \log n)=O(n\log \log n)$ 。

Time complexity: $O(n\log \log n)-O(1)$ 

Space complexity: $O(n\log \log n)$ 

Of course, because we need to run three ST tables, the constant of this method is relatively large.

!!! note "Some minor algorithm optimizations"
    We found that when the two endpoints of a query belong to different blocks in array A, the query in the blocks of array A is about the prefix or suffix of each block.

    Obviously, these queries can be solved within the time complexity of $O(n)$ by preprocessing the answers.

    In this way, we only need to perform the query operation on the ST table at most once.

!!! note "Some algorithm optimizations[ONLY FOR REFERENCE]"
    Because the Four Russians algorithm is based on the ST table, and the competitive programming competition does not generally have a very strict requirement about time complexity, it can generally be replaced by the ST table(which is not very practical in algorithm competitions). Here we offer an improved version that is more practical in the contests.

    We set the block size to $\sqrt n$, precompute the RMQ of the prefix and suffix within each block, and then use brute force to precompute the RMQ between any consecutive blocks. For this solution, the time complexity is $O(n)$ .

    When querying, for those queries which the left and right endpoints are not in the same block, we can directly get the suffix RMQ of the block where left endpoint is located, the RMQ of the continuous block between the left and right endpoints, and the prefix RMQ of the block where right endpoint is located. The answer is the max/min value among the three.
    
    For those queries which the left and right endpoints are in the same block, we can brute-force to find the RMQ between the two points. The time complexity is $O(\sqrt n)$, but the expected value of a single query to the block containing both left and right endpoints is $ O(\frac{\sqrt n}{n})$, so the expected time complexity of this method is $O(n)$.

    In the competitive programming competitions, we don’t have to worry about the people in charge of creating problems abandon this algorithm, because we can fine-tune the block size randomly on the basis of $\sqrt n$, which largely prevents the worst case from happening when the algorithm being constructed according to a specific block size. And if the person who made the question wants to get rid of this method, the brute force solution might be enough to pass.

    This is an algorithm that expects the time complexity to reach the lower bound, and the difficulty of the code implementation and time complexity constant are relatively small. So it is more practical in the algorithm competitions.

    Note: The algorithm above refers to the solution of [P3793 Yuno rescues grandpa](https://www.luogu.com.cn/problem/P3793) (original post in Chinese).

## The application of Cartesian tree on RMQ

If you don't really know about Cartesian tree, please check out the [description here](../ds/cartesian-tree.md) 。

We find that the min/max value between two points on the original sequence is equal to the LCA weight of the two points on the Cartesian tree, which means that what we need to solve now is find the LCA between two points on the $O(n)-O(1)$ tree.

How to find the LCA of the tree already has a description in the [LCA](../graph/lca.md) section, so we will not get into details here.

What we need to use here is the LCA algorithm based on RMQ.

Some of you might be wondering: wait, why do we circle back to the RMQ question again?

Don't worry, let's find out the special nature of this RMQ problem:

Because the two adjacent nodes of the tree's dfs traversal sequence have the parent-child relationship, the depth difference between the two adjacent nodes is $\pm 1$. We generally refer to this type of the RMQ problem where the difference between two adjacent elements is 1 as the $\pm 1$ RMQ problem.

Based on this characteristic, we can now improve the Four Russians algorithm.

Since the bottleneck of the Four Russian algorithm is the RMQ problem within the blocks, we focus on the optimization of it.

Because the difference between two adjacent numbers is $\pm 1$, the number of the right sequence types whose length does not exceed $\log n$ when fixing the left endpoint number is $\sum_{i=1}^{i \ leq \log n} 2^{i-1}$, and this formula obviously does not exceed $n$.

This suggests that we can precompute the minimum value of all cases that do not exceed $n$, that is, the value of the first element.

During precomputation, we need to precompute the difference between two adjacent numbers in the same block, and use binary to represent it.

When querying, we can find the binary representation corresponding to the query interval, and look up the answer in the table.

In this way, the time complexity of Four Russians precomputation is optimized to $O(n)$.

Combining the Cartesian tree part, we can realize the RMQ problem of $O(n)-O(1)$.

The code and sample questions have already been given [here] (../graph/lca.md) in the LCA section, so we won't repeat it here.

Of course, due to the large number of conversion steps, the $O(n)-O(1)$ RMQ runs relatively slower.

If the data is random, we can also do a brute-force search on the Cartesian tree. The time complexity is the expected value of $O(n)-O(\log n)$, and the complexity constant of this algorithm in the actualy implementation is often small.
