Last translate with upstream: [08eb0c5](https://github.com/OI-wiki/OI-wiki/commit/08eb0c53b1ad55b518b0f5f7a569c25b8c1215b2#diff-fe072ff43c0ab8facb3edd321f4ac26c2d1239221c37b5bc93fa00eddbd69c51)

This article will briefly introduce sorting algorithms.

## Introduction

In computer science, a **sorting algorithm** is an algorithm that puts a specific group of data into some order. There are many sorting algorithms, and most of them have different natures.

## Properties

### Stability

Stability refers to whether the relative order of equal elements has changed after sorting.

Sorting algorithm with stability will preserve the relative order of equal elements. That is, when we call that a sorting algorithm is stable, we mean that if there are two records $R$ and $S$ compared as equal, and in the original list $R$ comes before $S$, then in sorted list $R$ will also comes before $S$.

Radix sort, counting sort, insertion sort, bubble sort, and merging sort are stable sorting algorithms.

Selection sort, heap sort, and quick sort are not stable sorting algorithms.

### Time complexity

Main article: [Complexity](./complexity.md)

Time complexity is used to measure the relationship between the running time of an algorithm and the input scale. Commonly it is represented as $O()$

The simple method of calculating the complexity is generally to count the number of executions of elementary operations, and sometimes it can be approximated by directly measuring the number of loops.

Time complexity is divided into worst-case complexity, average-case complexity, best-case complexity and so on. The worst-case complexity usually needs to be considered in competitive programming, because it represents the algorithm's worst performance, and no input will bring performance worse than that.

The lower bound of the time complexity of the comparison-based sorting algorithms is $O(n\log n)$ .

Of course, there are ones that are not $O(n\log n)$ . E.g., the time complexity of counting sort is $O(n+w)$ , where $w$ represents the size of the range of input data.

Here is an animated illustration of comparison among different sorting algorithms:

![Comparison among different sorting algorithms](images/sort-intro-1.gif)

### Space Complexity

Similar to time complexity, we use space complexity to describe the size consumed by an algorithm. Generally, the smaller the space complexity, the better the algorithm.

## External Links

- [Sorting Algorithms - Wikipedia](https://en.wikipedia.org/wiki/Sorting_algorithm)
