author: frank-xjh
translator: CamberLoid

Last translate with upstream: []()

This article will briefly introduce the enumerate method.

## Introduction

<!---
似乎没人管这个叫Enumerate
稍微查找了下资料，更适合叫Brute-force search或Exhaustive search(也就是暴力搜索)
所以枚举法的Enumerate似乎不等于「枚举」
-->

Enumerate method, or exhaustive search, is a problem-solving strategy based on existing knowledge.

The core principle of enumerating strategy is, by enumerating every possible answers from possible sets, then determine whether the answer satisfies the given demands.<!---??-->

## Keypoints of Enumerating

### Find the solution space 

You need to build a simple mathematical model. 

### Smaller the space of enumerating

while using enumerating method, ensure you have figured out the following two questions to avoid unnecessary time cost: 

- What is the range of searching?
- Does all the possible answers 

### Pick an appropriate enumerating order

根据题目判断。比如例题中要求的是最大的符合条件的素数，那自然是从大到小枚举比较合适。

## Example

Here is an example solving by enumerating method and optimization of enumerating range. 

!!! Problem
    Given an integer array without two same element. Your task is to find out the number of pairs whose sum is $0$.

??? note "Problem solving"
    The code to enumerate two numbers can be easily coded.
    
    ```cpp
    // C++ Version
    for (int i = 0; i < n; ++i)
      for (int j = 0; j < n; ++j)
        if (a[i] + a[j] == 0) ++ans;
    ```
    
    ```python
    # Python Version
    for i in range(0, n):
      for j in range(0, n):
          if(a[i] + a[j] == 0):
              ans = ans + 1
    ```
    
    Here is how to optimize enumerate range. As the problem doesn't require the pair to be ordered, the answer is twice of the ordered one. (e.g. if `(a, b)` is a valid answer, then `(b, a)` is valid too) In this situation, we only need to calculate ordered answers, then multiply it by two. 
    
    It may be better to require the first number to appear in the front position. Here is the code implementation:
    
    ```cpp
    // C++ Version
    for (int i = 0; i < n; ++i)
      for (int j = 0; j < i; ++j)
        if (a[i] + a[j] == 0) ++ans;
    ```
    
    ```python
    # Python Version
    for i in range(0, n):
      for j in range(0, i):
          if(a[i] + a[j] == 0):
              ans = ans + 1
    ```
    
    It is easy to find out that the enumeration range of $j$ has been shortened, which reduces the time overhead of this code.
    
    However this is not the fastest method.
    
    Is it necessary to enumerate both elements? After enumerating one element, as the problem has already determined the condition of the other element, we can reduce the time of enumerating the other element by finding out a way to directly determine whether the element exists. When the data size allows, we can use the bucket idea to record the number of enumerated numbers.
    
    ```cpp
    // C++ Version
    bool met[MAXN * 2];
    memset(met, 0, sizeof(met));
    for (int i = 0; i < n; ++i) {
      if (met[MAXN + a[i]]) ans += 1;
      met[MAXN + a[i]] = true;
    }
    ```
    
    ```python
    # Python Version
    met = [False] * MAXN * 2
    for i in range(0, n):
        if met[MAXN - a[i]]:
            ans = ans + 1
        met[a[i] + MAXN] = True
    ```

## Exercise

- [2811: 熄灯问题 - OpenJudge](http://bailian.openjudge.cn/practice/2811/)
