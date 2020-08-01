author: sshwy, StudyingFather, orzAtalod

## Lyndon factorization

First, we introduce the concept of Lyndon factorization.

Lyndon word: for the string $s$ , if the lexicographic order of $s$ is strictly less than the lexicographic order of all suffixes of $s$  we call $s$ a simple string, or a **Lyndon word**. To give some examples, $\texttt{a}$ , $\texttt{b}$ , $\texttt{ab}$ , $\texttt{aab}$ , $\texttt{abb}$ , $\texttt{ababb}$ , $\texttt{abcd}$ are all Lyndon words. If $s$ is a Lyndon word, if and only if the lexicographic order of $s$ is strictly less than all its non-trivial cyclic isomorphic strings.

Lyndon factorization: the Lyndon factorization of string $s$ is recorded as $s=w_1w_2\cdots w_k$ , where all $w_i$ are simple strings, and their lexicographical order is sorted by non-strict monotonically decreasing order, that is, $w_1\ge w_2\ge\cdots \ge w_k$ . It can be found that such a factorization exists and is unique.

## Duval alogarithm

Duval algorithm can find the Lyndon factorization of a string in $O(n)$ time.

First, we introduce another concept: if a string $t$ can be factorized into the form of $t=ww\cdots\overline{w}$ , where $w$ is a Lyndon word, and $\overline{w}$ is the prefix of $w$ ( $\overline{w}$ may be an empty string), then $t$ is a approximate simple string or an approximate Lyndon word. A Lyndon word is also an approximate Lyndon word.

The Duval algorithm uses a greedy principle. In the process, we divide the string $s$ into three parts $s=s_1s_2s_3$ , where $s_1$ is a Lyndon word whose Lyndon factorization has been recorded; $s_2$ is an approximate Lyndon word; $s_3$ is the unprocessed part.

To describe it as a whole, the algorithm tries to add the first character of $s_3$ to the end of $s_2$ each time. If $s_2$ is no longer an approximate Lyndon word, then we can cut off a part of the prefix (i.e. Lyndon factorization) of $s_2$ and connect it to the end of $s_1$ .

Let's explain the algorithm in details. Define a pointer $i$ to point to the first character of $s_2$ , then $i$ traverses from $1$ to $n$ (string length). During the loop, we define another pointer $j$ to point to the first character of $s_3$ , and pointer $k$ to point to the character we are currently working on in $s_2$ (meaning that $j$ is the character corresponding to the previous loop section of $s_2$ ). Our goal is to add $s[j]$ to the end of $s_2$ , which requires comparing $s[j]$ with $s[k]$ :

1. If $s[j]=s[k]$ , then adding $s[j]$ to the end of $s_2$ will not affect its approximate simplicity. So we only need to increment the pointer $j,k$  (move to the next one).
2.  If $s[j]>s[k]$ , then $s_2s[j]$ becomes a Lyndon word, so we increase the pointer $j$ and let $k$ point to the first character of $s_2$ , so $s_2$ becomes a new Lyndon word with a loop count of 1.
3.  If $s[j]<s[k]$ , then $s_2s[j]$ is not an approximate simple word, then we have to factorize $s_2$ into one of its Lyndon substrings. The length of this Lyndon substring will be $jk$ , which is one of its loop section. Then we turn $s_2$ into the remaining part after the factorization, and continue the loop (note that we did not change the pointer $j,k$ in this case) until the loop section is truncated. For the remaining part, we only need to **roll back** to the beginning of the remaining part.

### Code

The following code returns the Lyndon factorization of the string $s$.

```cpp
// duval_algorithm
vector<string> duval(string const& s) {
  int n = s.size(), i = 0;
  vector<string> factorization;
  while (i < n) {
    int j = i + 1, k = i;
    while (j < n && s[k] <= s[j]) {
      if (s[k] < s[j])
        k = i;
      else
        k++;
      j++;
    }
    while (i <= k) {
      factorization.push_back(s.substr(i, j - k));
      i += j - k;
    }
  }
  return factorization;
}
```

### Complexity analysis

Next let's prove the time complexity of this algorithm.

The number of outer loops does not exceed $n$ because each time $i$ will increase. The second inner loop is also $O(n)$ because it only records Lyndon's factorization. Next we analyze the inner loop. It is easy to find that every time the Lyndon word found in the outer loop is longer than the remaining strings we have compared, and the sum of the remaining strings is less than $n$ . Do we can loop at most $O(n)$ times in the inner loop. In fact, the total number of loops does not exceed $4n-3$ , and the time complexity is $O(n)$ .

## Finding the smallest cyclic shift

For the string $s$ of length $n$, we can find the smallest smallest cyclic shift using the above algorithm.

We construct a Lyndon factorization of the string $ss$ , and then search for a Lyndon string $t$ in this factorization such that its starting point is less than $n$ and its end point is greater than or equal to $n$ . It can be easily proved by the nature of Lyndon’s factorization that the first character of the substring $t$ is the first character of the smallest representation of $s$ , that is, we follow the beginning of $t$ and the following $n$ characters. It is the smallest representation of $s$ .

So we record the beginning of each approximate Lyndon string in the factorization process.

```cpp
// smallest_cyclic_string
string min_cyclic_string(string s) {
  s += s;
  int n = s.size();
  int i = 0, ans = 0;
  while (i < n / 2) {
    ans = i;
    int j = i + 1, k = i;
    while (j < n && s[k] <= s[j]) {
      if (s[k] < s[j])
        k = i;
      else
        k++;
      j++;
    }
    while (i <= k) i += j - k;
  }
  return s.substr(ans, n / 2);
}
```

## Sample problems

-    [UVA #719 - Glass Beads](https://uva.onlinejudge.org/index.php?option=onlinejudge&page=show_problem&problem=660) 

## Reference

> **NOTE**: part of this article refers to the following pages;  

- [Декомпозиция Линдона. Алгоритм Дюваля. Нахождение наименьшего циклического сдвига](http://e-maxx.ru/algo/duval_algorithm)(copyright: Public Domain + Leave a Link；)
- [Lyndon factorization](https://cp-algorithms.com/string/lyndon_factorization.html)(copyright: CC-BY-SA 4.0)