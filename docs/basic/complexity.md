author: linehk
translator: CamberLoid

Time complexity and space complexity are important criteria to measure the efficiency of an algorithm.

## Count of Elementary Operation 

An algorithm has different performance in different computers. It is hard to calculate actual performance theoretically, or troublesome to measure it. Thus, we more usually consider the count of elementary operations required by the algorithm rather than the actual time used.

For a common computer, basic arithmetic, accessing or assignments to variables (of standard data types, the same below), all can be treated as elementary operations.

The count or estimation of elementary operations can be criteria when evaluating the efficiency of an algorithm. 

## Time Complexity

To evaluate the performance of an algorithm, it is required to take the data scale<!---「数据规模」是这么翻译的喵？-->, which mostly referring to the counts of numbers inputted, the counts of points or edges of a graph inputted, into consideration. Generally, the larger the data scale, the longer the algorithm performs. But when we evaluate the performance in competitive programming, the most important is not its time cost in a specific data scale, but its trend with the data scale growing, as known as **time complexity**.

The main reasons for considering in this way are listed below:

1. Modern computers are capable to process billions or more elemental operations, so the data scale we need to process is usually very large. For example, assume that algorithm A has a time cost of $100n$ for proceeding data of $n$ size, and algorithm B's time cost is $n^2$. Algorithm B takes less time when the data scale is less than $100$. But in one second algorithm A can proceed data on the scale of millions, while algorithm B only on the scale of thousands. Thus, with the longer acceptable processing time, time complexity has far more obvious impact on the scale of processable data than the impact of time cost at the same data scale.
2. We use the counts of elementary operations to represent the time cost of an algorithm. However, different kinds of elementary operations' time cost differs, for example, time cost of addition and subtraction is far less than division. By ignoring the difference between different kinds and counts of operations when calculating time complexity, we can eliminate the impact of different time cost between operations.

Of course, the running time of an algorithm is not entirely determined by the input scale, but is also correlated with the content of the input. Therefore, the time complexity is further divided into several categories. For example:

1. Worst-case time complexity, which the largest input scale corresponds for each input scale. In competitive programming, since the input can be given arbitrarily in given data scale, to ensure an algorithm can proceed any data in some scale in time, we generally take worst-case time complexity into consideration.
2. Average-case time complexity, which is the average of the complexity on every possible inputs of a given size for every scale of data scale. (Or, the expected complexity on random input.)

As "the trend of time cost's growing with data scale's increasing" is an ambiguous concept, we need to represent the time complexity formally using **asymptotic notation** introduced below.

## Asymptotic Notation

Briefly, the asymptotic notation ignored the slower growing part of a function and its coefficient and constants, but preserved the important part representing the growing trend of this function. <!---这部分过于math需要指导-->

### Θ-Notation

For function $f(n), g(n)$, 
$$ f(n) = \Theta(g(n))$$ 
If and only if:
$$\exists c_1,c_2,n_0>0\colon \forall n \ge n_0, 0\le c_1\cdot g(n)\le f(n) \le c_2\cdot g(n)$$

Which is, in plain language, if $f(n) = \Theta(g(n))$, then we can find two positive numbers $c_1, c_2$, <!---不会了，ksyx救我-->

For example $3n^2+5n-3=\Theta(n^2)$,$n\sqrt n + n\log^5 n+m\log m+nm=\Theta(n\sqrt n+m\log m+nm)$.

### Big O Notation

Θ-Notation gives us upper and lower bound of a function in the same time.<!---Wondering for better expression--> We can use big O notation<!---is it necessary to use math expression?(the same below)--> if we only know its asymptotical upper bound but not lower, which is
$$f(n)=O(g(n))$$, 
if and only if 
$$\exists c,n_0\colon \forall n \ge n_0,0\le f(n)\le c\cdot g(n)$$

It is more common to use big O notation while researching time complexity, as we are usually concerned with the upper bound of the program's time cost rather than the lower bound.

Note that the "upper" and "lower" bounds here are for the trend of the function, not for the algorithm, whose upper case refers to worst-case time complexity but not big O notation. Therefore, using Θ-notation is completely viable to represent worst-case time complexity, and it can even be said that Θ-notation is more accurate than big O notation. As for the main reason for using O notation more often, one is we sometimes can prove the upper bound rather than lower bound (this is usually the case for more complicated algorithm and its complexity analysis), and the other is O is easier to input in a computer. 

### Ω-Notation

Similarly, we use Ω-Notation to describe the asymptotical lower bound of a function:
$$f(n)=\Omega(g(n))$$ 
If and only if
$$\exists c,n_0 \forall n \ge n_0\colon0\le c\cdot g(n)\le f(n)$$

### o-Notation

If $O$ notation is equivalent to the less-than-or-equal sign, then $o$ notation(or small o notation) is equivalent to the less-than sign. The definition is:
$$f(n)=o(g(n))$$
If and only if
$$\forall c > 0, \exists n_0 \forall n \ge n_0\colon 0\le f(n)< c\cdot g(n)$$

### ω-Notation

If $\Omega$ notation is equivalent to the greater-than-or-equal sign, then $\omega$ notation(or small omega notation) is equivalent to the greater-than sign. The definition is:
$$f(n)=o(\omega(n))$$
If and only if
$$\forall c > 0, \exists n_0 \forall n \ge n_0\colon 0\le c\cdot g(n)< f(n)$$

