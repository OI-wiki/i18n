author: fudonglai, AngelKitty, labuladong

The article will introduce difference and application of recursive algorithm and divide-and-conquer algorithm

## Introduction

In computer science and math, recursion is method by using functions that call themselves from within their own definition. Additionally in computer science it also refers to a method of solving problem by repeatedly decomposing problem into sub-problems of the same type as the original.

From [Wikipedia](https://en.wikipedia.org/wiki/Divide-and-conquer_algorithm):
> In computer science, divide and conquer is an algorithm design paradigm. A divide-and-conquer algorithm recursively breaks down a problem into two or more sub-problems of the same or related type, until these become simple enough to be solved directly. The solutions to the sub-problems are then combined to give a solution to the original problem. <!---中文显然就是抄英文wiki的-->

## Detailed Introduction

### Recursion

> To understand recursion, you must first understand recursion.

The fundamental idea of recursion is a function call itself directly or indirectly, so that the original problem transforms into many smaller size sub-problems with similar properties. While solving problems it only needs to focus on how to decompose original problems to eligible sub-problems without too much attention about how it is solved.

Here is some examples may be helpful for understanding recursion:

1. [What is recursion?](./divide-and-conquer.md)
2. Q: How to sort a pile of numbers? A: Decompose them into two halves. First sort left half and then right half, and finally merge them into one array. As for how to sort left and right halves, please read this paragraph again.
3. Q: How old are you this year? A: My age in last year add one year, and I am born in 1999.
4. [Google's example to understand recursion](https://www.google.com/search?q=recursion) ![](images/divide-and-conquer-1.png)

Recursion is very common in mathematics. For example, in set theory, we have the following definition of natural number:[^ref1] $1$ is a natural number, and every nature number has a successor, which is also a natural number.<!---Discuss thread: https://t.me/c/1344172945/110421-->

Recursive codes have two most important features: terminating case and recursive case<!---使用https://en.wikipedia.org/wiki/Recursion_(computer_science)#Recursive_functions_and_algorithms中的措辞-->. The job of recursive case is to solve sub-problems, while terminating case defines result of shortest sub-problem 

```cpp
int func(some_type input_value) {
  if (is_terminating_case) return result_of_shortest_sub_problem;
  return func(smaller_size);
}
```

#### Reasons to Write Recursion

1.  Code will be more readable with a clearer structure. E.g., different implementation of [merge sort](./merge-sort.md)：

    ```cpp
    // C++ Version
    // Implementation without recursion
    template <typename T>
    void merge_sort(vector<T> a) {
      int n = a.size();
      for (int seg = 1; seg < n; seg = seg + seg)
        for (int start = 0; start < n - seg; start += seg + seg)
          merge(a, start, start + seg - 1, std::min(start + seg + seg - 1, n - 1));
    }

    // Implementation with recursion
    template <typename T>
    void merge_sort(vector<T> a,3int front, int end) {
      if (front >= end) return;
      int mid = front + (end - front) / 2;
      merge_sort(a, front, mid);
      merge_sort(a, mid + 1, end);
      merge(a, front, mid, end);
    }
    ```

    ```python
    # Python Version
    # Implementation without recursion
    def merge_sort(a):
      n = len(a)
      seg, start = 1, 0
      while seg < n:
          while start < n - seg:
              merge(a, start, start + seg - 1, min(start + seg + seg - 1, n - 1))
              start = start + seg + seg
          seg = seg + seg
      
    #Implementation with recursion
    def merge_sort(a, front, end):
      if front >= end:
          return
      mid = front + (end - front) / 2
      merge_sort(a, front, mid)
      merge_sort(a, mid + 1, end)
      merge(a, front, mid, end)
    ```

    Obviously, the recursive version of code is easier to understand than the non-recursive version, which is clear at a glance: sort left half first and then right half then finally merge two halves into one. However, the non-recursive version is unintelligible, full of incomprehensible details of edge computing and too buggy to debug.

2. Learning how to analyze the structure of problem by exercising. If you are familiar with coding recursive programs, you will sharply find out the feature that a problem can be discomposed into similar sub-problem, and then solve it efficiently

#### Disadvantages of Recursion

During executing programs, recursions are implemented by call stack. Every function calling will add a frame in the stack, and every return will do the opposite. However the size of call stack is not infinite. Too many of recursions will lead to the consequence of stack overflow.

Obviously sometimes recursion is efficient, such as merge sort. But **sometimes it is inefficient**, such as counting hairs of Sun Wukong[^ref2]. Call stack will consume extra space, while simple iteration won't. For the example problem: You are given a head of link table, and you are asked to calculate the length of the link table. Here are two different implementations: 

```cpp
// Typical iteration implementation
int size(Node *head) {
  int size = 0;
  for (Node *p = head; p != nullptr; p = p->next) size++;
  return size;
}

// ... or recursion implementation
int size_recursion(Node *head) {
  if (head == nullptr) return 0;
  return size_recursion(head->next) + 1;
}
```

![\[Comparison between two implementation (with clang 10.0 and O1 optimization).\](https://quick-bench.com/q/rZ7jWPmSdltparOO5ndLgmS9BVc)](images/divide-and-conquer-2.png "[Comparison between two implementation (with clang 10.0 and O1 optimization).](https://quick-bench.com/q/rZ7jWPmSdltparOO5ndLgmS9BVc)")

#### Optimization of Recursion

Main articles: [Optimization of searching](../search/opt.md) and [Memorized searching](../dp/memo.md)

More elementary level of recursion implementation may have too many recursions, which may lead to time out. This is when recursion implementation need to be optimized. [^ref3]

### Divide and Conquer

Divide and Conquer is an algorithm design paradigm. Process of algorithms based on it can be divided into three parts: divide, conquer, and combine.

1. Divide: Decompose original problem into two or more similar sub-problems.
2. Conquer: After decomposing problems into some easily solvable bound, solve the sub-problem recursively until solved.
3. Combine: Combine results from sub-problems to obtain final results of original problem.

Generally, problems which can be solved with divide and conquer paradigm have these features:

- The problem can be easily solved when its size is down to a certain level.
- The problem can be decomposed into several sub-problems with smaller size, i.e., the problem has the property of optimal substructure. Results of sub-problems decomposed from original problem can be used and combined into results of original problem.
- Sub-problems decomposed from original problem are independent to each other, i.e., Sub-problems do not contain common sub-problems between them.

???+warning "Warning"
    If sub-problems are not independent, then algorithms using divide-and-conquer paradigm need to solve common sub-problems repeatedly. Thus, unnecessary works would be done. Under such circumstances it is better to use [dynamic programming](../dp/basic.md) rather than divide-and-conquer paradigm.

以归并排序为例。假设实现归并排序的函数名为 `merge_sort`。明确该函数的职责，即 **对传入的一个数组排序**。这个问题显然可以分解。给一个数组排序等于给该数组的左右两半分别排序，然后合并成一个数组。

```cpp
void merge_sort(一个数组) {
  if (可以很容易处理) return;
  merge_sort(左半个数组);
  merge_sort(右半个数组);
  merge(左半个数组, 右半个数组);
}
```

传给它半个数组，那么处理完后这半个数组就已经被排好了。注意到，`merge_sort` 与二叉树的后序遍历模板极其相似。因为分治算法的套路是 **分解 -> 解决（触底）-> 合并（回溯）**，先左右分解，再处理合并，回溯就是在退栈，即相当于后序遍历。

`merge` 函数的实现方式与两个有序链表的合并一致。

## Key points

### Keys of Writing Recursion

**明白一个函数的作用并相信它能完成这个任务，千万不要跳进这个函数里面企图探究更多细节，** 否则就会陷入无穷的细节无法自拔，人脑能压几个栈啊。

以遍历二叉树为例。

```cpp
void traverse(TreeNode* root) {
  if (root == nullptr) return;
  traverse(root->left);
  traverse(root->right);
}
```

这几行代码就足以遍历任何一棵二叉树了。对于递归函数 `traverse(root)`，只要相信给它一个根节点 `root`，它就能遍历这棵树。所以只需要把这个节点的左右节点再传给这个函数就行了。

同样扩展到遍历一棵 N 叉树。与二叉树的写法一模一样。不过，对于 N 叉树，显然没有中序遍历。

```cpp
void traverse(TreeNode* root) {
  if (root == nullptr) return;
  for (auto child : root->children) traverse(child);
}
```

## Difference

### Difference between Recursion and Enumeration

递归和枚举的区别在于：枚举是横向地把问题划分，然后依次求解子问题；而递归是把问题逐级分解，是纵向的拆分。

### Difference between Recursion and Divide and Conquer

递归是一种编程技巧，一种解决问题的思维方式；分治算法很大程度上是基于递归的，解决更具体问题的算法思想。

## Example Problems

???+note "[437. 路径总和 III](https://leetcode-cn.com/problems/path-sum-iii/)" 
    给定一个二叉树，它的每个结点都存放着一个整数值。
    
    找出路径和等于给定数值的路径总数。
    
    路径不需要从根节点开始，也不需要在叶子节点结束，但是路径方向必须是向下的（只能从父节点到子节点）。
    
    二叉树不超过 1000 个节点，且节点数值范围是[-1000000,1000000]的整数。
    
    示例：
    
    ```text
    root = [10,5,-3,3,2,null,11,3,-2,null,1], sum = 8
    
          10
         /  \
        5   -3
       / \    \
      3   2   11
     / \   \
    3  -2   1
    
    返回 3。和等于 8 的路径有：
    
    1.  5 -> 3
    2.  5 -> 2 -> 1
    3. -3 -> 11
    ```
    
    ```cpp
    /**
     * 二叉树结点的定义
     * struct TreeNode {
     *     int val;
     *     TreeNode *left;
     *     TreeNode *right;
     *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
     * };
     */
    ```

??? note "参考代码"
    ```cpp
    int pathSum(TreeNode *root, int sum) {
      if (root == nullptr) return 0;
      return count(root, sum) + pathSum(root->left, sum) +
             pathSum(root->right, sum);
    }
    
    int count(TreeNode *node, int sum) {
      if (node == nullptr) return 0;
      return (node->val == sum) + count(node->left, sum - node->val) +
             count(node->right, sum - node->val);
    }
    ```

??? note "题目解析"
    题目看起来很复杂，不过代码却极其简洁。
    
    首先明确，递归求解树的问题必然是要遍历整棵树的，所以二叉树的遍历框架（分别对左右子树递归调用函数本身）必然要出现在主函数 pathSum 中。那么对于每个节点，它们应该干什么呢？它们应该看看，自己和它们的子树包含多少条符合条件的路径。好了，这道题就结束了。
    
    按照前面说的技巧，根据刚才的分析来定义清楚每个递归函数应该做的事：
    
    `PathSum` 函数：给定一个节点和一个目标值，返回以这个节点为根的树中，和为目标值的路径总数。
    
    `count` 函数：给定一个节点和一个目标值，返回以这个节点为根的树中，能凑出几个以该节点为路径开头，和为目标值的路径总数。
    
    ??? note "参考代码（附注释）"
        ```cpp
        int pathSum(TreeNode *root, int sum) {
          if (root == nullptr) return 0;
          int pathImLeading = count(root, sum);  // 自己为开头的路径数
          int leftPathSum = pathSum(root->left, sum);  // 左边路径总数（相信它能算出来）
          int rightPathSum =
              pathSum(root->right, sum);  // 右边路径总数（相信它能算出来）
          return leftPathSum + rightPathSum + pathImLeading;
        }
        int count(TreeNode *node, int sum) {
          if (node == nullptr) return 0;
          // 能不能作为一条单独的路径呢？
          int isMe = (node->val == sum) ? 1 : 0;
          // 左边的，你那边能凑几个 sum - node.val ？
          int leftNode = count(node->left, sum - node->val);
          // 右边的，你那边能凑几个 sum - node.val ？
          int rightNode = count(node->right, sum - node->val);
          return isMe + leftNode + rightNode;  // 我这能凑这么多个
        }
        ```
    
    还是那句话，**明白每个函数能做的事，并相信它们能够完成。**
    
    总结下，`PathSum` 函数提供了二叉树遍历框架，在遍历中对每个节点调用 `count` 函数（这里用的是先序遍历，不过中序遍历和后序遍历也可以）。`count` 函数也是一个二叉树遍历，用于寻找以该节点开头的目标值路径。

## Exercise

- [LeetCode 上的递归专题练习](https://leetcode.com/explore/learn/card/recursion-i/)
- [LeetCode 上的分治算法专项练习](https://leetcode.com/tag/divide-and-conquer/)

## References and Footnotes

[^ref1]: Assume natural numbers count from $1$.
[^ref2]: Sun Wukong is a character in Chinese mythology. As described in *Journey to the West* he has 84,000 recyclable hairs, which can be considered as countless. 
[^ref3]: [labuladong 的算法小抄 - 递归详解](https://labuladong.gitbook.io/algo/suan-fa-si-wei-xi-lie/di-gui-xiang-jie)
