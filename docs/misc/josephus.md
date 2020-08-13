The Joseph problem has existed for a long time, and its solution is constantly improving, but there is still no extremely efficient algorithm (log-level time complexity) to solve this problem.

## Problem description

> There are n people labeled as $0,1,\cdots, n-1$ standing in a counterclockwise circle. Starting from the person with index $0$, find the $k$-th person counterclockwise from the current person each time, and then let this person out. Who is the last one standing?

This classic question was proposed by Josephus in the first century AD, although he only considered the case of $k=2$ . Now we can use many efficient algorithms to solve this problem.

## Brute-force algorithm

The most brute-force algorithm is to enumerate directly. The process uses a circular linked list to enumerate and delete, and the answer can be obtained after n-1 repetitions. The time complexity is $\Theta (n^2)$ .

## Simple optimization

The process of finding the next person can be optimized with a segment tree. Specifically, create a segment tree of $0,1,\cdots, n-1$ , and then record the number of people remaining in each interval. Finding the location of the current person and the next $k$-th person can be done using binary searh on the segment tree.

## Linear algorithm

Let $J_{n,k}$ denote the answer to Josephus problem with size of $n,k$ . We have the following recursive formula:

$$
J_{n,k}=(J_{n-1,k}+k)\bmod n
$$

This is also easy to derive. You start counting $k$ people from $0$ , leaving $n-1$ people after the $k-1$-th person is out of the game. After you calculate the answer selected among the $n-1$ individuals, add a relative displacement $k$ to get the real answer. The time complexity of this algorithm is obviously $\Theta (n)$ .

```cpp
int josephus(int n, int k) {
  int res = 0;
  for (int i = 1; i <= n; ++i) res = (res + k) % i;
  return res;
}
```

## Logarithmic algorithm

For the case where $k$ is smaller and $n$ is larger, there is another algorithm with time complexity of $\Theta (k\log n)$ .

Consider that we delete one each time we move by $k$ , then we can delete $\left\lfloor\frac{n}{k}\right\rfloor$ within a circle, and leave $n-\ left\lfloor\frac{n}{k}\right\rfloor$ people. At this time we are in the position of the first $\left\lfloor\frac{n}{k}\right\rfloor\cdot k$ , which you may find that is equal to $n-n\bmod k$ . So we continue the recursive processing, and restore its relative position after the calculation. Then we have the following algorithm:

```cpp
int josephus(int n, int k) {
  if (n == 1) return 0;
  if (k == 1) return n - 1;
  if (k > n) return (josephus(n - 1, k) + k) % n;  // linear algorithm
  int res = josephus(n - n / k, k);
  res -= n % k;
  if (res < 0)
    res += n;  // mod n
  else
    res += res / (k - 1);  // restore location
  return res;
}
```

It can be proved that the time complexity of this algorithm is $\Theta (k\log n)$ . We assume the number of recursions in this process as $x$ , then the size of each problem will roughly become $\displaystyle n\left(1-\frac{1}{k}\right)$ , so we have 

$$
n\left(1-\frac{1}{k}\right)^x=1
$$

Solving this equation, we have

$$
x=-\frac{\ln n}{\ln\left(1-\frac{1}{k}\right)}
$$

Let’s turn to prove that the time complexity of the algorithm is $\Theta (k\log n)$ .

Consider that $\displaystyle \lim _{k \rightarrow \infty} k \log \left(1-\frac{1}{k}\right)$ , we have

$$
\begin{aligned}
\lim _{k \rightarrow \infty} k \log \left(1-\frac{1}{k}\right)&=\lim _{k \rightarrow \infty} \frac{\log \left(1-\frac{1}{k}\right)}{1 / k}\\
&=\lim _{k \rightarrow \infty} \frac{\frac{\mathrm d}{\mathrm d k} \log \left(1-\frac{1}{k}\right)}{\frac{\mathrm d}{\mathrm d k}\left(\frac{1}{k}\right)}\\
&=\lim _{k \rightarrow \infty} \frac{\frac{1}{k^{2}\left(1-\frac{1}{k}\right)}}{-\frac{1}{k^{2}}}\\
&=\lim _{k \rightarrow \infty}-\frac{k}{k-1}\\
&=-\lim _{k \rightarrow \infty} \frac{1}{1-\frac{1}{k}}\\
&=-1
\end{aligned}
$$

So $x \sim k \ln n, k\to \infty$ , that is, $-\dfrac{\ln n}{\ln\left(1-\frac{1}{k}\right)}= \Theta (k\log n)$ 

 **This page is mainly translated from the blog post [Задача Иосифа](https://e-maxx.ru/algo/joseph_problem) and its English version [Josephus Problem](https://cp-algorithms.com/others/josephus_problem.html) . The licence for the Russian version is Public Domain + Leave a Link; the licence for the English version is CC-BY-SA 4.0.** 