![](images/order.png)

### Common Properties

- $f(n) = \Theta(g(n))\Leftrightarrow f(n)=O(g(n))\land f(n)=\Omega(g(n))$
- $f_1(n) + f_2(n) = O(\max(f_1(n), f_2(n)))$
- $f_1(n) \times f_2(n) = O(f_1(n) \times f_2(n))$
- $\forall a \neq 1, \log_a{n} = O(\log_2 n)$。From the logarithm's change-of-base formula, we can conclude that, regardless of base, any logarithmic function has the same growth rate. Therefore, the base of an logarithm is often omitted in asymptotic time complexity.

## Simple Examples of Calculating Time Complexity

### for-expression

```cpp
// C++ Version
int n, m;
std::cin >> n >> m;
for (int i = 0; i < n; ++i) {
  for (int j = 0; j < n; ++j) {
    for (int k = 0; k < m; ++k) {
      std::cout << "hello world\n";
    }
  }
}
```

```python
# Python Version
n = int(input())
m = int(input())
for i in range(0, n):
    for j in range(0, n):
        for k in range(0, m):
            print("hello world")
```

The time complexity of the code above is $\Theta(n^2m)$ if we consider the inputted value of $n$ and $m$ as the data scale. 

### DFS

While performing [depth-first search (article not translated)](../graph/dfs.md) on a graph with $n$ points and $m$ edges, as each point and edges will be accessed constant times, the complexity is $\Theta(n+m)$.

## Identify Constants

When we are going to perform several operations, how to determine whether these "several operations" will impact time complexity? e.g.:

```cpp
// C++ Version
const int N = 100000;
for (int i = 0; i < N; ++i) {
  std::cout << "hello world\n";
}
```

```python
# Python Version
N = 100000
for i in range(0, N):
    print("hello world")
```

If the value of $N$ is not considered as data scale of input, then time complexity of these blocks of code is $O(1)$.

When performing time complexity calculation, it is important to figure out which variable should be treated as the size of data scale. All other variables not relating to inputting data scale will be treated as constants, which will be treated as $1$(or constant time) when calculating time complexity. 

## Master Theorem

By using [master theorem](https://en.wikipedia.org/wiki/Master_theorem_(analysis_of_algorithms)) we can quickly calculate the time complexity of a recursive algorithm.

Assume we have a recurrence relation formula,

$$
T(n) = a T\left(\frac{n}{b}\right)＋f(n)\qquad \forall n > b
$$

Then, 

$$
T(n) = \begin{cases}\Theta(n^{\log_b a}) & f(n) = O(n^{\log_b a-\epsilon}) \\ \Theta(f(n)) & f(n) = \Omega(n^{\log_b a+\epsilon}) \\ \Theta(n^{\log_b a}\log^{k+1} n) & f(n)=\Theta(n^{\log_b a}\log^k n),k\ge 0 \end{cases}
$$

## 均摊复杂度

算法往往是会对内存中的数据进行修改的，而同一个算法的多次执行，就会通过对数据的修改而互相影响。

例如快速排序中的“按大小分类”操作，单次执行的最坏时间复杂度，看似是 $O(n)$ 的。
但是由于快排的分治过程，先前的“分类”操作每次都减小了数组长度，所以实际的总复杂度 $O(n \log n)$，分摊在每一次“分类”操作上，是 $O(\log n)$。

多次操作的总复杂度除以操作次数，就是这种操作的 **均摊复杂度**。

## 势能分析

势能分析，是一种求均摊复杂度上界的方法。
求均摊复杂度，关键是表达出先前操作对当前操作的影响。势能分析用一个函数来表达此种影响。

定义“状态”$S$：即某一时刻的所有数据。*在快排的例子中，一个“状态”就是当前过程需要排序的下标区间*

定义“初始状态”$S_0$：即未进行任何操作时的状态。*在快排的例子中，“初始状态”就是整个数组*

假设存在从状态到数的函数 $F$，且对于任何状态 $S$，$F(S) \geq F(S_0)$，则有以下推论：

设 $S_1,S_2, \cdots ,S_m$ 为从 $S_0$ 开始连续做 $m$ 次操作所得的状态序列，$c_i$ 为第 $i$ 次操作的时间开销。

记 $p_i = c_i + F(S_i) - F(S_{i-1})$，则 $m$ 次操作的总时间花销为

$$
\sum_{i=1}^m p_i + F(S_0) - F(S_m)
$$

（正负相消，证明显然）

又因为 $F(S) \geq F(S_0)$，所以有

$$
\sum_{i=1}^m p_i \geq \sum_{i=1}^m c_i
$$

因此，若 $p_i = O(T(n))$，则 $O(T(n))$ 是均摊复杂度的一个上界。

势能分析使用中有很多技巧，案例在此不题。

## 空间复杂度

类似地，算法所使用的空间随输入规模变化的趋势可以用 **空间复杂度** 来衡量。

## 计算复杂性

本文内容主要是从算法分析的角度对复杂度进行了介绍，如果有兴趣的话可以在 [计算复杂性](../misc/cc-basic.md) 进行更深入的了解。
