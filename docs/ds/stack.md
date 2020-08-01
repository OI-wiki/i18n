## Stack

The stack is a linear data structure commonly used in OI. Please note that this article mainly talks about the data structure called stack, not the system stack/stack-based memory in computing architectures.

The modification of the stack follows the principle of last in first out, so the stack is usually called the last in first out table, or LIFO table for short.

!!! warning
    LIFO means that the last one **currently in the container** goes out first.
    
    Let's consider the following stack:
    
    ```text
    push(1)
    pop(1)
    push(2)
    pop(2)
    ```
    
    If you consider it as a whole: 1 is the first one pushed into the stack, the first one popped; 2 is the last one pushed into the stack, the last one popped. This would become a first-in first-out table, which is obviously wrong.
    
    Therefore, when considering whether the data structure is LIFO or FIFO, the situation in the current container should be considered.

We can easily use an array to simulate a stack, code shown as follows:

```cpp
int stk[N];
// Here use stk[0] (i.e. *stk) to represent the number of elements in the stack, and it is also the index on the top of the stack
// push into the stack
stk[++*stk] = var1;
// get the top element from stack
int u = stk[*stk];
// pop from stack: pay attention to the out-of-boundery problem. When *stk == 0, it can no longer be popped
if (*stk) --*stk;
// empty stack
*stk = 0;
```

Also, STL provides this method: `std::stack` 

```cpp
#include <stack>
// stack construction:
1. stack<Typename T> s;
2. stack<Typename T, Container> s;
/* The container of stack needs to realize following interfaces:
 * back()
 * push_back()
 * pop_back()
 * Standard container like std::vector / deque / list statisfy these requirements
 * If you use the 1 method to construct, the default container uses deque
 */
```

 `std::stack` supports assignment operator `=` 

Element access:

 `s.top()` return the top of the stacK:

Capacity:

 `s.empty()` return whether is empty

 `s.size()` return the number of elements

Modification:

 `s.push()` push the element to the top of the stack

 `s.pop()` pop the element on top of the stack

Other operators:

 `==` 、 `!=` 、 `<` 、 `<=` 、 `>` 、 `>=` can compare the values of two `stack` lexicographically
