author: FFjet, ChungZH, frank-xjh, hsfzLZH1, Xarfa, AndrewWayne

### Bidirectional simultaneous search

Start BFS/DFS from the starting node and ending node on the state graph at the same time. If the search meets, it can be assumed that a solution is obtained.

The steps of bidirectional search:

```text
starting_node and target_node enters queue q
starting_node is marked as 1
target_node is marked as 2
while(queue q is not empty)
{
  expand s new nodes from q.front()
  
  if   the newly expanded node has been marked by other numbers
    then   both ends of the search meet
    then   the loop is ended
  
  if   s new nodes are expanded from the starting node
    then   mark s nodes as 1 and enter the queue q
    
  if   s new nodes are expanded from the ending node
    then   mark s nodes as 2 and enter the queue q
}
```

### Meet in the Middle

Meet in the middle is a searching technique that can be used when the input data size is small but is not small enough to use brute force solution. Its main idea is to divide the entire search process into two halves, search separately, and finally merge the results of the two halves. Since the time complexity of search is often exponential, a meet in the middle search can halve the exponent, and can also get the square root value the complexity.

???+note "Sample problem [「USACO09NOV」Lights](https://www.luogu.com.cn/problem/P2962) (original link in Chinese)"

    There are $n$ lamps. Each lamp is connected to several lamps, and each lamp has a switch. If you press the switch on one lamp, the switch status of this lamp and all the connected lamps will change. In the beginning, all the lights are off, and you need to turn on all the lights. Please find the minimum number of times to press the switch.

    $1\le n\le 35$ .

If we use a brute force DFS to search for the status of the light on and off, the time complexity is $O(2^{n})$ , which would obviously cause TLE. However, if we use the **Meet in the middle** search, the time complexity can be optimized to $O(n2^{n/2})$ . 

**Meet in the middle** search IS to let us first find the half of the state, that is, find the state that can be reached using only the switches numbered from $1$ to $\mathrm{mid}$ , and then find out the state when only the other half is used. If the lights turned on in the first half and the second half complement each other, we can combine these two parts and have a solution that turns on all lights. 

During the implementation, you can store the first half of the state and the minimum number of times to switch to each state in the `map`. When searching for the second half, each time a solution is found, it will be combined with the complementary solution of the first half to update the answer.

??? note "sample code"
    ```cpp
    #include <algorithm>
    #include <cstdio>
    #include <iostream>
    #include <map>
    
    using namespace std;
    
    typedef long long ll;
    
    int n, m, ans = 0x7fffffff;
    map<ll, int> f;
    ll a[40];
    
    int main() {
      cin >> n >> m;
    
      for (int i = 0; i < n; ++i) a[i] = (1ll << i);
    
      for (int i = 1; i <= m; ++i) {
        int u, v;
        cin >> u >> v;
        --u;
        --v;
        a[u] |= (1ll << v);
        a[v] |= (1ll << u);
      }
    
      for (int i = 0; i < (1 << (n / 2)); ++i) {
        ll t = 0;
        int cnt = 0;
        for (int j = 0; j < n / 2; ++j) {
          if ((i >> j) & 1) {
            t ^= a[j];
            ++cnt;
          }
        }
        if (!f.count(t))
          f[t] = cnt;
        else
          f[t] = min(f[t], cnt);
      }
    
      for (int i = 0; i < (1 << (n - n / 2)); ++i) {
        ll t = 0;
        int cnt = 0;
        for (int j = 0; j < (n - n / 2); ++j) {
          if ((i >> j) & 1) {
            t ^= a[n / 2 + j];
            ++cnt;
          }
        }
        if (f.count(((1ll << n) - 1) ^ t))
          ans = min(ans, cnt + f[((1ll << n) - 1) ^ t]);
      }
    
      cout << ans;
    
      return 0;
    }
    ```
