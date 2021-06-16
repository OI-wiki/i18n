## Overview

Given $n$ points on a two-dimensional plane, find a pair of points with the closest Euclidean distance.

Here we will introduce a divide and conquer algorithm with time complexity of $O(n\log n)$ to solve this problem. This algorithm was proposed in 1975 by [Franco P. Preparata](https://en.wikipedia.org/wiki/Franco_P._Preparata), and was proven to be optimal under the decision tree model by Preparata and [Michael Ian Shamos](https://en.wikipedia.org/wiki/Michael_Ian_Shamos).

## Algorithm

Like the regular divide-and-conquer algorithm, we split this set of $n$ points into two sets $S_1, S_2$ of the same size, and recurse continuously. But there is a problem: how to merge? That is, how to find the nearest point pair of one point in $S_1$ and another point in $S_2$ ? Here we first assume that the time complexity of the merging operation is $O(n)$ , and the total complexity of the algorithm is $T(n) = 2T(\frac{n}{2}) + O(n) = O(n \log n)$ .

We first sort all points according to $x_i$ as 1st keyword and $y_i$ as 2nd keyword, and use the point $p_m (m = \lfloor \frac{n}{2} \rfloor)$ as the boundary point. The split point set is $A_1,A_2$ :

$$
A_1 = \{p_i \ \big | \ i = 0 \ldots m \}\\
A_2 = \{p_i \ \big | \ i = m + 1 \ldots n-1 \}
$$

And recursively, find the nearest point pair within these two point sets and assume the distances are $h_1, h_2$ , and set the smaller value as $h$ .

Now it's time to merge! We are trying to find such a set of point pairs, one of which belongs to $A_1$ and the other belongs to $A_2$ , and the distance between them is less than $h$ . Therefore, we put all the points whose difference between the abscissa and $x_m$ is less than $h$ into the set $B$ :

$$
B = \{ p_i \ \big | \ \lvert x_i - x_m \rvert < h \}
$$

For each point $p_i$ in $B$ , our current goal is to find a point that is also in $B$ to which the distance is less than $h$ . In order to avoid considering each other between two points, we only consider those points whose vertical coordinate is less than $y_i$ . Obviously for a legal point $p_j$ , $y_i-y_j$ must be less than $h$ . So we get a set $C(p_i)$ :

$$
C(p_i) = \{ p_j\ \big |\ p_j \in B,\ y_i - h < y_j \le y_i \}
$$

If we sort the points in $B$ according to $y_i$ , $C(p_i)$ will be easily obtained, that is, several consecutive points next to $p_i$ . 

From this we have the steps of merging:

1. Build the collection $B$ .
2. Sort the points in $B$ according to $y_i$ . The usual practice is $O(n\log n)$ , but we can optimize it to $O(n)$ (explained below).
3. For each $p_i \in B$ , consider $p_j \in C(p_i)$ . Calculate the distance for each pair of $(p_i,p_j)$ and update the answer (the closest point pair of the current set).

Please note that we mentioned two sorts above, because the point coordinates remain the same throughout. The first sorting can be done only once before the divide and conquer begins. We make each recursive return to the result of the current point set sorted by $y_i$ . For the second sorting, the upper layer directly uses the two separately sorted point sets of the lower layer to merge.

It seems that this algorithm is still not optimal, $|C(p_i)|$ will be in the order of $O(n)$ , leading to thw wrong time complexity. Actually this is not the case, because its maximum size is $7$, and we offer its proof below:

## Proof of complexity

We have learned that the vertical coordinates of all points in $C(p_i)$ are within the range of $(y_i-h,y_i]$ ; and the horizontal coordinates of all points in $C(p_i)$ , and $p_i$ itself, are all in the range of $(x_m-h,x_m+h)$ . This forms a rectangle of $2h \times h$ .

We then split this rectangle into two squares of $h \times h$ , regardless of $p_i$ , the point in one of the squares is $C(p_i) \cap A_1$ and the other is $C(p_i) \cap A_2$ , and the distance between any two points in the two squares is greater than $h$ . (Because they come from the same next layer recursion)

We split a square of $h \times h$ into four small squares of $\frac{h}{2} \times \frac{h}{2}$. It can be found that there are at most $1$ points in each small square: because the maximum distance between any two points in the small square is the length of the diagonal, that is, $\frac{h}{\sqrt 2}$, which is less than $ h$.

Therefore, there are at most $4$ points in each square and at most $8$ points in the rectangle. Remove $p_i$ itself, $\max(C(p_i))=7$ .

## Implementation

We use a structure to store points and define a function object for sorting:

???+note "Structure definition"
    ```cpp
    struct pt {
      int x, y, id;
    };
    
    struct cmp_x {
      bool operator()(const pt& a, const pt& b) const {
        return a.x < b.x || (a.x == b.x && a.y < b.y);
      }
    };
    
    struct cmp_y {
      bool operator()(const pt& a, const pt& b) const { return a.y < b.y; }
    };
    
    int n;
    vector<pt> a;
    ```

To facilitate recursion, we introduce the `upd_ans()` helper function to calculate the distance between two points and try to update the answer:

???+note "function to update answer"
    ```cpp
    double mindist;
    int ansa, ansb;
    
    inline void upd_ans(const pt& a, const pt& b) {
      double dist =
          sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y) + .0);
      if (dist < mindist) mindist = dist, ansa = a.id, ansb = b.id;
    }
    ```

Here is the recursion itself: suppose that `a[]` has been sorted by $x_i$ before the call. If $r-l$ is too small, use brute force algorithm to calculate $h$ and terminate the recursion.

We use `std::merge()` to perform the merge sort and create an auxiliary buffer `t[]` in which $B$ is stored.

???+note "main function"
    ```cpp
    void rec(int l, int r) {
      if (r - l <= 3) {
        for (int i = l; i <= r; ++i)
          for (int j = i + 1; j <= r; ++j) upd_ans(a[i], a[j]);
        sort(a + l, a + r + 1, &cmp_y);
        return;
      }
    
      int m = (l + r) >> 1;
      int midx = a[m].x;
      rec(l, m), rec(m + 1, r);
      static pt t[MAXN];
      merge(a + l, a + m + 1, a + m + 1, a + r + 1, t, &cmp_y);
      copy(t, t + r - l + 1, a + l);
    
      int tsz = 0;
      for (int i = l; i <= r; ++i)
        if (abs(a[i].x - midx) < mindist) {
          for (int j = tsz - 1; j >= 0 && a[i].y - t[j].y < mindist; --j)
            upd_ans(a[i], t[j]);
          t[tsz++] = a[i];
        }
    }
    ```

In the main function, start recursion like this:

???+note "Function call interface"
    ```cpp
    sort(a, a + n, &cmp_x);
    mindist = 1E20;
    rec(0, n - 1);
    ```

## Generalization: the smallest perimeter triangle on the plane

The above algorithm is interestingly extended to this problem: in a given set of points, select three points so that the sum of their distances is the smallest.

The algorithm remains largely unchanged. Each time it tries to find a triangle smaller than the current answer perimeter $d$ , put all the points whose distance between horizontal coordinates and $x_m$ is less than $\frac{d}{2}$ into the set $B$ , try to update the answer. (The longest side of the triangle with perimeter $d$ is less than $\frac{d}{2}$ )

## Non-divide and conquer algorithm

In fact, in addition to the divide and conquer algorithm mentioned above, there is another non-divide and conquer algorithm whose time complexity is also $O(n \log n)$ .

We can consider the idea of a common statistical sequence: for each element, add the contribution of itself and all the elements to its left into the answer. This way of thinking can also be used to solve the plane closest points problem.

Specifically, we sort all points according to $x_i$ as the first keyword and $y_i$ as the second keyword, and create a sorting order with $y_i$ as the first keyword and $x_i$ as the second keyword multiset. For each position $i$ , we do the following:

1. Delete all points satisfying $x_i-x_j >= d$ from the set. They will no longer contribute to the answer.
2. For all points in the set satisfying $\lvert y_i - y_j \rvert < d$ , count the distance between them and $p_i$ .
3. Insert $p_i$ into the collection.

Since each point will be inserted and deleted at most once, the time complexity of inserting and deleting points is $O(n \log n)$ , and the time complexity proof of the statistical answer part and the time complexity proof of the divide and conquer algorithm method is similar, and you may wish to give this a try.

??? "Template code"
    ```cpp
    #include <algorithm>
    #include <cmath>
    #include <cstdio>
    #include <set>
    const int N = 200005;
    int n;
    double ans = 1e20;
    struct point {
      double x, y;
      point(double x = 0, double y = 0) : x(x), y(y) {}
    };
    
    struct cmp_x {
      bool operator()(const point &a, const point &b) const {
        return a.x < b.x || (a.x == b.x && a.y < b.y);
      }
    };
    
    struct cmp_y {
      bool operator()(const point &a, const point &b) const { return a.y < b.y; }
    };
    
    inline void upd_ans(const point &a, const point &b) {
      double dist = sqrt(pow((a.x - b.x), 2) + pow((a.y - b.y), 2));
      if (ans > dist) ans = dist;
    }
    
    point a[N];
    std::multiset<point, cmp_y> s;
    
    int main() {
      scanf("%d", &n);
      for (int i = 0; i < n; i++) scanf("%lf%lf", &a[i].x, &a[i].y);
      std::sort(a, a + n, cmp_x());
      for (int i = 0, l = 0; i < n; i++) {
        while (l < i && a[i].x - a[l].x >= ans) s.erase(s.find(a[l++]));
        for (auto it = s.lower_bound(point(a[i].x, a[i].y - ans));
             it != s.end() && it->y - a[i].y < ans; it++)
          upd_ans(*it, a[i]);
        s.insert(a[i]);
      }
      printf("%.4lf", ans);
      return 0;
    }
    ```

## Practice problems

-  [UVA 10245 "The Closest Pair Problem"\[difficulty: low\]](https://uva.onlinejudge.org/index.php?option=onlinejudge&page=show_problem&problem=1186) 
-  [SPOJ #8725 CLOPPAIR "Closest Point Pair"\[difficulty: low\]](https://www.spoj.com/problems/CLOPPAIR/) 
-  [CODEFORCES Team Olympiad Saratov - 2011 "Minimum amount"\[difficulty: medium\]](http://codeforces.com/contest/120/problem/J) 
-  [Google CodeJam 2009 Final "Min Perimeter"\[difficulty: medium\]](https://code.google.com/codejam/contest/311101/dashboard#s=a&a=1) 
-  [SPOJ #7029 CLOSEST "Closest Triple"\[difficulty: medium\]](https://www.spoj.com/problems/CLOSEST/)

* * *

## References

 **The divide and conquer algorithm part in this page is mainly translated from the blog post [Нахождение пары ближайших точек](http://e-maxx.ru/algo/nearest_points) and its English version [Finding the nearest pair of points](https://github.com/e-maxx-eng/e-maxx-eng/blob/master/src/geometry/nearest_points.md). The copyright agreement for the Russian version is Public Domain + Leave a Link; the copyright agreement for the English version is CC-BY-SA 4.0.** 

 [Zhihu column: computational geometry-nearest point pair problem](https://zhuanlan.zhihu.com/p/74905629) 
