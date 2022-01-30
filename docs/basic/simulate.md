Last translate with upstream: [58b9fe6](https://github.com/OI-wiki/OI-wiki/commit/58b9fe67d667d265261d733b70b90e6cf0eaefdd) on Feb 8, 2021.

This article will briefly introduce implementation method.

## Introduction

Implementation, also known as Simulation, as the name implies, is the method that use computers to simulate the operations required in the problem.

Implementation problems usually have large code size, many operations, and complicated logics. And because of its large amount of code, the debugging process is really difficult. Therefore, it would be quite time-consuming if you made mistakes during contests.

## Tricks for writing 

When writing solution for implementation problems, the following suggestions below may help you improve the speed:

- Before writing the code, write down the process of your implementation on scratch paper as complete as possible;
- In the code, try to modularize each part as a function, structure, or class;
- For some concepts that may be reused, they can be transformed in a unified way so they are easier to handle: for example, if a problem gives you "YY-MM-DD hour:minute", use a function to turn it into seconds format will help reduce confusion;
- When debugging, debug in blocks. The advantage of modularity is that it is convenient to adjust a certain part separately;
- When writing the code, think clearly. Do not think intuitively, instead, follow the steps you have written on the scratch paper.

In fact, the above steps are also very helpful in solving other types of problems.

## Example

???+note " [Climbing Worm - HDU](http://acm.hdu.edu.cn/showproblem.php?pid=1049"
    An inch worm is at the bottom of a well $n$ inches deep. It has enough energy to climb $u$ inches every minute, but then has to rest a minute before climbing again. During the rest, it slips down $d$ inches. The process of climbing and resting then repeats. How long before the worm climbs out of the well? We'll always count a portion of a minute as a whole minute and if the worm just reaches the top of the well at the end of its climbing, we'll assume the worm makes it out.

??? note "Solution"
    Directly implementing the process of worm's climbing will do the trick. Use a loop statement to repeat the process of climbing, and jump out when the climbed length greater than or equal to the depth of well. Note that both ascending and descending have time cost.

??? note "Example Code"
    ```cpp
    #include <cstdio>
    int main(void) {
      int n = 0, u = 0, d = 0;
      while (scanf("%d %d %d", &n, &u, &d) && n != 0) {
        int time = 0, dist = 0;
        while (true) {
          dist += u;
          time++;
          if (dist >= n) break;
          dist -= d;
          time++;
        }
        printf("%d\n", time);
      }
      return 0;
    }
    ```
    
## Exercises

- [NOIP2014 Rock, Paper, Scissors, Lizard, Spock](https://uoj.ac/problem/15) (Chinese)
- [3750 World of Warcraft - OpenJudge](http://bailian.openjudge.cn/practice/3750/) (Chinese) 
- [SDOI2010: Pig Kingdoms slaughter](https://loj.ac/p/2885) (Chinese) 