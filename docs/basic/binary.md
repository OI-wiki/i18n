## Bisection method

### Binary Search

[Binary search](https://en.wikipedia.org/wiki/Binary_search_algorithm#:~:text=In%20computer%20science%2C%20binary%20search,middle%20element%20of%20the%20array.), also known as half-interval search, logarithmic search, or binary chop, is a search algorithm used to find an element in an ordered array.

Take the example of finding a number in an ascending array.

Each time it examines the middle element of the current interval. If the middle element is just what we are looking for, then the search process is ended; if the middle element is less than the target value, which means the left side is smaller and no elements will be found there, it just needs to move to the right side; if the middle element is greater than the value found, same as above, the right side will only be larger and there will be no search elements. So it only needs to move to the left.

In the binary search process, the query interval is halved each time, so for an array of length $n$ , at most $O(\log n)$ searches will be performed.

```cpp
int binary_search(int start, int end, int key) {
  int ret = -1;  // if not foud, return -1
  int mid;
  while (start <= end) {
    mid = start + ((end - start) >> 1);  // directly to get the medium might cause overflow. (e.g. sum(start, end) > SYS.MAX)
    if (arr[mid] < key)
      start = mid + 1;
    else if (arr[mid] > key)
      end = mid - 1;
    else {  // The last test is equal because most search cases are either greater than or less than
      ret = mid;
      break;
    }
  }
  return ret;  // single output
}
```

??? note
    For the case where $n$ is a signed number, when you can guarantee $n\ge 0$ , `n >> 1` has fewer instructions than `n / 2`.

Please note that the order ew mention here is generalized. If the left or right side of an array meets a certain condition, and the other side does not, it can also be seen as an order ( e.g. If the satisfying condition is regarded as $1$ and the unsatisfying condition is regarded as $0$ , at least it is ordered for this dimension in this condition). In other words, the binary search algorithm can be used to find the largest (smallest) value that satisfies a certain condition.

What if we ask for the smallest maximum value that meets a certain condition(minimizing maximum value)? The first idea is to enumerate the "maximum value" as the answer from small to large, and then check whether it is legal. If the answer is monotonous, then you can use the binary search to find the answer faster.

If you want to use the binary search algorithm to solve this "minimize maximum" problem, it needs to meet the following three conditions:

1.  The answer is within a fixed interval;
2.  It may not be very easy to find a value that meets the condition, but it is required to be able to easily check whether a value is eligible
3.  The feasible solution satisfies a certain monotonicity for the interval. In other words, if $x$ is eligible, then $x + 1$ or $x-1$ is also eligible. (In this way, the monotony mentioned above is satisfied)

Of course, maximizing the minimum value follows the same rule.

The bisection method turns a problem of finding extreme values into a decision problem (use a binary search to find it). Like enumeration, we are enumerating all  possible answers. Now because of the monotonicity, we no longer need to enumerate one by one, using the bisection method, we can have a more optimal method to solve the "maximizing minimum" and "minimizing maximum" problems. This solution has also become a "bisection answer", commonly seen in problem-solving reports.

### Binary Search in STL

One thing worth noting is that for an ordered array you can use `std::lower_bound()` to find [the first number greater than or equal to your value](http://www.cplusplus.com/reference/algorithm/lower_bound/), and `std::upper_bound()` to find the [first greater than The number of your values](https://en.cppreference.com/w/cpp/algorithm/upper_bound).

Please note that it must be an ordered array, otherwise the answer is wrong.

For detailed usage, please refer to [STL](../lang/csl/index.md) 。

### Bisection solution

When solving questions, we often consider enumerating answers and then check whether the value is correct. If we replace the enumeration here with a bisection method, it becomes a "bisection answer".

Let’s take a look at a sample question [Luogu P1873 Cut Tree](https://www.luogu.com.cn/problem/P1873) (original link in Chinese). We can enumerate the answers from 1 to 1000000000 (1 billion), but this naive solution certainly would not receive full marks. Because running from 1 to 1 billion is too time-consuming. We can divide the answer from 100 to 1 billion, and check the feasibility every time (usually using the greedy method). **This is the bisection answer**.

The example solution for practice question is listed below: 

```cpp
int a[1000005];
int n, m;
bool check(int k) {  // check eligibility，k is the height of the saw
  long long sum = 0;
  for (int i = 1; i <= n; i++)       // check each tree
    if (a[i] > k)                    // if tree is higher than blade
      sum += (long long)(a[i] - k);  // add tree height
  return sum >= m;                   // if the minimum length is met, it is feasible
}
int find() {
  int l = 1, r = 1000000001;  // Because left side is closed, 1 is added to 1 billion
  while (l + 1 < r) {         // If two vertices are not adjacent
    int mid = (l + r) / 2;    // get the mid value
    if (check(mid))           // if possible 
      l = mid;                // increase blade height
    else
      r = mid;  // otherwise decrease
  }
  return l;  // return the left side value
}
int main() {
  cin >> n >> m;
  for (int i = 1; i <= n; i++) cin >> a[i];
  cout << find();
  return 0;
}
```

After reading the above code, you might be wondering about these 2 questions:

1.  Why is the search interval left-closed and right-open?

    Because in the end of search, it will look like this (take the legal maximum value as an example):

    ![](./images/binary-final-1.png)

    then it will

    ![](./images/binary-final-2.png)

    The legal minimum value would just be the opposite.

2.  Why return the left value?

    As shown above

## Ternary search

```cpp
lmid = left + (right - left >> 1);
rmid = lmid + (right - lmid >> 1);  // halve right side interval 
if (cal(lmid) > cal(rmid))
  right = rmid;
else
  left = lmid;
```

[Ternary search](https://en.wikipedia.org/wiki/Ternary_search) can be used to find the maximum (minimum) value of a [convex function](https://en.wikipedia.org/wiki/Convex_function).

Draw a picture would help you understand easier (Picture to be added)

-   
    If `lmid` and `rmid` are on the same side of the maximum (minimum) value:
    Then, due to the monotonicity, it must be either the larger (smaller) of the two that is closer to the maximum value, and the further interval cannot contain the maximum value, so it can be discarded.

-   
    If on both sides:
    Since the maximum value is in the middle of the two, after we discard an interval on both sides, it will not affect the maximum value, so we can discard it.


## Factorial programming

Fractional programming is a problem that each item has two attributes $c_i$ , $d_i$ , and it requires a certain amount of selected number, so that $\frac{\sum{c_i}}{\sum{d_i} }$ is the maximum or minimum.

Classic examples include optimal ratio loops, optimal ratio spanning trees, and so on.

Factorial programming can be solved using binary search. For details, please refer to [factorial programming](../misc/frac-programming.md).