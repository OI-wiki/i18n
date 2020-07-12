author: accelsao

**Matching** or **independent set of edges** is a set with no common edges in a graph. Finding a match in a bipartite graph is equivalent to the network flow problem.

Graph matching algorithm is a commonly used algorithm in informatics competitions. It can be generally divided into maximum matching and maximum weight matching. We will first introduce the bipartite graph, and then propose solutions for general graph.

# Matching

In graph theory, suppose the graph $G=(V,E)$ , where $V$ is vertex point set and $E$ is the edge set.

A set of edges that have no common vertices in pairs $(M(M\in E))$ is called the **matching** of this graph.

Define the size of the match as the number of edges $|M|$ , and the largest number of edges $M$ is the **maximum match**.

When the graph is weighted, the maximum sum of edge weight is **maximum weight matching**.

The edges in the match are called **matched edges**, and the opposite are called **unmatched edges**.

If a vertex belongs to $M$ and is the end point of at most one edge, it is called **matched vertex**, otherwise it is called **unmatched vertex**.

> Maximal matching: No more matching edges can be added. It may not be the maximum match.
> Maximum matching: The match with the maximum number of matches.
> Perfect matching/Complete matching/1-factor: All vertices belong to the matching, and also meet the maximum match.
> Near-perfect matching: The number of vertices in the graph is odd, and there is exactly one vertex that is not in the match. The graph after removing this vertex is called factor-critical graph.

 **Maximal matching** ![graph-match-1](./images/graph-match-1.png) **maximum matching** ![graph-match-2](./images/graph-match-2.png)

# Bipartite graph matching

The matching on a bipartite graph is called bipartite matching. ![graph-match-3](./images/graph-match-3.png)

Let $G$ be a bipartite graph. If there are no common vertices in any two edges in the subgraph $M$ of $G$ , then $M$ is called a match of the bipartite graph $G$ , and the number of edges in $M$ is the number of matches.

## Complete match

Let $G=<V_1, V_2, E>$ be a bipartite graph, $|V_1| \leq |V_2|$ , $M$ is a maximum matching in $G$ , and $|M|=2|V_1|$ , then $M$ is called a complete match from $V_1$ to $V_2$ .

## Hall's Theorem

Let bipartite graph $G=<V_1, V_2, E> , |V_1| \leq |V_2|$ , then there is a complete match between $V_1$ and $V_2$ in $G$ if and only for any $S \ subset V_1$ , both have $|S|\leq|N(S)|$ , where $N(S)=\Cup_{v_i \in S}{N(V_i)}$ is the neighborhood of $S$ .

## Maximum matching

Finding maximum number of matching edges in bipartite graph is called the maximum matching problem.

# Algorithm

A basic problem in combinatorial optimization is to find **maximum matching**.

## Bipartite graph maximum matching

In the unweighted bipartite graph, the [Hopcroft-Karp algorithm](https://en.wikipedia.org/wiki/Hopcroft%E2%80%93Karp_algorithm) can be used to solve the problem in $O(\sqrt{V}E)$.

## Bipartite graph maximum weight matching

In the weighted bipartite graph, it can be solved by [Hungarian algorithm](https://en.wikipedia.org/wiki/Hungarian_algorithm#:~:text=Hungarian%20algorithm%20%2D%20Wikipedia-,Hungarian%20algorithm,anticipated%20later%20primal%2Ddual%20methods.).

If the [Bellman–Ford algorithm](https://en.wikipedia.org/wiki/Bellman%E2%80%93Ford_algorithm) is used to find the shortest path, the time complexity is $O(V^2E)$ . If [Dijkstra algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm) or [Fibonacci heap](https://en.wikipedia.org/wiki/Fibonacci_heap#:~:text=In%20computer%20science%2C%20a%20Fibonacci,binary%20heap%20and%20binomial%20heap.) is used, it can be solved in $O(V^{2}\log {V}+VE)$ .


## General graph maximum matching

In the unweighted general graph, the Edmonds' [blossom algorithm](https://en.wikipedia.org/wiki/Blossom_algorithm) can be used to solve the problem in $O(V^2E)$.

## General graph maximum weight matching

In the weighted general graph, the Edmonds' [blossom algorithm](https://en.wikipedia.org/wiki/Blossom_algorithm) can be used to solve the problem in $O(V^2E)$.

# References

-   [1][Wikiwand - Matching (graph theory)]( <https://www.wikiwand.com/en/Matching_(graph_theory)> )
-   [2][Wikiwand - Blossom algorithm]( <https://www.wikiwand.com/en/Blossom_algorithm> )
-   [3]2015 Talking about the matching algorithm of graph and its application"- Chen Yinbo
-   [4][Algorithm notes - Matching]( <http://www.csie.ntnu.edu.tw/~u91029/Matching.html> )
-   [5][the-tourist/algo]( <https://github.com/the-tourist/algo> )
-   [6][Bill Yang's Blog - Blossom Algorithm learning notes]( <https://blog.bill.moe/blossom-algorithm-notes/> ) (original link in Chinese)
-   [7][Bipartite graph maximum matching, perfect matching and Hungarian algorithm]( <https://www.renfei.org/blog/bipartite-matching.html> ) (original link in Chinese)
-   [8][Wikiwand - Hopcroft–Karp algorithm]( <https://www.wikiwand.com/en/Hopcroft%E2%80%93Karp_algorithm> )
