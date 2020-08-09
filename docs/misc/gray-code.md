author: sshwy

Gray code is a binary number system in which only one bit of two adjacent numbers differs. For example, the Gray code sequence of a $3$ bit binary numbers is:

$$
000,001,011,010,110,111,101,100
$$

Note that we use $0$ as the starting point for the subscript of the sequence, that is, $G(0)=000,G(4)=110$ .

Gray code was discovered in 1940s and patented in 1953 by Frank Gray of Bell Laboratories.

## Construct Gray code (transformation)

There are many ways to construct Gray codes. We first introduce the manual method, then we'll offer the code constructed and proof of correctness.

### Manual construction

 The Gray code of $k$ bits can be constructed by the following methods. We start with all $0$ Gray code and follow the strategy below:

1. Flip the lowest bit to get the next Gray code (for example, $000\to 001$ );
2. Flip the left bit of the rightmost $1$ to get the next Gray code (for example, $001\to 011$ );

Alternately we generate $2^k-1$ times according to the strategy above, and get the Gray code sequence of $k$ bits.

### Mirror construction

 The $k$-bits Gray code can be quickly obtained by mirroring the $k-1$-bits Gray code and adding new bits, as shown in figure below:

$$
\begin{matrix}
k=1\\
0\\ 1\\\\\\\\\\\\\\
\end{matrix}
\to \begin{matrix}\\
\color{Red}0\\\color{Red}1\\\color{Blue}1\\\color{Blue}0\\\\\\\\\\
\end{matrix}
\to \begin{matrix}
k=2\\
{\color{Red}0}0\\{\color{Red}0}1\\{\color{Blue}1}1\\{\color{Blue}1}0\\\\\\\\\\
\end{matrix}
\to \begin{matrix}\\
\color{Red}00\\\color{Red}01\\\color{Red}11\\\color{Red}10\\\color{Blue}10\\\color{Blue}11\\\color{Blue}01\\\color{Blue}00
\end{matrix}
\to \begin{matrix}
k=3\\
{\color{Red}0}00\\{\color{Red}0}01\\{\color{Red}0}11\\{\color{Red}0}10\\{\color{Blue}1}10\\{\color{Blue}1}11\\{\color{Blue}1}01\\{\color{Blue}1}00
\end{matrix}
$$

### Calculation method

Let's look at the binary of $n$ and $G(n)$ . It can be found that if the binary position $i$-th bit of $G(n)$ is $1$ , only when the binary $i$-th bit of $n$ is $1$ and the $i+1$-th bit is $0$ or the $i$-th bit is $0$ , and the $i+1$-th bit is $1$ . So we can treat it as an XOR operation, that is:

$$
G(n)=n\oplus \left\lfloor\frac{n}{2}\right\rfloor
$$

```cpp
int g(int n) { return n ^ (n >> 1); }
```

### Proof of correctness

Next, let's prove that in the Gray code sequence generated according to the above formula, there exists and only exists one different bit of two adjacent Gray code.

We consider the difference between $n$ and $n+1$ . Adding $n$ by $1$ is equivalent to turning all consecutive $1$ at the end of the binary $n$ into inversions, and then changing the lowest bit of $0$ to $1$ . We represent the binary bits of $n$ and $n+1$ like this:

$$
\begin{array}{rll}
(n)_2&=&\cdots0\underbrace{11\cdots11}_{k\text{entries}}\\
(n+1)_2&=&\cdots1\underbrace{00\cdots00}_{k\text{entries}}
\end{array}
$$

So when we calculate $g(n)$ and $g(n+1)$ , the next $k$ bits will become the form like $\displaystyle\underbrace{100\cdots00}_{k\text{entries}}$ , and the $k+1$-th bit is different, because $n$ and $n+1$ are the same except for the last $k+1$ bits. Therefore, the position $k+1$ is either XORed $1$ or $0$ at the same time. In both cases, the $k+1$-th bit is different. The binary bits except the last $k+1$ bits are also subjected to the same XOR operation, and the result is the same.

Q.E.D.

## Construct the original number through Gray code (inverse transformation)

Next, we consider the inverse transformation of the Gray code, that is, given a Gray code $g$ and ask you to find the original number $n$ . We consider traversing from the highest bit of the binary to the lowest bit (the subscript of the lowest bit is $1$ , which is the one bit; and the highest bit subscript is $k$ ). Then the relationship between the $i$-th bit of $n$ and the $i$-th bit of $g$ is shown as follows:

$$
\begin{array}{rll}
n_k &= g_k \\
n_{k-1} &= g_{k-1} \oplus n_k &= g_k \oplus g_{k-1} \\
n_{k-2} &= g_{k-2} \oplus n_{k-1} &= g_k \oplus g_{k-1} \oplus g_{k-2} \\
n_{k-3} &= g_{k-3} \oplus n_{k-2} &= g_k \oplus g_{k-1} \oplus g_{k-2} \oplus g_{k-3} \\
&\vdots\\
n_{k-i} &=\displaystyle\bigoplus_{j=0}^ig_{k-j}
\end{array}
$$

```cpp
int rev_g(int g) {
  int n = 0;
  for (; g; g >>= 1) n ^= g;
  return n;
}
```

## Practical application

Gray code has some very useful applications, some of which are unexpected:

-  The Gray code sequence of a $k$ bit binary number can be regarded as a Hamiltonian loop of the vertices of a hypercube (a square in two dimensions, a unit vector in one dimension) in the $k$ dimensional space, where each bit of the Gray code represents one dimension of coordinates.

-  Gray code is used to minimize errors in the signal transmission of digital-to-analog converters (such as sensors) because it only changes one bit at a time.

-  Gray code can be used to solve the problem of the Tower of Hanoi.

    Assume the number of disks as $n$ . We start from the Gray code $G(0)$ with all $0$ in $n$ and move to the next Gray code in turn ( $G(i)$ moves to $G(i+1)$ ). The $i$-th bit of the current Gray code represents the $i$-th plate from small to large.

    Since only one binary bit changes each time, when the $i$-th bit changes, we move the $i$-th plate. While moving the plates, except for the smallest one, there can only be one placement option for any other plate when it is moving. When moving the first plate, we always have two placement options. So our strategy is as follows:

    If $n$ is an odd number: The moving path of the plate is $f\to t\to r\to f\to t\to r\to\cdots$ , where $f$ is the first pillar, $t$ is the pillar where we put all the plates in the end, and $r$ is the pillar in the middle.

    If $n$ is an even number: $f \to r \to t \to f \to r \to t \to \cdots$ 

-  Gray code is also applied in genetic algorithm theory.

## Practice problems

-  [CSP S2 2019 D1T1](https://www.luogu.com.cn/problem/P5657) (original link in Chinese) Difficulty: easy

-  [SGU #249 Matrix](http://codeforces.com/problemsets/acmsguru/problem/99999/249) Difficulty: medium

> Part of this page is translated from the blog post [Код Грея](http://e-maxx.ru/algo/gray_code) and its English version [Gray code](https://cp-algorithms.com/algebra/gray-code.html). The copyright license for the Russian version is Public Domain + Leave a Link; And the copyright license for the English version is CC-BY-SA 4.0.
