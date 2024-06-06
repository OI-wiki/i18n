# The Euler Tour Tree (ETT)

Generally speaking, when it comes to dynamic trees, we think of LCT. This is a more general, practical, and versatile implementation. Of course, to master LCT requires certain familiarity with various operations and knowledge of Splay. [Euler tour tree](https://en.wikipedia.org/wiki/Euler_tour_technique#Euler_tour_trees), or ETT, is a smart dynamic tree that can be maintained with a brute-force data structure. In addition to the Link & Cut operation of ordinary dynamic trees, it also supports subtree replacement, which cannot be done with LCT.

Let's take a look at this bracket sequence:

![](./images/ett1.png)

Its bracket sequence is: `1 2 5 5 6 6 2 3 3 4 7 8 8 7 4 1` .

The bracket sequence is actually a kind of tree sequence in which a parent node contains children nodes.

Now let's take a look, what if the subtree of `4` is moved to `3`? As shown in the figure below:

![](./images/ett2.png)

Original bracket sequence: `1 2 5 5 6 6 2 3 3 4 7 8 8 7 4 1` 

New bracket sequence: `1 2 5 5 6 6 2 3 7 8 8 7 3 4 4 1` 

It can be found that `7 7 8 8` has been moved to the back of `3` and `4` is moved together. This is the so-called subtree operation (it can also be used for the Link & Cut operation). Now only one data structure is needed to achieve interval translation and maintain values. Some may say that using Splay is very efficient, but it is much easier to maintain a block linked list here. For data less than $2 \times 10^5$ , the coding would be pretty fast.

How to maintain node-to-root information?

In fact, if you think about it carefully, the DFS order can also achieve the effect of [translation](https://en.wikipedia.org/wiki/Translation_(geometry)). So why do we need the bracket sequence? In fact, if you want to query the sum of `1` to `8` in the figure, then you will erase the contribution of the number that appears twice in the bracket sequence from `1` to `8` (the first occurrence). If you are maintaining xor, then you can directly xor twice. If sum is maintained, then the contribution of the first number that appears is positive, and the second is negative. Then you can use the block linked list to maintain the interval sum.

After using the block linked list, except for the single-node modification which is $O(1)$ , everything else is $O(n^{\frac{1}{2}})$ .

  ETT does not support root replacement operation. For chain (interval) modification, there are two cases. One is that the contribution is the same (such as xor), which is allowed; and the other is that the contribution is different (such as $\operatorname{sum}$ ) , which is not. After all, the current mainstream approach is LCT and ETT take more operations. But if the previous operations can be avoided, it would be a good approach.

Note: The standard ETT implemented with [Euler circuit](https://en.wikipedia.org/wiki/Eulerian_path#Definition) instead of DFS bracket sequence supports root replacement, but its implementation is more complicated.
