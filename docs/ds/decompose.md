author: Ir1d, HeRaNO, Xeonacid

## Introduction

In fact, blocking is a way of thinking, not a data structure.

From [NOIP](https://zh.wikipedia.org/wiki/%E5%85%A8%E5%9B%BD%E9%9D%92%E5%B0%91%E5%B9%B4%E4%BF%A1%E6%81%AF%E5%AD%A6%E5%A5%A5%E6%9E%97%E5%8C%B9%E5%85%8B%E8%81%94%E8%B5%9B) to[NOI](http://www.noi.cn/) to [IOI](https://ioinformatics.org/), the blocking idea has appeared in all kinds of difficulty levels.

The time complexity of the usual blocking algorithm has a root sign, or other type of strange time complexity, instead of $\log$ .

Blocking is a very flexible idea. Almost everything can be divided into blocks, and it is not difficult to implement.

You can write whatever data structure you want. However, the disadvantage is that the time complexity is not good enough.

Of course, when $n=10^5$ , because the constant is small, it may be similar to the segment tree.

By no means is this suggesting that we should use blocking. In OI, it can be used as a backup plan. The first choice must be advanced data structures such as segment trees.

Here are a few examples:

## Interval sum

Motivation: The segment tree is too difficult to implement?

Divide the sequence into segments, and each segment has a length of $T$ , so there are a total of $\frac{n}{T}$ segments.

Maintain the interval sum of each segment.

Single node of modification: Obviously.

Interval query: It will involve some complete segments, and part of up to two segments.

The complete segment uses and maintains the information, and some parts are obtained using brute-force.

The time complexity is $O(\frac{n}{T}+T)$ .

Interval modification: also involved. Use marking and brute force modification. The time complexity is the same.

When $T=\sqrt{n}$ , the time complexity is $O(\sqrt{n})$ .

## Interval sum 2

The time complexity of the previous approach is $\Omega(1), O(\sqrt{n})$ .

Here we introduce an algorithm of $O(\sqrt{n})-O(1)$ .  

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
ßß
  When $T=\sqrt{n}$ , the total time complexity is $O(m \sqrt{n})$ .