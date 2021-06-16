author: Ir1d

## Introduction

The random incremental algorithm is an important algorithm for computational geometry. It does not require high theoretical knowledge, has low algorithm time complexity, and can be used in a wide range of applications.

The idea of Incremental Algorithm is similar to the mathematical induction method. Its essence is to turn a problem into a sub-problem of just one level smaller in scale. Add the current object after solving the sub-problem. If implemented recursively, :

$$
T(n)=T(n-1)+g(n)
$$

The incremental method is simple in form and can be applied to many geometric problems.

Incremental methods are often combined with randomization to avoid the worst-case scenarios.

## Minimum coverage circle problem

### Problem description

There are $n$ points on a plane. Find a circle with the smallest radius that can cover all points.

### Algorithm

Assuming that the circle $O$ is the smallest covering circle of the first $i-1$ points, add the $i$-th point, and do nothing if it is inside or on the edge of the circle. Otherwise, the new smallest covered circle must go through the $i$-thth point.

Then based on the $i$-th point (with a radius of $0$ ), repeat the above process to add the $j$-th point in sequence. If the $j$-th point is outside the circle, the smallest covered circle must pass through the $j$-th point Points.

Then based on the $i$th point (with a radius of $0$), repeat the above process to add the $j$th point in sequence. If the $j$th point is outside the circle, the smallest covered circle must pass through the $j$th point Points.

Repeat the above steps. (Because at most three points are needed to determine the minimum covering circle, so it is repeated three times)

After traversing all the points, the circle obtained is the smallest circle covering all the points.

 **Time complexity**:  $O(n)$ 

 **Space complexity**:  $O(n)$ 

??? note "Code implementation"
    ```cpp
    #include <cmath>
    #include <cstdio>
    #include <cstdlib>
    #include <cstring>
    #include <iostream>
    
    using namespace std;
    
    int n;
    double r;
    
    struct point {
      double x, y;
    } p[100005], o;
    
    inline double sqr(double x) { return x * x; }
    
    inline double dis(point a, point b) {
      return sqrt(sqr(a.x - b.x) + sqr(a.y - b.y));
    }
    
    inline bool cmp(double a, double b) { return fabs(a - b) < 1e-8; }
    
    point geto(point a, point b, point c) {
      double a1, a2, b1, b2, c1, c2;
      point ans;
      a1 = 2 * (b.x - a.x), b1 = 2 * (b.y - a.y),
      c1 = sqr(b.x) - sqr(a.x) + sqr(b.y) - sqr(a.y);
      a2 = 2 * (c.x - a.x), b2 = 2 * (c.y - a.y),
      c2 = sqr(c.x) - sqr(a.x) + sqr(c.y) - sqr(a.y);
      if (cmp(a1, 0)) {
        ans.y = c1 / b1;
        ans.x = (c2 - ans.y * b2) / a2;
      } else if (cmp(b1, 0)) {
        ans.x = c1 / a1;
        ans.y = (c2 - ans.x * a2) / b2;
      } else {
        ans.x = (c2 * b1 - c1 * b2) / (a2 * b1 - a1 * b2);
        ans.y = (c2 * a1 - c1 * a2) / (b2 * a1 - b1 * a2);
      }
      return ans;
    }
    
    int main() {
      scanf("%d", &n);
      for (int i = 1; i <= n; i++) scanf("%lf%lf", &p[i].x, &p[i].y);
      for (int i = 1; i <= n; i++) swap(p[rand() % n + 1], p[rand() % n + 1]);
      o = p[1];
      for (int i = 1; i <= n; i++) {
        if (dis(o, p[i]) < r || cmp(dis(o, p[i]), r)) continue;
        o.x = (p[i].x + p[1].x) / 2;
        o.y = (p[i].y + p[1].y) / 2;
        r = dis(p[i], p[1]) / 2;
        for (int j = 2; j < i; j++) {
          if (dis(o, p[j]) < r || cmp(dis(o, p[j]), r)) continue;
          o.x = (p[i].x + p[j].x) / 2;
          o.y = (p[i].y + p[j].y) / 2;
          r = dis(p[i], p[j]) / 2;
          for (int k = 1; k < j; k++) {
            if (dis(o, p[k]) < r || cmp(dis(o, p[k]), r)) continue;
            o = geto(p[i], p[j], p[k]);
            r = dis(o, p[i]);
          }
        }
      }
      printf("%.10lf\n%.10lf %.10lf", r, o.x, o.y);
      return 0;
    }
    ```

## Practice

> Original links in Chinese.

 [Minimum circle coverage](https://www.luogu.com.cn/problem/P1742) 

 [「HNOI2012」Archery](https://www.luogu.com.cn/problem/P3222) 

## References

 <http://www.doc88.com/p-007257893177.html> 

 <https://www.cnblogs.com/aininot260/p/9635757.html> 

 <https://wenku.baidu.com/view/162699d63186bceb19e8bbe6.html> 
