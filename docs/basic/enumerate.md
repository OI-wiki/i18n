author: frank-xjh

Enumeration is a problem-solving technique that guesses the answer based on existing knowledge.

!!! Sample problem
    Find the largest prime number less than N

If you cannot find a suitable mathematical formula to directly calculate the answer, you may want to try whether a number is the answer in order.

If we enumerate numbers less than $N$ from large to small, then the original problem is transformed into how to check whether a number is a prime number.

Note that the nature of prime numbers requires that they cannot be divided by $1$ and numbers other than itself, and this can be directly used for decision.

The idea of enumeration is to constantly guess, try one by one from the possible set, and then determine whether the condition of the problem is met.

## Find solution space

Construct a concise mathematical model.

When enumerating, think about what are the possible situations and what elements should be enumerated?

## Reduce the space for enumeration

What is the range of the enumeration? Does all content need to be enumerated?

When using the enumeration to solve the problem, we must think clearly about these two things, otherwise it will bring unnecessary time overhead.

!!! Sample problem
    The numbers in an array are different from each other, find the number of pairs whose sum is $0$

The code for enumerating two numbers is easy to write.

```cpp
for (int i = 0; i < n; ++i)
  for (int j = 0; j < n; ++j)
    if (a[i] + a[j] == 0) ++ans;
```

Let's see how to optimize the range of enumeration. The answer to the original problem consists of two parts, the case where the two numbers are equal and the case where the they are not. In the case of equality, it is only necessary to enumerate each number to determine whether it is legal. As for the case of inequality, since the number pairs are not required to be ordered in the problem, the answer is twice that of the ordered case (consider that if `(a, b)` is the answer, then `(b, a)` is also the answer). In this case, we only need to count the answers that are  required in order, and multiply it by $2$ .

We may as well require the first number to appear in the front position. Code is shown below:

```cpp
for (int i = 0; i < n; ++i)
  for (int j = 0; j < i; ++j)
    if (a[i] + a[j] == 0) ++ans;
```

It is not difficult to find that the enumeration range of $j$ has been reduced here, reducing the time cost of this section of code.

However, this is not the optimal result.

Do both numbers have to be enumerated? Here we find that after enumerating one of the numbers, the condition of the question has helped us determine the other element (another number). If we can find a way to directly determine whether the number required by the question exists, we can save the time of enumerating another number.

```cpp
// Is is required that the absolute values of the numbers in the a array are all less than MAXN
bool met[MAXN * 2];
// Initialize the met array to 0
memset(met, 0, sizeof(met));
for (int i = 0; i < n; ++i) {
  if (met[MAXN - a[i]]) ++ans;
  // To avoid negative index
  met[a[i] + MAXN] = 1;
}
```

## Choose the appropriate enumeration order

For example, in the first example, the largest eligible prime number is required. Naturally, it is more appropriate to enumerate from large to small.