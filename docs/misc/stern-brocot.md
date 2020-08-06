## Stern-Brocot tree

The Stern-Brocot tree is an elegant data structure for maintaining positive fractions. It was discovered independently by Moritz Stern in 1858 and Achille Brocot in 1861.

### Overview

The Stern-Borcot tree starts with two simple fractions:

$$
\frac{0}{1}, \frac{1}{0}
$$

This $\frac{1}{0}$ may make you feel a little confused. But we will not discuss its preciseness here. You can just treat it as $\infty$ .

Every time we insert a fraction $\frac{a+c}{b+d}$ between two adjacent fractions $\frac{a}{b},\frac{c}{d}$ , which means one iteration is completed and the next sequence is obtained. So it will look like this.

$$
\begin{array}{c}
\dfrac{0}{1}, \dfrac{1}{1}, \dfrac{1}{0} \\\\
\dfrac{0}{1}, \dfrac{1}{2}, \dfrac{1}{1}, \dfrac{2}{1}, \dfrac{1}{0} \\\\
\dfrac{0}{1}, \dfrac{1}{3}, \dfrac{1}{2}, \dfrac{2}{3}, \dfrac{1}{1}, \dfrac{3}{2}, \dfrac{2}{1}, \dfrac{3}{1}, \dfrac{1}{0}
\end{array}
$$

Since we call this data structure Stern-Brocot tree, it must look like a tree, right? Look at this figure:

![pic](./images/stern-brocot1.png)

You can think of the sequence at the $i$ level as an in-order traversal of the Stern-Brocot tree with a depth of $i-1$ .

### Property

Next, let's discuss the nature of the Stern-Brocot tree.

#### Monotonicity

In the sequence of each layer, the true fraction is monotonically increasing.

Brief proof: only need to prove in the case of $\frac{a}{b}\le \frac{c}{d}$

$$
\frac{a}{b}\le \frac{a+c}{b+d}\le \frac{c}{d}
$$

That's it. This is very easy, we can just do algebraic transformation directly

$$
\begin{array}{l}
&\frac{a}{b}\le \frac{c}{d}\\
\Rightarrow &ad\le bc\\
\Rightarrow &ad+ab\le bc+ab\\
\Rightarrow &\frac{a}{b}\le\frac{a+c}{b+d}
\end{array}
$$

The same is true on the other side.

#### Irreducibility

The fractions in the sequence (except for $\frac{0}{1},\frac{1}{0}$) are the minimal fraction.

Brief proof: To prove the irreducibility, we first prove that for two consecutive fractions in the sequence $\frac{a}{b},\frac{c}{d}$ :

$$
bc-ad=1
$$

Obviously, we only need to prove that $\frac{a}{b}, \frac{a+c}{b+d}, \frac{c}{d}$ under the condition of $bc-ad=1$ .

$$
a(b+d)-b(a+c)=ad-bc=1
$$

The latter part is the same. we can prove using the extended Euclidean theorem. If the above equation has a solution, obviously $\gcd(a,b)=\gcd(c,d)=1$ . Then the proof is finished.

With the above proof, we can prove $\frac{a}{b}<\frac{c}{d}$ .

With these two properties, you can treat it as a balanced tree. So we can construct and query the same way we do to the balanced trees.

### Implementation

Construct:

```cpp
void build(int a = 0, int b = 1, int c = 1, int d = 0, int level = 1) {
  int x = a + c, y = b + d;
  // ... output the current fraction x/y
  // at the current level in the tree
  build(a, b, x, y, level + 1);
  build(x, y, c, d, level + 1);
}
```

Query:

```cpp
string find(int x, int y, int a = 0, int b = 1, int c = 1, int d = 0) {
  int m = a + c, n = b + d;
  if (x == m && y == n) return "";
  if (x * n < y * m)
    return 'L' + find(x, y, a, b, m, n);
  else
    return 'R' + find(x, y, m, n, c, d);
}
```

## Farey sequence

Stern-Brocot tree and Farey sequence have very similar characteristics. The $i$th Farey sequence is denoted as $F_i$ , which means that all the simplest true fractions whose denominator is less than or equal to $i$ are arranged in order of value.

$$
\begin{array}{l}
F_1=\{&\frac{0}{1},&&&&&&&&&&\frac{1}{1}&\}\\
F_2=\{&\frac{0}{1},&&&&&\frac{1}{2},&&&&&\frac{1}{1}&\}\\
F_3=\{&\frac{0}{1},&&&\frac{1}{3},&&\frac{1}{2},&&\frac{2}{3},&&&\frac{1}{1}&\}\\
F_4=\{&\frac{0}{1},&&\frac{1}{4},&\frac{1}{3},&&\frac{1}{2},&&\frac{2}{3},&\frac{3}{4},&&\frac{1}{1}&\}\\
F_5=\{&\frac{0}{1},&\frac{1}{5},&\frac{1}{4},&\frac{1}{3},&\frac{2}{5},&\frac{1}{2},&\frac{3}{5},&\frac{2}{3},&\frac{3}{4},&\frac{4}{5},&\frac{1}{1}&\}\\
\end{array}
$$

Obviously, the above algorithm for constructing Stern-Brocot tree is also suitable for constructing the Farey sequence. Because the numbers in the Stern-Brocot tree are the minimal fraction, a slight modification of the boundary conditions (denominator) can form the code for constructing the Farey sequence. You can think of the Farey sequence $F_i$ as a subsequence of the sequence obtained after the $i-1$ iteration of Stern-Brocot.

The Farey sequence also satisfies the irreducibility and monotonicity, and satisfies a property similar to the Stern-Brocot tree: for the three consecutive numbers $\frac ab,\frac xy,\frac cd$ in the sequence, there is $x=a +c,y=b+d$ . This can be easily proved, so we won't repeat it here.

From the definition of Farey sequence, we can get the length of $F_i$ . The formula of $L_i$ is:

$$
L_i=L_{i-1}+\varphi(i)\\
L_i=1+\sum_{k=1}^i\varphi(k)
$$

 **This page is mainly translated from the blog post [Дерево Штерна-Броко. Ряд Фарея](http://e-maxx.ru/algo/stern_brocot_farey) and its English version [The Stern-Brocot Tree and Farey Sequences](https://cp-algorithms.com/others/stern_brocot_tree_farey_sequences.html). The copyright agreement for the Russian version is Public Domain + Leave a Link; the copyright agreement for the English version is CC-BY-SA 4.0.**