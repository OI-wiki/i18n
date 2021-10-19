Sometimes, we need to do something for several times. To avoid from writing too many repetitive codes, we need to use loop.

Sometimes, the times of loops is not a constant. In this case we are not able to repeat the code, and we must use loop.

## for Statement
<!---Well, this is informal-->
The following codes show the structure of a for-statement:

```cpp
for (init_statement; condition; iterator_expression) {
  loop_body;
}
```

The following illustration shows how for-statement works:

![](images/for-loop.svg)

e.g., read in $n$ numbers:

```cpp
for (int i = 1; i <= n; ++i) {
  cin >> a[i];
}
```

Any part inside `for()` can be omitted. If the condition were omitted, the condition will be treated as always true.

## while Statement

The following codes shows the structure of a while-statement:

```cpp
while (condition) {
  loop_body;
}
```

The following illustration shows how while-statement works:

![](images/while-loop.svg)

E.g., solve the Collatz's 3n+1 problem:

```cpp
while (x > 1) {
  if (x % 2 == 1) {
    x = 3 * x + 1;
  } else {
    x = x / 2;
  }
}
```

## do...while Statement

The following codes shows the structure of a do-while-statement:

```cpp
do {
  loop_body;
} while (condition);
```

The following illustration shows how do-while-statement works:

![](images/do-while-loop.svg)

Different from while-statement, a do-while-statement performs loop body first, then check the condition.

E.g., enumerating arrangements:

```cpp
do {
  // do someting...
} while (next_permutation(a + 1, a + n + 1));
```

## Relationship Between Three Loop Statements.

```cpp
// for-statement

for (statement1; statement2; statement3) {
  statement4;
}

// while-statements

statement1;
while (statement2) {
  statement4;
  statement3;
}
```

The two usages are equivalent if `statement4` doesn't contain `continue` statement. However, the latter is rarely used.

```cpp
// while-statement

statement1;
while (statement2) {
  statement1;
}

// do...while-statement

do {
  statement1;
} while (statement2);
```

The two usages are also equivalent if `statement1` doesn't contain `continue` statement.

```cpp
while (1) {
  // do something...
}

for (;;) {
  // do something...
}
```

The two usage will loop forever until being exited by `break`(will explain later).

It is obvious that the three types of statements can be substituted for each other. But, generally speaking, the selection of statements observes the following principles:

1. Use for-statement if there is a fixed step of increment, most commonly, enumerating.
2. Use while-statement if only the end-of-loop condition is determined.
3. Use do-while-statement instead of while-statement if it is need to execute loop body first and check condition then. This is rarely used. A frequently used scenario is for user inputting.

## break And continue Statement

The function of a break statement is to exit the loop.

The function of a continue statement is to skip the rest of loop statements and jump back to the beginning of loop, or more accurate, the checking condition step of while-statement or the iterating statement of for-statement. 

```cpp
for (int i = 1; i <= 10; ++i) {
  std::cout << i << std::endl;
  if (i > 3) break;
  if (i > 2) continue;
  std::cout << i << std::endl;
}

/*
The output is:
1
1
2
2
3
4
*/
```

Both of break and continue statement can be used inside the loop body of three loop statements.

Generally speaking, the using of break and continue statement will clarify the logic of codes. For example:

```cpp
// Unclear logic and complicated structure of curly brackets.

for (int i = 1; i <= n; ++i) {
  if (i != x) {
    for (int j = 1; j <= n; ++j) {
      if (j != x) {
        // do something...
      }
    }
  }
}

// Clearer logic and simple structure of curly brackets.

for (int i = 1; i <= n; ++i) {
  if (i == x) continue;
  for (int j = 1; j <= n; ++j) {
    if (j == x) continue;
    // do something...
  }
}
```

```cpp
// Complicated condition of for-statement, which doesn't reflect the essence of enumerating.

for (int i = l; i <= r && i % 10 != 0; ++i) {
  // do something...
}

// Use for-statement for enumerating and break-statement for "until what".

for (int i = l; i <= r; ++i) {
  if (i % 10 == 0) break;
  // do something...
}
```

```cpp
// Repetitive statements and unnatural order.

statement1;
while (statement3) {
  statement2;
  statement1;
}

// No repetitive statements and clear order.

while (1) {
  statement1;
  if (!statement3) break;
  statement2;
}
```

## Translation Information

- Original Article: https://oi-wiki.org/lang/loop/
- Last Translated commit: 
- Translator: CamberLoid