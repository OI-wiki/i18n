author: Ir1d, HeRaNO, Xeonacid

## Introduction

Blocking problem is pretty common in OI. In fact, blocking is more of a way of thinking than a data structure.

From [NOIP](https://zh.wikipedia.org/wiki/%E5%85%A8%E5%9B%BD%E9%9D%92%E5%B0%91%E5%B9%B4%E4%BF%A1%E6%81%AF%E5%AD%A6%E5%A5%A5%E6%9E%97%E5%8C%B9%E5%85%8B%E8%81%94%E8%B5%9B) to [NOI](../intro/oi/#noi) to [IOI](../intro/oi/#ioi_1), the blocking idea has appeared in all kinds of difficulty levels.

The common blocking algorithms have a root time complexity, while some may have the complexity other than $\log$ .

Blocking is a very flexible idea. Almost everything can be divided into blocks, and it is not difficult to implement.

You can write whatever data structure you want. However, the disadvantage is that the time complexity is not good enough.

Of course, when the constant is small (e.g. $n=10^5$ ), it may be similar to the segment tree.

By no means is this suggesting that we should use blocking. In OI, it can be used as a backup plan. The first choice must be advanced data structures such as segment trees.

Here are a few examples:

## Interval sum

Motivation: The segment tree might be a bit difficult to implement?

Consider a problem like this: For a sequence of length $n$, we divide it into segments of length $T$ , so there are a total of $\frac{n}{T}$ segments. Each operation affects $O(\frac{n}{T})$ blocks, and at most $2T$ elements of uncomplete blocks on both sides of the interval. 

We maintain the interval sum of each segment. Each time we mark the entire segment in $O(1)$ . For uncomplete ones, we can directly brute-force since its element size is relatively small.

Each time we query the interval, it returns the element value plus the mark added on its segment. So the overall time complexity is $O(\frac{n}{T}+T)$ .

Operations involved in the process of interval modification include single node modification, interval modification(marking & brute force modification), and interval query.

When $T=\sqrt{n}$ , the time complexity is $O(\sqrt{n})$ .

Here we offer the C++ implementaion of interval query. The complete template is still WIP;

```cpp
// ...
#define LL long long
const LL MAXN=100001;
LL a[MAXN]; // initial value
LL add[MAXN]; // value added to each segment
LL location[MAXN]; // which segment
LL sum[MAXN]; // sum of each segment
// ...

void interval_query(LL ll, LL rr)
{
    LL res=0;
    for(LL i = ll; i <= min(location[ll] * T, rr); i++)
        res += a[i] + add[location[i]];
      
    if(location[ll] != location[rr])
        for(LL i = (location[rr]-1) * T+1; i<=rr; i++)
            res += a[i] + add[location[i]];
             
    for(LL i = location[ll] + 1; i <= location[rr]-1; i++)
        res += sum[i]+add[i] * T;

    printf("%lld\n", res);
}
```

## Interval sum 2

The time complexity of the previous approach is $\Omega(1), O(\sqrt{n})$ .

Here we introduce an algorithm in $O(\sqrt{n})-O(1)$ time complexity.  

For $O(1)$ query, we can maintain various prefix sums.

However, in the case of modification, it is not convenient to maintain, and only the prefix sum in a single block can be maintained.

And the prefix sum of the whole block as a unit.

Modify takes $O(T+\frac{n}{T})$ each time.

Query: There are three parts involved, each part can be directly obtained by prefix sum. The time complexity is $O(1)$ .

## Making query blocks

The same problem, now the sequence length is $n$ and there are $m$ operations.

If the number of operations is relatively small, we can note down the operations and add these when querying.

Assume that at most $T$ operations are recorded, modification takes $O(1)$ and querying takes $O(T)$ .

  After $T$ operations, recalculate the prefix sum, $O(n)$ .

Total time complexity: $O(mT+n\frac{m}{T})$ .

  When $T=\sqrt{n}$ , the total time complexity is $O(m \sqrt{n})$ .

# Reference

1. [Introduction to blocking method](https://zhuanlan.zhihu.com/p/118117479) (Original link in Chinese)
2. [Blocking problem intro](https://www.codenong.com/cs106117694/) (Original link in Chinese)
