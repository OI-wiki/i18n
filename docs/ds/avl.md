[AVL tree](https://en.wikipedia.org/wiki/AVL_tree)((named after inventors Adelson-Velsky and Landis)) is a balanced binary search tree. Due to the lengthy introductions in various algorithm textbooks, many people have the impression that the it is complicated and impractical. But in fact, the principle of the AVL tree is simple, and the implementation is not complicated.

## Property

1. The empty binary tree is an AVL tree
2. If T is an AVL tree, then its left and right subtrees are also AVL trees, and $|h(ls) - h(rs)| \leq 1$ , where h is the height of its left and right subtrees
3. The tree height is $O(\log n)$

Balance factor: right subtree height - left subtree height

 **Proof of tree height** Let $f_n$ be the minimum number of nodes in the AVL tree with height $n$ , then

$$
f_n=
\begin{cases}
  1&(n=1)\\
  2&(n=2)\\
  f_{n-1}+f_{n-2}+1& (n>2)
\end{cases}
$$

Obviously $\{f_n+1\}$ is a Fibonacci sequence. As we all know, the Fibonacci sequence grows exponentially, so the height of the AVL tree is $O(\log n)$ .

## Insert node

Similar to BST (Binary Search Tree), a failed search is performed first to determine the position of the insertion, and after inserting the node, it is decided whether to adjust according to the balance factor.

## Delete node

Deletion is similar to BST, and the node is swapped with the successor before deleting.

Deletion will cause the tree height and balance factor to change. At this time, you need to adjust this change along the path from the deleted node to the root.

## Maintain Balance

After inserting or deleting nodes, the property of the AVL tree 2 may be destroyed. Therefore, the tree needs to be maintained along the path from the inserted/deleted node to the root. If for a node, property 2 is no longer satisfied, since we only insert/delete a node, and the impact on the tree height does not exceed 1, the absolute value of the balance factor of the node is at most 2. Due to symmetry, we only discuss the case where the left subtree is 2 higher than the right subtree, that is, $h(B)-h(E)=2$ in the figure below. At this time, we need to discuss the two situations according to the relationship between $h(A)$ and $h(C)$ . It should be noted that because we maintain balance from bottom to top, for all descendants of node D, property 2 is still satisfied.

![](./images/avl1.jpg)

###  $h(A)\geq h(C)$ 

Suppose $h(E)=x$, then we have

$$
\begin{cases}
    h(B)=x+2\\
    h(A)=x+1\\
    x\leq h(C)\leq x+1
\end{cases}
$$

$h(C)\geq x$ is because node B satisfies property 2, so the difference between $h(C)$ and $h(A)$ will not exceed 1. At this time, we perform a right rotation on node D (the rotation operation is the same as other types of balanced binary search trees), as shown in the following figure.

![](./images/avl2.jpg)

Obviously the height of nodes A, C, E does not change, and we have

$$
\begin{cases}
    0\leq h(C)-h(E)\leq 1\\
    x+1\leq h'(D)=\max(h(C),h(E))+1=h(C)+1\leq x+2\\
    0\leq h'(D)-h(A)\leq 1
\end{cases}
$$

Therefore, the rotated nodes B and D also satisfy property 2.

###  $h(A)<h(C)$ 

Suppose $h(E)=x$, the same as before, we have

$$
\begin{cases}
    h(B)=x+2\\
    h(C)=x+1\\
    h(A)=x
\end{cases}
$$

At this point, we first perform a left rotation on node B, and then perform a right rotation on node D, as shown in the following figure.

![](./images/avl3.jpg)

Obviously the height of nodes A and E does not change, and the new right child node of B and the new left child node of D are the original left and right child of C respectively, then

$$
\begin{cases}
    x-1\leq h'(rs_B),h'(ls_D)\leq x\\
    0\leq h(A)-h'(rs_B)\leq 1\\
    0\leq h(E)-h'(ls_D)\leq 1\\
    h'(B)=\max(h(A),h'(rs_B))+1=x+1\\
    h'(D)=\max(h(E),h'(ls_D))+1=x+1\\
    h'(B)-h'(D)=0
\end{cases}
$$

Therefore, the rotated nodes B, C, and D also satisfy property 2. The pseudocode for maintaining a balanced operation for a node is given.

```text
Maintain-Balanced(p)
    if h[ls[p]] - h[rs[p]] == 2
        if h[ls[ls[p]]] >= h[rs[ls[p]]]
            Right-Rotate(p)
        else
            Left-Rotate(ls[p])
            Right-Rotate(p)
    else if h[ls[p]] - h[rs[p]] == -2
        if h[ls[rs[p]]] <= h[rs[rs[p]]]
            Left-Rotate(p)
        else
            Right-Rotate(rs[p])
            Left-Rotate(p)
```

Like other balanced binary search trees, the height of nodes in the AVL tree, the size of the subtree, and other information need to be maintained during the rotation.

## Other operations

The other operations of the AVL tree (Pred, Succ, Select, Rank, etc.) are the same as those of normal binary search tree.

## Other materials

You can observe how AVL tree maintains its balance in [AVL Tree Visualization](https://www.cs.usfca.edu/~galles/visualization/AVLtree.html)/
