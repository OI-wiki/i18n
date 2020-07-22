auhor: HeRaNO, Xeonacid

### Structure

For the structure of the binary heap, it is a complete binary tree, in which each node stores an element (or a weight).

Property of heap: the weight of parent node is not less than the weight of child node (max heap). Similarly, we can define a min heap. This article takes the max heap as an example. 

Due to the nature of the heap, the root of the tree stores the maximum value (which can be obtained using getmax operation).

### Insertion operation

The insertion operation refers to inserting an element into the binary heap, and it is required that the tree remains a complete binary tree after insertion.

The easiest way is to insert after the rightmost leaf in the bottom layer.

If the bottom layer is full, then add another layer.

How about the property of heap cannot be satisfied after insertion?

 **Upward adjustment**: If the weight of this node is greater than the weight of its parent node, swap and repeat this process until this condition is no longer satisfied or reaches the root.

It can be proved that after the upward adjustment in insertion operation, no other node will not satisfy the heap property.

The time complexity of the upward adjustment is $O(\log n)$ .

### Deletion operation

Deletion operation refers to deleting the largest element in the heap, that is, deleting the root node.

But if deleted directly, there will be two heaps, which is difficult to handle.

So consider the reverse process of the insertion operation. That is, try to move the root to the last node, and then delete it directly.

However, it is difficult to do in practice. The method we usually use is to directly swap the root node with the last node.

So the root node (at the last node) is deleted directly, but the new root node may not satisfy the heap property...

 **Downward adjustment**: Find the largest one among the child nodes, swap it with the root node, and repeat this process to the bottom.

It can be proved that after deletion and downward adjustment, no other node does not satisfy the heap property.

Time complexity is $O(\log n)$ .

### Decrease the weight of a node

Obviously, after direct changes, you can adjust it upward once, and the time complexity is $O(\log n)$ .

### Implementation

We found that several operations described above mainly rely on two principles: upward and downward adjustment.

Consider using a sequence $h$ to represent the heap. The two child nodes of $h_i$ are $h_{2i}$ and $h_{2i+1}$ , respectively, and $1$ is the root node:

![heap structure of h](./images/binary-heap1.png)

Sample code:

```cpp
void up(inst xs) {
  while (x > 1 && h[x] > h[x / 2]) {
    swap(h[x], h[x / 2]);
    x /= 2;
  }
}
void down(int x) {
  while (x * 2 <= n) {
    t = x * 2;
    if (t + 1 <= n && h[t + 1] > h[t]) t++;
    if (h[t] <= h[x]) break;
    std::swap(h[x], h[t]);
    x = t;
  }
}
```

### Building a heap

Consider this problem: starting from an empty heap, insert $n$ elements regardless of its order.

Inserting directly one by one takes $O(n \log n)$ time. Is there a better way?

#### Method 1: Use decreasekey(i.e. upward adjustment)

Starting from the root, proceed in the order of BFS.

```cpp
void build_heap_1() {
  for (i = 1; i <= n; i++) up(i);
}
```

Why doing this: For the nodes of the $k$-th level, the time complexity of upward adjustment is $O(k)$ instead of $O(\log n)$ .

Overall time complexity: $\log 1 + \log 2 + \cdots + \log n = \Theta(n \log n)$ .

(Proved in "Comparison-based sorting")

#### Method 2: downward adjustment

Now, let's change our mind and start from the leaves and adjust downward one by one

```cpp
void build_heap_2() {
  for (i = n; i >= 1; i--) down(i);
}
```

Another way of understanding is to "merge" the two adjusted heaps each time, which shows the correctness.

Note that the time complexity of the downward adjustment is $O(\log n - k)$ .

$$
\begin{aligned}
Overall time complexity & = n \log n - \log 1 - \log 2 - \cdots - \log n \\
& \leq n \log n - 0 \times 2^0 - 1 \times 2^1 -\cdots - (\log n - 1) \times \frac{n}{2} \\\
& = n \log n - (n-1) - (n-2) - (n-4) - \cdots - (n-\frac{n}{2}) \\
& = n \log n - n \log n + 1 + 2 + 4 + \cdots + \frac{n}{2} \\
& = n - 1 \\ &  = O(n)
\end{aligned}
$$

The reason why building a heap in $O(n)$ is possible is because the property of the heap is very weak, and the binary heap is not unique.

It's hard to say if there are strong conditions like sorting.
