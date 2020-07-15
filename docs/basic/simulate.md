Simulation, as the name implies, is the operation that computers use to simulate the process required in the question. Similar to NOIP 2014's [Big Bang version rock paper scissors] (https://uoj.ac/problem/15) (original link in Chinese), coding according to the meaning of the title would be fine.

Of course, simulations are not always easy to write. See classic questions like [World of Warcraft] (http://bailian.openjudge.cn/practice/3750/) and [pig kingdom kill] (https://loj.ac/problem /2885) for reference.

Simulation questions usually have large code size, many operations, and complicated ideas. And because of its large amount of code, the debugging process is really difficult. If you write errors during the competition, it would be quite a waste of time.

Therefore, for simulation questions, following the suggestions below may help you improve the speed:


1. Before writing the code, write as much as possible on the scratch paper to implement the process;
2. In the code, try to modularize each part as a function, structure, or class;
3. For some concepts that may be reused, they can be transformed in a unified way so they are easier to handle: for example, if a question gives you "YY-MM-DD hour:minute", processing it in a function into seconds format will help reduce confusion;
4. When debugging, debug in blocks. The advantage of modularity is that it is convenient to adjust a certain part separately;
5. When writing the code, think clearly. Do not think intuitively, instead, write the solution step by step on paper and follow it.


In fact, the above steps are also very helpful in solving other types of problems.