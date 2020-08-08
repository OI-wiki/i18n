## Introduction

The hill climbing algorithm is a method of local selection. It uses a heuristic method and is an improvement to DFS. It uses feedback information to help generate solution decisions.

Frankly speaking, when the optimal solution cannot be reached directly, but it is possible to determine which of the two solutions is better, a new possible solution is generated based on some feedback information.

Therefore, the hill climbing algorithm searches for a new solution near the currently found optimal solution $x$ each time. If this new $x'$ is better, then moves to $x'$ , otherwise it remains unchanged.

This algorithm is obviously feasible for unimodal functions.

> Joke time:
> Q: Now that it is a unimodal function, why not use ternary search?
> A：In many years of OI, I have realized that human beings have their limits, no matter how scheming they are. The state is always unrepresentable. We can never get the mind of the people who create the problem and the boundary written is always wrong -- so -- I won't use ternary search anymore!

Seriously speaking, the advantage of the hill climbing algorithm is that when you don’t know how to write formal solutions (commonly used in computational geometry and mathematics problems), or when there are many dimensions of its own state, making it hard to implement divide and conquer (sample 2 can be completed by binary search), the optimal solution can be obtained through brute force.

But for most functions that need to be solved, the hill climbing algorithm can easily enter a local optimal solution, as shown in the figure below (the optimal solution is $\color{green}{\Uparrow}$ , and the optimal solution that the hill climbing algorithm may find is $\color{red}{\Downarrow}$ ).

![](./images/hill-climbing.png)

* * *

## Implementation

Hill climbing algorithm generally introduces the temperature parameters (similar to simulated annealing). In analogy, the hill climbing algorithm is like a rabbit jumping on the hill when it gets drunk. It will jump toward the higher place it thinks (this is often just an inaccurate trend) every time. Obviously it may jump to the top of the hill once, or jump too far to the opposite side. But it doesn't matter, the rabbit will always jump back after turning over the hill. Obviously this process is very useless, the rabbit will never find a way out, so in this process the rabbit calms down and is more cautious every time it jumps, jumping a little less, in order to reach the right optimal point.

The process of the rabbit gradually becoming awake is the cooling process, that is, the temperature parameter will continue to decrease when climbing the mountain.

About cooling: The cooling parameter is a constant slightly less than $1$ , generally selected within $[0.985, 0.999]$ .

### Sample 1 [「JSOI2008」Spherical space generator](https://www.luogu.com.cn/problem/P4035) 

Problem: Given $n$ points in $n$-dimensional space, knowing that they are on the same $n$-dimensional sphere, find the center of the sphere. $n \leq 10$ , and the absolute value of the coordinates does not exceed $10000$ .

Obviously, the unimodal function can be solved by hill climbing. The algorithm of this question is as follows:

1. Initialize the center of the sphere to the center of gravity of each given point (that is, its dimensional coordinates are the average value of the dimensional coordinates of all the given points) to reduce enumeration operations.
2. For the current sphere center, find the average of the Euclidean distance from each known point to the center of the sphere.
3. Traverse all known points. Record a change value $\textit{cans}$ (record each dimension separately) for the Euclidean distance of each point. If it is greater than the average value, add the difference to the change value, otherwise subtract it. In fact, there is no need to check the size, as long as the absolute value is not considered, the coordinates can be directly calculated. This process can be transformed into a new center of the sphere pushing it back and forth, pulling/pushing it when it is too far/close to the center of sphere.
4. Multiply the recorded $\textit{cans}$ by the temperature, update the center of the sphere, and go back to step 2.
5. End when the temperature is less than a given threshold.

Therefore, when we update the center of the sphere, we cannot directly add the changed value, but add the product of the changed value and the temperature.

Not every hill climbing problem can be solved with temperature specifically, this is just an example.

???+ Sample code
    ```cpp
    #include <bits/stdc++.h>
    using namespace std;
    double ans[10001], cans[100001], dis[10001], tot, f[1001][1001], seed = 718;
    int n;
    double check() {
      tot = 0;
      for (int i = 1; i <= n + 1; i++) {
        dis[i] = 0;
        cans[i] = 0;
        for (int j = 1; j <= n; j++)
          dis[i] += (f[i][j] - ans[j]) * (f[i][j] - ans[j]);
        dis[i] = sqrt(dis[i]);  // Euclidean distance
        tot += dis[i];
      }
      tot /= (n + 1);  // average
      for (int i = 1; i <= n + 1; i++)
        for (int j = 1; j <= n; j++)
          cans[j] += (dis[i] - tot) * (f[i][j] - ans[j]) /
                     tot;  // update the modified value for each dimension: Euclidean distance difference * difference contribution
    }
    int main() {
      srand(seed);
      cin >> n;
      for (int i = 1; i <= n + 1; i++)
        for (int j = 1; j <= n; j++) {
          cin >> f[i][j];
          ans[j] += f[i][j];
        }
      for (int i = 1; i <= n; i++) ans[i] /= (n + 1);     // initialization
      for (double t = 10001; t >= 0.0001; t *= 0.9999) {  // keep cooling down
        check();
        for (int i = 1; i <= n; i++) ans[i] += cans[i] * t;  // modification
      }
      for (int i = 1; i <= n; i++) printf("%.3f ", ans[i]);
    }
    ```

* * *

### Sample problem 2 [「BZOJ 3680」Balance point/KO XXX](https://www.luogu.com.cn/problem/P1337) 

> original link in Chinese

Problem: Find the weighted Fermat points of $n$ points.

The framework is similar, with a bit of physics knowledge.

???+ Sample code
    ```cpp
    #include <cmath>
    #include <cstdio>
    const int N = 10005;
    int n, x[N], y[N], w[N];
    double ansx, ansy;
    void hillclimb() {
      double t = 1000;
      while (t > 1e-8) {
        double nowx = 0, nowy = 0;
        for (int i = 1; i <= n; ++i) {
          double dx = x[i] - ansx, dy = y[i] - ansy;
          double dis = sqrt(dx * dx + dy * dy);
          nowx += (x[i] - ansx) * w[i] / dis;
          nowy += (y[i] - ansy) * w[i] / dis;
        }
        ansx += nowx * t, ansy += nowy * t;
        if (t > 0.5)
          t *= 0.5;
        else
          t *= 0.97;
      }
    }
    int main() {
      scanf("%d", &n);
      for (int i = 1; i <= n; ++i) {
        scanf("%d%d%d", &x[i], &y[i], &w[i]);
        ansx += x[i], ansy += y[i];
      }
      ansx /= n, ansy /= n;
      hillclimb();
      printf("%.3lf %.3lf\n", ansx, ansy);
      return 0;
    }
    ```

* * *

## Optimization

It is easy to think that we can climb the hill many times to get the best answers possible. Methods like this include modifying the initial state/modifying the cooling parameter/modifying the initial temperature, etc., and then create a global optimal solution to record the answer. After each hill climbing, the global optimal solution is updated.

The problem that may exist in this processing is timeout. Please use handmade large dataset to test parameters during competitive programming competitions.

## Disadvantage

In fact, the disadvantage of the hill climbing algorithm has been mentioned above: it is easy to fall into a local optimal solution. When the objective function is not a unimodal function, this disadvantage is fatal. So we have to introduce [simulated annealing](./simulated-annealing.md) next.
