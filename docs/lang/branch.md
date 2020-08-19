By default, a program is executed following the order of code. Sometimes when certain statements need to be selectively executed, we can use the the branch feature to achieve such flow control. Choosing the appropriate branch statement can improve the efficiency of the program.

## if statement

### Basic if statement

The following code shows the structure of a basic if statement.

```cpp
if (condition) {
  main body;
}
```

The `if` statement calculates the condition to check: if the result is true (nonzero), the statement is executed, otherwise it is not executed.

If there is only a single statement in the body, the curly braces can be omitted.

### if...else statement

```cpp
if (condition) {
  statement1;
} else {
  statement2;
}
```

The `if...else` statement is similar to the `if` statement, and the `else` does not need to write more conditions. When the condition of the `if` statement is satisfied, the statement in the `if` will be executed. Otherwise, the statement in `else` will be executed. Similarly, the curly braces can be omitted when the main part has only one statement.

### else if statement

```cpp
if (condition1) {
  statement1;
} else if (condition2) {
  statement2;
} else if (condition3) {
  statement3;
} else {
  statement4;
}
```

The `else if` statement is a combination of `if` and `else`, which checks multiple conditions and selects different statement branches. There is no need to write conditions in the last `else` statement. For example, if condition 1 is true, execute the statement 1; if condition 3 is true and both conditions 1 and 2 are false, statement 3 is executed, and statement 4 is executed when all conditions are false.

In fact, this statement is equivalent to the `else` clause of the first `if` with only one `if` statement, so the curly braces are omitted and placed together. If the conditions are parallel to each other, writing this way can make the code logic clearer.

Logically, it is roughly equivalent to this passage:

> When solving a quadratic equation in one variable, the relationship between the roots of the equation and the discriminant:
>
> -   If ( $\Delta<0$ )
>     The equation has no solution;
> -   Otherwise, if ( $\Delta=0$ )
>     The equation has two identical real number solutions;
> -   Otherwise
>     The equation has two different real number solutions;

## switch statement

```cpp
switch (condition) {
  case label1:
    statement1;
  case label2:
    statement2;
  default:
    statement3;
}
```

When the `switch` statement is executed, the value is selected first, and then the corresponding label is selected according to the value of the choice sentence. And the execution starts from that label. Among them, the choice expression must be an integer type expression, and the label must be an integer type constant. E.g:

```cpp
int i = 1;  // the data type of i here is an integer, which satisfies the requirements of an expression of integer type
switch (i) {
  case 1:
    cout << "OI WIKI" << endl;
}
```

```cpp
char i = 'A';
// the data type of i here is character, but it is a kind of integer in
// nature and satisfies the requirement of an integer-typed expression
switch (i) {
  case 'A':
    cout << "OI WIKI" << endl;
}
```

The `switch` statement should be interrupted by adding the `break` according to the requirements, otherwise all the statements in the following `case` and the statement in the default will be executed after the corresponding `case` is selected. Please refer to the code for specific examples.

```cpp
char i = 'B';
switch (i) {
  case 'A':
    cout << "OI" << endl;
    break;

  case 'B':
    cout << "WIKI" << endl;

  default:
    cout << "Hello World" << endl;
}
```

If you don't want the following branch statements to be executed, the `break` is required. For specific examples, please refer to the following code.

```cpp
char i = 'B';
switch (i) {
  case 'A':
    cout << "OI" << endl;
    break;

  case 'B':
    cout << "WIKI" << endl;
    break;

  default:
    cout << "Hello World" << endl;
}
```

The output of above code is "WIKI", because the following statements will not continue to be executed for the existence of `break` statement. The `default` statement does not need a `break`, because there is no statement below.

It is optional to add curly braces in the `case` clause of `switch`. But note that the curly braces must be added if you need to define a variable in the `switch` statement. E.g:

```cpp
char i = 'B';
switch (i) {
  case 'A': {
    int i = 1, j = 2;
    cout << "OI" << endl;
    ans = i + j;
    break;
  }

  case 'B': {
    int qwq = 3;
    cout << "WIKI" << endl;
    ans = qwq * qwq;
    break;
  }

  default: { cout << "Hello World" << endl; }
}
```

??? note "How to understand switch"
    In the article above, a lot of terms such as "case clause" and "case sub-clause" are used. In fact, in the underlying implementation, `switch` is equivalent to a set of jump statements. For this reason, clever techniques like Duff's Device exists. You can dig deeper about that if you are interested.