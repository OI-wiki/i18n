Assume you have $n$ tasks, and you are required to find a order with least cost to execute them. The time spent on the $i$-th task is $t_i$ , and the time spent by the $i$-th task waiting for $t$ is $f_i(t)$ .

Formally speaking, given $n$ functions $f_i$ and $n$ number $t_i$ , find a permutation $p$ to minimize:

$$
F(p)=\sum_{i=1}^nf_{p_i}\left(\sum_{j=1}^{i-1}t_{p_j}\right)
$$

## Special cost functions

### Linear cost function

First of all, we consider the case where all functions are linear functions, that is, $f_i(x)=c_ix+d_i$ , where $c_i$ is a non-negative integer. Obviously we can sum the constants first, so the function is transformed into $f_i(x)=c_ix$ .

Consider two permutations $p$ and $p'$ , where $p'$ is the permutation obtained by swapping the number in the $i$-th position of $p$ with the number in the $i+1$-th position. Then:

$$
\begin{split}
F(p')-F(p)&=c_{p'_i}\sum_{j=1}^{i-1}t_{p'_j}+c_{p'_{i+1}}\sum_{j=1}^{i}t_{p'_j}
-\left(c_{p_i}\sum_{j=1}^{i-1}t_{p_j}+c_{p_{i+1}}\sum_{j=1}^{i}t_{p_j}\right)\\
&=c_{p_i}t_{p_{i+1}}-c_{p_{i+1}}t_{p_i}
\end{split}
$$

So we use the sorting strategy that if $c_{p_i}t_{p_{i+1}}-c_{p_{i+1}}t_{p_i}>0$ , we swap, written in the form of $\dfrac{c_{p_i}}{t_{p_i}}>\dfrac{c_{p_{i+1}}}{t_{p_{i+1}}}$ , it can be understood as sorting ascendingly according to $\dfrac{c_i}{t_i}$ .

To deal with this problem, we need to consider the transformation after small change and greedily select the optimal solution.

### Exponential cost function

Consider the form of the cost function as $f_i(x)=c_ie^{ax}$ , where $c_i\ge 0,a>0$ .

We follow the previous method and consider the change in cost caused by swapping the elements at $i$ and $i+1$ . The algorithm obtained is to sort the array in ascending order of $\dfrac{1-e^{at_i}}{c_i}$ .

### The same monotonically increasing function

We consider that all $f_i(x)$ are the same monotonically increasing function. Obviously we can sort the array in ascending order according to $t_i$ .

## Livshits-Kladov theorem

The Livshits-Kladov theorem is valid if and only if the cost function is one of the following three cases:

- Linear function: $f_i(t) = c_it + d_i$ , among them $c_i\ge 0$ ;
- Exponential function: $f_i(t) = c_i e^{a t} + d_i$ , among them $c_i,a>0$ ;
- Same monotonically increasing function: $f_i(t) = \phi(t)$ , where $\phi(t)$ is a monotonically increasing function.

The theorem is proved under the assumption that the cost function is sufficiently smooth (there is a third derivative). In these three cases, the optimal solution of the problem can be solved in $O(n\log n)$ by a simple sorting.

* * *

 **Part of this page is translated from the blog post [Задача Джонсона с одним станком](http://e-maxx.ru/algo/johnson_problem_1) and its English version [Scheduling jobs on one machine](https://cp-algorithms.com/schedules/schedule_one_machine.html). The copyright license for the Russian version is Public Domain + Leave a Link; And the copyright license for the English version is CC-BY-SA 4.0.**

