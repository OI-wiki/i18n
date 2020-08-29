author: CBW2007, ChungZH, TrisolarisHD, abc1763613206, Ir1d

## Introduction

DFS (Depth First Search) is a really common algorithm used in OI and most of the problems can be solved using it. However, in most cases, it can only get partial points, because the time complexity of DFS is extremely high and there are very few problems that can be solved with a brute-force DFS. (If you have not studied DFS, please refer to [dfs](./dfs.md) for more details).

But how to get a few more points when DFS is not the best answer? This article will introduce some practical optimization algorithms (commonly known as "pruning").

Let's first look at a section of DFS template, and the following templates will be modified on this basis.

```cpp
int ans = worst_case, now;  // now is the current answer
void dfs(input_data) {
  if (destination_arrived) ans = the_best_from_the_current_and_existing_solutions;
  for (all_possible_solutions)
    if (feasible) {
      carry_out_operation;
      dfs(downsizing);
      withdraw_operation;
    }
}
```

Among them, ans can be the record of the solution, then the best one selected from the current and the existing solutions will become the output answer.

## Pruning methods

There are three most commonly used pruning: memory search, optimal pruning, and feasible pruning.

### Memoization search

Because the same input value in search often has the same solution, we can use an array to memorize, see [memoization search](../dp/memo.md) for details.

 **template:** 

```cpp
int g[MAXN];  // define memoization array
int ans = worst_case, now;
void dfs f(input_data) {
  if (g[size] != invalid_value) return;  // or record the solution, depending on the situation
  if (destination_arrived) ans = the_best_from_the_current_and_existing_solutions;  // or output the solution, depending on the situation
  for (all_possible_solutions)
    if (feasible) {
      carry_out_operation;
      dfs(downsizing);
      withdraw_operation;
    }
}
int main() {
  ... memset(g, invalid_value, sizeof(g));  // initialize memoization array
  ...
}
```

### Optimal pruning

There is another reason why the operation is slow in the search, that is, the search is still being performed when the current solution is already worse than the existing solution. Then we only need to judge whether the current solution is already worse than the existing solution.

 **template:** 

```cpp
int ans = worst_case, now;
void dfs(input_data) {
  if (now is worse than ans) return;
  if (destination_arrived) ans = the_best_from_the_current_and_existing_solutions;
  for (all_possible_solutions)
    if (feasible) {
      carry_out_operation;
      dfs(downsizing);
      withdraw_operation;
    }
}
```

### Feasible pruning

 **template:** 

If the current solution cannot be used but is till running, it is also the cause of the slow operations during the search.

```cpp
int ans = worst_case, now;
void dfs(input_data) {
  if (current solution cannot be used) return;
  if (destination_arrived) ans = the_best_from_the_current_and_existing_solutions;
  for (all_possible_solutions)
    if (feasible) {
      carry_out_operation;
      dfs(downsizing);
      withdraw_operation;
    }
}
```

## Pruning

There are many ways of pruning, and most of them need to analyze specific problems. Here we introduce a few common pruning ideas.

- Extreme method: consider the extreme situation. If the most extreme (ideal) situation cannot be satisfied, the result of the actual situation will certainly not be better.

- Adjustment method: cut out duplicate subtrees and subtrees that are obviously not the most "promising" ones by comparing them.

- Mathematical method: for example, use the connectivity in graph theory, modular equation analysis in number theory, or inequality scaling to estimate lower bounds, and so on.

## Sample problem

???+note "Job assignment problem"
     **problem description** 

    There are $n$ jobs to be assigned to $n$ individuals to complete, and each individual can complete one job. The time taken by the $i$-th person to complete the $k$-th job is a positive integer $t_{i,k}$ , where $1 \leq i, k \leq n$. Try to come up with an assignment plan that minimizes the total time to complete these $n$ jobs.

    Input includes $n + 1$ lines.

    The first line is a positive integer $n$ .

    Each line from $2$ to $n + 1$ contains $n$ positive integers, forming a matrix of $n \times n$ . In this matrix, the element $t_{i,k}$ in the $i$-th row and the $k$-th column represents the time it takes for the $i$-th person to complete the $k$-th job.

    The output contains a positive integer, representing the smallest sum of time among all assignment plans.

    **data range**

    $1 \leq n \leq  15$

    $1 \leq t_{i,k} \leq 10^4$

    **input sample**

    ```text
    5
    9 2 9 1 9
    1 9 8 9 6
    9 9 9 9 1
    8 8 1 8 4
    9 1 7 8 9
    ```

    **output sample**

    ```text
    5
    ```

Since everyone must be assigned with a job, a two-dimensional array `time[i][j]` can be created to represent the time spent by the $i$-th person to complete the $j$-th job. Given a cycle, start with the first person and distribute jobs until everyone is assigned. When assigning job to the $i$-th person, it will re-check whether each job has been assigned, if not, assign to the $i$-th person, otherwise the next job will be checked. A one-dimensional array `is_working[j]` can be used to indicate whether the $j$-th job has been assigned. If not, `is_working[j]=0`, otherwise `is_working[j]=1`. Use recursion, return to the previous job after the end of the cycle, cancel the assigned jobs for this round, and assign the next job until it can be assigned. In this way, after going back to the first job, all feasible solutions can be obtained.

Checking the job assignment is actually checking that when a feasible solution is obtained, the first dimension subscript of the two-dimensional array are different and the second dimension subscripts are different. And what we want to obtain is the minimum sum of time to complete the $n$ work, which is the smallest sum of time in solutions. Therefore, we need to define a global variable `cost_time_total_min` to represent the smallest sum of time found so far. The initial value of ` cost_time_total_min` is the sum of `time[i][i]`, that is, the sum of the diagonal working time. When everyone has been assigned with job, compare `count` and `cost_time_total_min`. If `count` is less than `cost_time_total_min`, an optimal solution has been found. At this time, assign `count` to `cost_time_total_min`.

However, considering the efficiency of the algorithm, there is still one pruning optimization that can be done. That is, every time the value of the local cost variable `count` is calculated, if `count` is already greater than `cost_time_total_min`, there is no need to assign further, because the solution obtained at this time is necessarily not the optimal solution.

??? note "Sample code"
    ```C++
    #include <cstdio>
    #define N 16
    int is_working[N] = {0};  // whether a job has been assigned
    int time[N][N];           // time to finish a job
    int cost_time_total_min;  // the minimum sum of time to complete n jobs
    // i represents the i-th person，count represents the sum of the cost of jobs
    void work(int i, int count, int n) {
      // if i exceeds the maximum number of jobs that can be assigned, the assignment is complete, and count is smaller than the original
      // cost_time_total_min cost less, then update the value of cost_time_total_min
      if (i > n && count < cost_time_total_min) {
        cost_time_total_min = count;
        return;
      }
      // recursion
      if (count < cost_time_total_min) {
        // j represents the j-th job
        for (int j = 1; j <= n; j++) {
          // If the job is not assigned is_working = 0
          if (is_working[j] == 0) {
            // assign job is_working = 1
            is_working[j] = 1;
            // assign the job to the (i + 1)-th person
            work(i + 1, count + time[i][j], n);
            // after a round of iteration is done, return to the previous person and redistribute
            // reset is_working[j] as 0
            is_working[j] = 0;
          }
        }
      }
    }
    int main() {
      int n;
      scanf("%d", &n);
      for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
          scanf("%d", &time[i][j]);
        }
        cost_time_total_min += time[i][i];
      }
      work(1, 0, n);
      printf("%d\n", cost_time_total_min);
      return 0;
    }
    ```
    
