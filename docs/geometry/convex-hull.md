## Two-dimensional convex hull

### Convex polygon

Convex polygon is a **simple polygon** in which all interior angles are within $[0,\pi]$ .

### Convex hull

The smallest convex polygon that can enclose all given points on the plane is called the convex hull.

It is defined as: for a given set $X$ , the intersection of all convex sets containing $X$ $S$ is called the **convex hull** of $X$.

In fact, it can be understood as a form that contains all given points with a rubber band.

The convex hull encloses all the given points with the smallest perimeter. If a concave polygon encloses all points, its perimeter must not be the smallest, as shown in the figure below. According to the triangle inequality, the convex polygon must be the optimal in perimeter.

![](./images/ch.png)

### How to find the convex hull

Common methods for finding convex hulls include Graham's scan and Andrew's algorithm. Here we will focus on introducing Andrew's algorithm.

#### Andrew's algorithm for finding the convex hull

First, sort all the points with the horizontal coordinate as the first keyword and the vertical ordinate as the second keyword.

Obviously, the smallest element and the largest element must be on the convex hull after sorting. And because it is a convex polygon, if we move counterclockwise starting from a point, the trajectory will always "turn left". Once there is a right turn, it means that this segment is not on the convex hull. So we can use a monotonic stack to maintain the upper and lower convex hulls.

Seeing from left to right, since the upper and lower convex hulls rotate in different directions seeing from left to right, we first **ascending enumeration** to find the lower convex hull, and then **descending** to find the upper convex hull to make the monotonic stack work.

When finding a convex hull, once the point $P$ that is about to be pushed into the stack and the rotation direction of two points on the top of the stack ( $S_1,S_2$ , where $S_1$ is the top of the stack) is right, i.e. the cross product is less than $0$, or $\overrightarrow{S_2S_1}\times \overrightarrow{S_1P}<0$ formally, pop the top of the stack, go back to the previous step, and continue testing until $\overrightarrow{S_2S_1}\times \overrightarrow{S_1P}\ge 0 $ or there is only one element left in the stack.

Normally, there is no need to keep the points on the edge of the convex hull, so the "$<$" in the above condition $\overrightarrow{S_2S_1}\times \overrightarrow{S_1P}<0$ can be changed to $\ le$ , and the latter condition should be changed to $>$ correspondingly.

???+note "Code implementation"
    ```cpp
    // stk[] is an integer array which stores subscript
    // p[] stores vectors or points
    tp = 0;                       // initialize stack
    std::sort(p + 1, p + 1 + n);  // sort the points
    stk[++tp] = 1;
    // the first element is added to the stack, and used(the variable) is not updated; so that 1 also updates the monotonic stack when the convex hull is closed at the end
    for (int i = 2; i <= n; ++i) {
      while (tp >= 2  // the * in the next line is overloaded as a cross product
             && (p[stk[tp]] - p[stk[tp - 1]]) * (p[i] - p[stk[tp]]) <= 0)
        used[stk[tp--]] = 0;
      used[i] = 1;  // used represents that the current state is on the convex hull
      stk[++tp] = i;
    }
    int tmp = tp;  // tmp represents the size of the lower convex hull
    for (int i = n - 1; i > 0; --i)
      if (!used[i]) {
        //      ↓does not affect the lower convex hull when finding the upper convex hull
        while (tp > tmp && (p[stk[tp]] - p[stk[tp - 1]]) * (p[i] - p[stk[tp]]) <= 0)
          used[stk[tp--]] = 0;
        used[i] = 1;
        stk[++tp] = i;
      }
    for (int i = 1; i <= tp; ++i)  // copy to the new array
      h[i] = p[stk[i]];
    int ans = tp - 1;
    ```

According to the code above, there are \textit{ans} elements on the final convex hull (the additional $1$ is also stored, so there are \textit{ans+1} elements in the $h$ array), and they are sorted counterclockwise. Perimeter is

$$
\sum_{i=1}^{ans}\left|\overrightarrow{h_ih_{i+1}}\right|
$$

### Sample problems

 [UVA11626 Convex Hull](https://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&category=78&page=show_problem&problem=2673) 

 [「USACO5.1」Fencing the Cows](https://www.luogu.com.cn/problem/P2742) (original link in Chinese)

 [POJ1873 The Fortified Forest](http://poj.org/problem?id=1873) 

 [POJ1113 Wall](http://poj.org/problem?id=1113) 

 [「SHOI2012」Credit Card Convex Hull](https://www.luogu.com.cn/problem/P3829) (original link in Chinese)
