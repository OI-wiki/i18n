author: Ir1d, tsagaanbar

## Declaration of Function

A function in programming is generally a compound of several statements. We can also call it **subroutine**. While programming, if there are some repetitive routine, we can extract it and form a function. A function can receive several values called the parameters of function. A function can also return a certain value called the returning value of function.

Declaring a function, we need to determine the type of returning value, the identifier of function, and its parameter list.

```cpp
// Returning Type: int
// Identifier of Function: some_function
// Parameter List: int, int
int some_function(int, int);
```

In the example above, we declared a function named `some_function`. It is required to receive two parameters of `int`, and the returning value is also `int`. The type of returning value is also `int`. <!---可以认为，这个函数将会对传入的两个整数进行一些操作，并且返回一个同样类型的结果。(是不是啰嗦了)-->

## Implementing an Function

It is not enough if there is only declaration of function, as it only let us know the interface type (i.e., what data should receive or return) of a function when calling. It lacks of implementation, also known as its definition. We can implement it at any place after its declaration. (Or, implement in another file. However, it is needed to be given with other separately compiled file when linking.)  

If a function has its returning value, then it will return the value to the caller by using return-statement. Once the function executes to the return-statement, the current function is immediately terminated and any statement after it won't be executed.

```cpp
int some_function(int, int);  // Declaration

/* some other code here... */

int some_function(int x, int y) {  // Implementation
  int result = 2 * x + y;
  return result;
  result = 3;  // This statement won't be executed.
}
```

In the definition, we named variables in the parameter list. Then we will be able to use these variables in the implementation of functions.

If they are in the same file, we can also **put the declaration and its implementation together**, or in other word, finish its implementation when declaring.

```cpp
int some_function(int x, int y) { return 2 * x + y; }
```

If one function doesn't need a returning value, the returning type will be `void`; If one function doesn't need parameters, the parameter list can be empty. Similarly, a function without returning value will be terminated after executing to `return;`.

```cpp
void say_hello() {
  cout << "hello!\n";
  cout << "hello!\n";
  cout << "hello!\n";
  return;
  cout << "hello!\n";  // This statement won't be executed.
}
```

## Calling of Functions

Like variables, a function need to declare first and then become available to usable. <!---使用函数的行为，叫做“调用（call）”。这句话英文语境下没有用-->We can call function inside any other function, including the function itself. The behaviour that a function is calling itself is called **recursion**.

For most programming language, the way to call a method is by using **the identifier of the function plus a pair of brackets** `()`. For example, `foo()`. If parameters are required, we need to fill them in order into the brackets and separating them by comma. For example, `foo(1, 2)`. The calling of a function is also an expression, **the value of which** is the **returning value**.

Parameters written in the declaration can be considered as available variables inside current calling of the function. These value will be initialized by the passed value. Look  the following example below:

```cpp
int foo(int, int);

/* ... */

void foo(int x, int y) {
  x = x * 2;
  y = y + 3;
}

/* ... */

a = 1;
b = 1;
// Before calling: a = 1, b = 1
foo(a, b);  // Calling: foo
            // After calling: a = 1, b = 1
```

In the example above, `foo(a, b)` is a calling of `foo`. When calling, the variables `x` and `y` from `foo` is separately initialized by the value of `a` and `b` from where it is called. Therefore, modification of `x` and `y` from `foo` **won't affect the value of variable where it is called**.

If we need to modify the value of variables in the function (subroutine), we need to *pass by reference*.

```cpp
void foo(int& x, int& y) {
  x = x * 2;
  y = y + 3;
}

/* ... */

a = 1;
b = 1;
// Before calling: a = 1, b = 1
foo(a, b);  // Calling foo
            // After calling: a = 2, b = 4
```

As the code shows, we can see there is a and-character `&` after the `int` in the functions's parameter list, which means it is a **reference** of `int`. When calling `foo`, the `a` and `b` initialize two references of `int`, `x` and `y`, from `foo`, which can be considered as an alternative name of `a` and `b`. Operating `x` and `y` of `foo` is operating `a` and `b` from where it calls.

## The `main` Function

Specially, every executable C/C++ program need a function called `main`. Any program will begin from the function `main`.

> The main function is allowed to have its parameter, by using which we can get commands passed from external environments, also known as *command arguments*, to have different behaviours.

The following shows a block of code calling function (or subroutine).

```cpp
// hello_subroutine.cpp

#include <iostream>

void say_hello() {
  std::cout << "hello!\n";
  std::cout << "hello!\n";
  std::cout << "hello!\n";
}

int main() {
  say_hello();
  say_hello();
}
```
