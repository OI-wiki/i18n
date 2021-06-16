## Introduction

Simulated annealing is a randomized algorithm. When the number of solutions for a problem is very large (infinite even) and is not a unimodal function, we often use simulated annealing to solve it.

* * *

## Implementation

According to the process of [hill climbing algorithm](./hill-climbing.md), we find that for a non-optimal solution near the current optimal solution, the hill climbing algorithm directly discards it. In many cases, we need to accept this non-optimal solution and jump out of this local optimal solution, which is the simulated annealing algorithm.

>  **What is annealing?**
> ref: Baidu Baike
>
> Annealing is a metal heat treatment process, which refers to slowly heating the metal to a certain temperature, keeping it for a sufficient time, and then cooling it at an appropriate speed. The purpose is to reduce the hardness, improve the machinability, eliminate residual stress, stabilize the size, reduce deformation and cracking tendency; refine the grain, adjust the structure, and eliminate the structure defects. Precisely speaking, annealing is a heat treatment process for materials, including metallic materials and non-metallic materials. Moreover, the annealing purpose of new materials is similar to that of traditional metal annealing.

Because the rule of annealing introduces more random factors, the probability for getting the optimal solution will greatly increase. So we can simulate this process and use the objective function as the energy function.

### Description of simulated annealing algorithm

First we summarize it in one sentence: if the solution of the new state is better, modify the answer, otherwise accept the new state with a certain probability.

We define the current temperature as $T$ , and the energy (value) difference between the new state and the known state (obtained by a random method from the known state) is $\Delta E$ ( $\Delta E\geqslant 0$ ) . The probability of a state transition (modifying the optimal solution) is

$$
P(\Delta E)=
\begin{cases}
1&\text{new state is better}\\
e^\frac{-\Delta E}{T}&\text{new state is not better}
\end{cases}
$$

 **Note**: Sometimes, in order to make the obtained solution better, we will try to get a better solution at the current temperature in a random state near the obtained solution after the simulated annealing is completed (the process is similar to that of simulated annealing).

### How to anneal(cool down)?

We have three parameters during simulated annealing: initial temperature $T_0$ , cooling coefficient $d$ , and termination temperature $T_k$ . Among them, $T_0$ is a relatively large number, $d$ is a number very close to $1$ but less than $1$ , and $T_k$ is a positive number close to $0$ .

First let the temperature $T=T_0$ , then follow the above steps to attempt a transfer, then let $T=d\cdot T$ . When $T<T_k$ , the simulated annealing process ends, and the current optimal solution is the final optimal solution.

Note that in order to make the solution more accurate, we usually do not directly take the current solution as the answer, but maintain the optimal value of all solutions encountered during the annealing process.

We quote a picture from [Wiki-Simulated annealing](https://en.wikipedia.org/wiki/Simulated_annealing) here (as the temperature decreases, the jump becomes less random and the optimal solution becomes more stable).

![](./images/simulated-annealing.gif)

* * *

## Code

The code here takes ["BZOJ 3680" Balance point/KO XXX](https://www.luogu.com.cn/problem/P1337) (finding a weighted Fermat point for $n$ points, original link in Chinese) as an example.

```cpp
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <ctime>

const int N = 10005;
int n, x[N], y[N], w[N];
double ansx, ansy, dis;

double Rand() { return (double)rand() / RAND_MAX; }
double calc(double xx, double yy) {
  double res = 0;
  for (int i = 1; i <= n; ++i) {
    double dx = x[i] - xx, dy = y[i] - yy;
    res += sqrt(dx * dx + dy * dy) * w[i];
  }
  if (res < dis) dis = res, ansx = xx, ansy = yy;
  return res;
}
void simulateAnneal() {
  double t = 100000;
  double nowx = ansx, nowy = ansy;
  while (t > 0.001) {
    double nxtx = nowx + t * (Rand() * 2 - 1);
    double nxty = nowy + t * (Rand() * 2 - 1);
    double delta = calc(nxtx, nxty) - calc(nowx, nowy);
    if (exp(-delta / t) > Rand()) nowx = nxtx, nowy = nxty;
    t *= 0.97;
  }
  for (int i = 1; i <= 1000; ++i) {
    double nxtx = ansx + t * (Rand() * 2 - 1);
    double nxty = ansy + t * (Rand() * 2 - 1);
    calc(nxtx, nxty);
  }
}
int main() {
  srand(time(0));
  scanf("%d", &n);
  for (int i = 1; i <= n; ++i) {
    scanf("%d%d%d", &x[i], &y[i], &w[i]);
    ansx += x[i], ansy += y[i];
  }
  ansx /= n, ansy /= n, dis = calc(ansx, ansy);
  simulateAnneal();
  printf("%.3lf %.3lf\n", ansx, ansy);
  return 0;
}
```

* * *

## Some techniques

### Block simulated annealing

Sometimes there are many peaks in the function, and it is difficult for simulated annealing to find the optimal solution.

At this point, you can divide the entire range into several segments, run simulated annealing for each segment, and then find the optimal one.

### Cutting time

There is a `clock()` function that returns the running time of the program.

You can replace `simulateAnneal();` in the main program with `while ((double)clock()/CLOCKS_PER_SEC <MAX_TIME) simulateAnneal();`. In this way, simulated annealing will continue running until the time limit is about to be exceeded.

Here `MAX_TIME` is a custom number slightly less than the time limit.

* * *

## Practice problems

> NOTE: All original links are in Chinese.

-  [「BZOJ 3680」Balance point/KO XXX](https://www.luogu.com.cn/problem/P1337) 
-  [「JSOI 2016」Bomb attack](https://loj.ac/problem/2076) 
-  [「HAOI 2006」Evenly split data](https://www.luogu.com.cn/problem/P2503) 
