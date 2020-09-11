## Pick's theorem

Pick's theorem: Given A simple polygon whose vertices are all integral points, Pick’s theorem proves the relationship between its area ${\displaystyle A}$ , the number of internal points ${\displaystyle i}$ , and the number of points on the edge ${\displaystyle b}$ : ${\displaystyle A=i+{\frac {b}{2}}-1}$ .

Detailed proof: [Pick's theorem](https://en.wikipedia.org/wiki/Pick%27s_theorem) 

It has the following generalizations:

- The area of the graph composed of grid points is one unit. Pick's theorem still stands for parallelogram grid. For any triangle lattice, Pick's theorem is ${\displaystyle A=2 \times i+b-2}$ .

- For non-simple polygons ${\displaystyle P}$ , Pick’s theorem ${\displaystyle A=i+{\frac {b}{2}}-\chi (P)}$ , where ${\displaystyle \chi ( P))$ represents the **Euler characteristic** of $(\displaystyle P)$ .

- Higher-dimensional: Ehrhart polynomials.
- Pick's theorem is equivalent to Euler's formula ( ${\displaystyle V-E+F=2}$ ).

## Sample problem (POJ 1265)

### Topic

Given a simple polygon on a plane, find the points on the side, inside the polygon, and the area of the polygon.

### Solution

This topic includes the following three key points:

- The number of points covered by the line segment with the integral point as the vertex is $\gcd(\textit{dx},\textit{dy})$ , where $\textit{dx} and \textit{dy}$ are respectively the number of points covered by line horizontally and vertically. If $\textit{dx}$ or $\textit{dy}$ is $0$ , the number of points covered is $\textit{dy}$ **or** $\textit{dx}$ .
- Pick theorem: The area of a simple polygon with integral points as its vertices on the plane = the number of points on the side / 2 + the number of internal points + 1.
- The area of any polygon is equal to the sum of the cross product of the vector composed of two adjacent points and the origin in order (this can also be obtained by clockwise definite integral).

So this question is finished easily.

```cpp
#include <cmath>
#include <cstdio>
#include <iostream>
using namespace std;
const int MAXN = 110;
struct node {
  int x, y;
} p[MAXN];
inline int gcd(int x, int y) { return y == 0 ? x : gcd(y, x % y); }
inline int area(int a, int b) { return p[a].x * p[b].y - p[a].y * p[b].x; }
int main() {
  int t, ncase = 1;
  scanf("%d", &t);
  while (t--) {
    int n, dx, dy, x, y, num = 0, sum = 0;
    scanf("%d", &n);
    p[0].x = 0, p[0].y = 0;
    for (int i = 1; i <= n; i++) {
      scanf("%d%d", &x, &y);
      p[i].x = x + p[i - 1].x, p[i].y = y + p[i - 1].y;
      dx = x, dy = y;
      if (x < 0) dx = -x;
      if (y < 0) dy = -y;
      num += gcd(dx, dy);
      sum += area(i - 1, i);
    }
    if (sum < 0) sum = -sum;
    printf("Scenario #%d:\n", ncase++);
    printf("%d %d %.1f\n\n", (sum - num + 2) >> 1, num, sum * 0.5);
  }
  return 0;
}
```
