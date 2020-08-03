Trie, also called prefix tree or digital tree, is a tree like a dictionary.

## Introduction

Let's look at a figure first:

![trie1](./images/trie1.png)

It can be found that this trie uses edges to represent letters, and the path from the root node to a node on the tree represents a string. For example, $1\to4\to 8\to 12$ represents the string `caa`.

The structure of trie is very easy to understand. We use $\delta(u,c)$ to represent the next node pointed to by the $c$ character of the node $u$ , or it can be seen as adding a node of the string formed by the character $c$ after the string represented by the node $u$ . (The value range of $c$ is related to the size of the character set. It is not necessarily $0\sim 26$ .)

Sometimes it is necessary to mark which strings are inserted into trie, and each time the insertion is completed, mark the node represented by this string.

## Code implementation

Here we have a template for structure encapsulation:

```cpp
struct trie {
  int nex[100000][26], cnt;
  bool exist[100000];  // check whether the string at the end of the node exists

  void insert(char *s, int l) {  // insert the string
    int p = 0;
    for (int i = 0; i < l; i++) {
      int c = s[i] - 'a';
      if (!nex[p][c]) nex[p][c] = ++cnt;  // if not, then add node
      p = nex[p][c];
    }
    exist[p] = 1;
  }
  bool find(char *s, int l) {  // find the string
    int p = 0;
    for (int i = 0; i < l; i++) {
      int c = s[i] - 'a';
      if (!nex[p][c]) return 0;
      p = nex[p][c];
    }
    return exist[p];
  }
};
```

## Application

### Search strings

The most basic application of the trie - to find whether a string appeared in the "dictionary".

???+note "[So he started the wrong roll call](https://www.luogu.com.cn/problem/P2580) (original link in Chinese)"
    There are $n$ name strings, and we need to perform a roll call for $m$ times. Each time we need to answer one of "Name does not exist", "This name is clicked for the first time", or "This name has already been clicked".

    $1\le n\le 10^4$, $1\le m\le 10^5$, and the length of all strings does not exceed $50$ .

    ??? mdui-shadow-6 "Problem solution"
        Create trie for all names, and then query whether the string exists in trie and whether it has already been called. The first call is marked as called.

    ??? mdui-shadow-6 "Template code"
        ```cpp
        #include <cstdio>
        
        const int N = 500010;
        
        char s[60];
        int n, m, ch[N][26], tag[N], tot = 1;
        
        int main() {
          scanf("%d", &n);
        
          for (int i = 1; i <= n; ++i) {
            scanf("%s", s + 1);
            int u = 1;
            for (int j = 1; s[j]; ++j) {
              int c = s[j] - 'a';
              if (!ch[u][c]) ch[u][c] = ++tot;
              u = ch[u][c];
            }
            tag[u] = 1;
          }
        
          scanf("%d", &m);
        
          while (m--) {
            scanf("%s", s + 1);
            int u = 1;
            for (int j = 1; s[j]; ++j) {
              int c = s[j] - 'a';
              u = ch[u][c];
              if (!u) break;  // the absence of the corresponding character indicates that the name does not exist
            }
            if (tag[u] == 1) {
              tag[u] = 2;
              puts("OK");
            } else if (tag[u] == 2)
              puts("REPEAT");
            else
              puts("WRONG");
          }
        
          return 0;
        }
        ```

### AC automation

Trie is part of [AC AUTOMATON](./ac-automaton.md).

### XOR related

We regard the binary representation of a number as a string, so a trie with a character set of $\{0,1\}$ can be constructed.

???+note "[BZOJ1954 longest XOR path](https://www.luogu.com.cn/problem/P4551) (original link in Chinese)"
    Give you a tree with edge weights, find $(u, v)$ to maximize the XOR sum of edge weights on the path from $u$ to $v$ , and output this maximum value.

    The number of points does not exceed $10^5$ , and the edge weight is within $[0,2^{31})$ .

    ??? mdui-shadow-6 "Solution"
        Randomly specify a root $root$ , use $T(u, v)$ to represent the XOR sum of the edge weights of the path between $u$ and $v$ , then $T(u,v)=T(root, u)\oplus T(root,v)$ , because the partial XOR of [LCA](../graph/lca.md) is offset twice.

        So, if you insert all $T(root, u)$ into a trie, you can quickly find the largest XOR sum $T(root, v)$ for each $T(root, u)$ :

        Starting from the root of the trie, if you can go to a subtree different from the current position of $T(root, u)$ , go there, otherwise there is no choice.

        Correctness of Greedy solution: If you go this way, it will be $1$ ; if you don't go this way, it will be $0$ . And the high position needs to be as large as possible.

    ??? mdui-shadow-6 "Template code"
        ```cpp
        #include <algorithm>
        #include <cstdio>
        
        const int N = 100010;
        
        int head[N], nxt[N << 1], to[N << 1], weight[N << 1], cnt;
        int n, dis[N], ch[N << 5][2], tot = 1, ans;
        
        void insert(int x) {
          for (int i = 30, u = 1; i >= 0; --i) {
            int c = ((x >> i) & 1);
            if (!ch[u][c]) ch[u][c] = ++tot;
            u = ch[u][c];
          }
        }
        
        void get(int x) {
          int res = 0;
          for (int i = 30, u = 1; i >= 0; --i) {
            int c = ((x >> i) & 1);
            if (ch[u][c ^ 1]) {
              u = ch[u][c ^ 1];
              res |= (1 << i);
            } else
              u = ch[u][c];
          }
          ans = std::max(ans, res);
        }
        
        void add(int u, int v, int w) {
          nxt[++cnt] = head[u];
          head[u] = cnt;
          to[cnt] = v;
          weight[cnt] = w;
        }
        
        void dfs(int u, int fa) {
          insert(dis[u]);
          get(dis[u]);
          for (int i = head[u]; i; i = nxt[i]) {
            int v = to[i];
            if (v == fa) continue;
            dis[v] = dis[u] ^ weight[i];
            dfs(v, u);
          }
        }
        
        int main() {
          scanf("%d", &n);
        
          for (int i = 1; i < n; ++i) {
            int u, v, w;
            scanf("%d%d%d", &u, &v, &w);
            add(u, v, w);
            add(v, u, w);
          }
        
          dfs(1, 0);
        
          printf("%d", ans);
        
          return 0;
        }
        ```

### Persistent trie

For more details, please see [persistent trie](../ds/persistent-trie.md).
