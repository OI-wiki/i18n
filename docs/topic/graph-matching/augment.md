author: accelsao

# Berge's lemma

[Berge's lemma](https://en.wikipedia.org/wiki/Berge%27s_lemma) is an important theory of [maximum matching](https://en.wikipedia.org/wiki/Matching_(graph_theory)#:~:text=A%20maximal%20matching%20is%20a,least%20one%20edge%20in%20M.). 

- Alternating path: a path that begins with an unmatched vertex and whose edges belong alternately to the matching and not to the matching. 
- Augmenting path: an alternating path that starts from and ends on free (unmatched) vertices.

The number of unmatched edges on an augmenting path is one more than the number of matched edges. If the matched edges are changed to unmatched edges, or vice versa, the matching size will increase by one and still be an alternating path.

![augment-1](./images/augment-1.png)

As shown in the figure, the number of matches increases from 2 to 3 - we call this **augmentation**.

According to Berge's lemma, the maximum matching is found when there's no augmenting path.

From this theorem, we can understand the core idea of maximum matching.

!!! core idea

    Enumerate all unmatched vertices and find the augmenting path until there's no one to be found.

In fact, we only need to enumerate once for each vertex.

![augment-2](./images/augment-2.png)

Suppose that after a round of augmentation along the augmenting path $a-b$ , there's an augmenting path $P_x$ starting from $x$ , then $P_x$ must intersect $a-b$ .

Suppose $P_x$ intersects $a-b$ for the first time. Remebering that $a-b$ is an alternating path, which means that the intersection points are of different types (marked by red and blue in the figure), then $x$ can reach an unmatched vertex in $a-b$ before the augmentation, which indicates that there already exists an augmenting path starting from $x$ .
