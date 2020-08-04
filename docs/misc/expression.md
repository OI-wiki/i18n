author: Ir1d, Anguei, hsfzLZH1, siger-young, HeRaNO

What expression evaluation trying to solve is generally to output the value for input expression represented by a string. Of course, there are also variants such as checking whether the expression contains parentheses, exponential calculation, how many variables are included, and whether multiple expressions are equivalent, etc.

The part to check the equivalence of expressions uses mathematical tools such as Lagrangian interpolation, and will not be discussed here.

There are two common methods: one is recursive and the other is non-recursive.

## Recursive

The recursive method is to split the expression into an expression tree as shown in the figure, and then perform operations on the tree from bottom to top. ![](./images/bet.png)

[Tree traversals](../graph/tree-basic.md#_10) on expression trees can get different types of expressions:

- Preorder traversal corresponding to prefix expressions (Polish Notation)
- Middle order traversal corresponds to infix expression
- Post-order traversal corresponding to postfix expressions (Reverse Polish Notation)

## Non-recursive

The non-recursive method is to define two [stacks](../ds/stack.md) to store operators and operands respectively. Whenever a number is encountered, it is directly pushed into the number stack; whenever an operator is encountered, the element in the previous operator stack must be searched, and the appropriate pop operation will be performed according to the pre-defined priority(The value of the corresponding sub-expression).

What we need to know: the arithmetic expressions have three types, namely prefix expressions, infix expressions, and postfix expressions. Among them, infix expressions are the most commonly used expressions in our daily lives; Postfix expressions are the easiest expressions for computers to understand. The reason is that suffix expression does not need parentheses, and its order of operations is uniquely determined. For example: In the postfix expression $3~2~*~1~-$ , first we calculate $3 \times 2 = 6$ (using the last operator, that is, the operator on the top of the stack), and then calculate $6 - 1 = 5$ . It can be seen that for a suffix expression, we only need **to maintain a number stack. Each time an operator is encountered, the top elements from two stacks are popped out, and the result of the operation is pushed back into the stack**. Finally, the only element in the stack is the operation result of the suffix expression. The time complexity is $O(n)$ .

So, for the calculation of ordinary infix expressions, we can convert them into postfix expressions and then perform calculations. The conversion method is also very simple. Just create a stack for storing operators and scan the infix expression:

1. If you encounter a number, directly output the number to the suffix expression (the following "output" all indicates the output to the suffix expression);
2. If you encounter a left parenthese, push it to the stack;
3. If you encounter a right parenthese, keep outputting the top element of the stack until you encounter a left parenthese. (The left parenthese is popped from the stack withou output)
4. If you encounter other types of the operators, continuously remove all operators whose operation priority is greater than or equal to the current operator and output. Finally, the new symbol is pushed into the stack.
5. Output the remaining symbols in the stack in turn, and the expression conversion ends.

Time complexity: $O(n)$ .

Sample code:

```cpp
// The following code is taken from author's NOIP2005 equivalent expression
std::string convert(const std::string &s) {  // convert infix expression to postfix expression
  std::stack<char> oper;
  std::stringstream ss;
  ss << s;
  std::string t, tmp;
  while (ss >> tmp) {
    if (isdigit(tmp[0]))
      t += tmp + " ";  // 1. if encounter a number, output it
    else if (tmp[0] == '(')
      oper.push(tmp[0]);       // 2. if encounter a left parenthese, push it to the stack
    else if (tmp[0] == ')') {  // 3. f encounter a right parenthese
      while (!oper.empty() && oper.top() != '(')
        t += std::string(1, oper.top()) + " ",
            oper.pop();  // keep taking out the top of the stack and output it until the top of the stack is a left parenthesis,
      oper.pop();        // then pop the left parenthese
    } else {             // 4. if encounter an operator
      while (!oper.empty() && level[oper.top()] >= level[tmp[0]])
        t += std::string(1, oper.top()) + " ",
            oper.pop();  // as long as the priority of the operator on the top of the stack is not lower than that of the new operator, the top of the stack should be continuously popped out
      oper.push(tmp[0]);  // finally push the new operator into the stack
    }
  }
  while (!oper.empty()) t += std::string(1, oper.top()) + " ", oper.pop();
  return t;
}

int calc(const std::string &s) {  // calculate the converted postfix expression
  std::stack<int> num;
  std::stringstream ss;
  ss << s;
  std::string t, tmp;
  while (ss >> tmp) {
    if (isdigit(tmp[0]))
      num.push(stoi(tmp));
    else {
      int b, a;  // pop the top element from the stack, and pay attention to the order
      if (!num.empty()) b = num.top();
      num.pop();
      if (!num.empty()) a = num.top();
      num.pop();
      if (tmp[0] == '+') num.push(a + b);
      if (tmp[0] == '-') num.push(a - b);
      if (tmp[0] == '*') num.push(a * b);
      if (tmp[0] == '^') num.push(qpow(a, b));
    }
  }
  return num.top();
}
```

## Practice problems

> NOTE: The first two problems are originally in Chinese.

1. [Expression Evaluation (NOIP2013)](https://vijos.org/p/1849)
2. [Postfix expression](https://www.luogu.com.cn/problem/P1449)
3. [Transform the Expression](https://www.spoj.com/problems/ONP/)
