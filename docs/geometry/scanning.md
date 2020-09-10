## Introduction

Scanning lines are usually used on the graphics. It is very similar to its literal meaning, that is, a line sweeps across the entire map. It is generally used to solve questions like graphic area, perimeter and other.

## Atlantis problem

### Description

In a two-dimensional coordinate system, given the lower left and upper right coordinates of multiple rectangles, find the area of the figure formed by all rectangles.

### Solution

According to the figure below, it can be seen that the total area can be obtained directly using brute force solution. But what if the input is too large? At this time, we need to consider using the **scanning line** algorithm.

### Process

Now suppose we have a line and start scanning from bottom to top:

![](./images/scanning-1.png)

![](./images/scanning-2.png)

![](./images/scanning-3.png)

![](./images/scanning-4.png)

![](./images/scanning-5.png)

![](./images/scanning-6.png)

![](./images/scanning-7.png)

> The original version of above figures are made by [kk303](https://blog.csdn.net/kk303).

- As shown in the figure, we can divide the entire rectangle into small rectangles with different colors. Then the height of this small rectangle is the distance we swept across. And then there is one variable left, that is, the length of the rectangle that keeps changing.
- Our segment tree is used to maintain the length of the rectangle. We mark the upper and lower sides of each rectangle where the lower side is marked as $1$ , and the upper side is marked as $-1$ . Whenever we encounter a rectangle, we know the line that is marked as $1$ . We add the length of this rectangle, and when our scan reaches $-1$ , it means that this edge needs to be deleted, so we delete it. Using $1$ and $-1$ can easily reach this state.
- Please note that the segment tree here does not mean an end point of a line segment, instead, but an interval. So what we have to calculate is $r+1$ and $r-1$ .
- Also, [discretization](../misc/discrete.md) is required.

???+note "Code implementation"
    ```cpp
    #include <algorithm>
    #include <cstdio>
    #include <cstring>
    #define maxn 300
    using namespace std;
    
    int lazy[maxn << 3];  // the number of occurrences of this line segment
    double s[maxn << 3];
    
    struct node1 {
      double l, r;
      double sum;
    } cl[maxn << 3];  // segment tree
    
    struct node2 {
      double x, y1, y2;
      int flag;
    } p[maxn << 3];  // coordinates
    
    // define sort
    bool cmp(node2 a, node2 b) { return a.x < b.x; }
    
    // push up
    void pushup(int rt) {
      if (lazy[rt] > 0)
        cl[rt].sum = cl[rt].r - cl[rt].l;
      else
        cl[rt].sum = cl[rt * 2].sum + cl[rt * 2 + 1].sum;
    }
    
    // construct the tree
    void build(int rt, int l, int r) {
      if (r - l > 1) {
        cl[rt].l = s[l];
        cl[rt].r = s[r];
        build(rt * 2, l, (l + r) / 2);
        build(rt * 2 + 1, (l + r) / 2, r);
        pushup(rt);
      } else {
        cl[rt].l = s[l];
        cl[rt].r = s[r];
        cl[rt].sum = 0;
      }
      return;
    }
    
    // update
    void update(int rt, double y1, double y2, int flag) {
      if (cl[rt].l == y1 && cl[rt].r == y2) {
        lazy[rt] += flag;
        pushup(rt);
        return;
      } else {
        if (cl[rt * 2].r > y1) update(rt * 2, y1, min(cl[rt * 2].r, y2), flag);
        if (cl[rt * 2 + 1].l < y2)
          update(rt * 2 + 1, max(cl[rt * 2 + 1].l, y1), y2, flag);
        pushup(rt);
      }
    }
    
    int main() {
      int temp = 1, n;
      double x1, y1, x2, y2, ans;
      while (scanf("%d", &n) && n) {
        ans = 0;
        for (int i = 0; i < n; i++) {
          scanf("%lf %lf %lf %lf", &x1, &y1, &x2, &y2);
          p[i].x = x1;
          p[i].y1 = y1;
          p[i].y2 = y2;
          p[i].flag = 1;
          p[i + n].x = x2;
          p[i + n].y1 = y1;
          p[i + n].y2 = y2;
          p[i + n].flag = -1;
          s[i + 1] = y1;
          s[i + n + 1] = y2;
        }
        sort(s + 1, s + (2 * n + 1));  // discretization
        sort(p, p + 2 * n, cmp);  // sort the coordinates of the sides of the rectangle ascendingly
        build(1, 1, 2 * n);       // construct the tree
        memset(lazy, 0, sizeof(lazy));
        update(1, p[0].y1, p[0].y2, p[0].flag);
        for (int i = 1; i < 2 * n; i++) {
          ans += (p[i].x - p[i - 1].x) * cl[1].sum;
          update(1, p[i].y1, p[i].y2, p[i].flag);
        }
        printf("Test case #%d\nTotal explored area: %.2lf\n\n", temp++, ans);
      }
      return 0;
    }
    ```

## Practice problems

-  [「HDU1542」Atlantis](http://acm.hdu.edu.cn/showproblem.php?pid=1542) 

-  [「HDU1828」Picture](http://acm.hdu.edu.cn/showproblem.php?pid=1828) 

-  [「HDU3265」Posters](http://acm.hdu.edu.cn/showproblem.php?pid=3265)
