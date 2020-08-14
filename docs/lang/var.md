## Data types

C++ has six basic built-in data types:

| Type   |  Keyword  |
| ---- | ------ |
| Boolean  | bool   |
| Character  | char   |
| Integer   | int  |
| Floating point | float  |
| Double floating point | double |
| Void | void   |

| Type   | Number of bytes  | Size                                              |
| ------ | ----- | ----------------------------------------------- |
| char   | 1 byte | -128 ~ 127 or 0 ~ 255                           |
| int    | 4 bytes | -2147483648 ~ 2147483647( $2^{31} - 1$ )        |
| float  | 4 bytes |  $-3.4\times 10^{38}$ ~ $3.4\times 10^{38}$     |
| double | 8 bytes |  $-1.7\times 10^{-308}$ ~ $1.7\times 10^{308}$  |

Some basic types can be modified with one or more type specifiers, such as `signed` and `unsigned` indicate whether the modified number has a sign; `short` and `long` indicate the length of the type, that is, the range the type can represent. In addition, there are some other specifiers such as `const`, which can be used to describe some more complicated situaions. We will explain in details below.

## Variable declaration

Declare using keywords with variable names.

```c++
int oi;
double wiki;
char org = 'c';
```

In the code segment we have seen so far, the variables declared in the curly braces are local variables, and the variables declared without curly braces are global variables. There are actual exceptions, but you don't need to understand right now.

声明时没有初始化值的全局变量会被初始化为 0。而局部变量没有这种特性，需要手动赋初始值，否则可能引起难以发现的 bug。
Global variables that have no initial value at the time of declaration will be initialized to 0. However, local variables do not have this feature and need to manually assign initial values, otherwise it may cause bugs that are difficult to find.

## Variable scope

A scope is a block of code where a variable can function properly.

Variables are divided into global variables and local variables. We have explained their meaning above.

The scope of a global variable is the entire file. Once a global variable is declared, it is available in the entire program.

The scope of a local variable is the code block where the statement is declared, and it can only be used by the statement inside the function or the code block.

Several statements enclosed by a pair of braces form a code block.

```c++
int g = 20;  // declare global variables
int main() {
  int g = 10;         // declare local variables
  printf("%d\n", g);  // output g
  return 0;
}
```

In a code block, local variables will overwrite global variables with the same name. For example, the output g of the above code is 10 instead of 20. In order to prevent unexpected errors, please try to avoid using the same name for local and global variables.

## Constant

Constants are fixed values and will not change during program execution.

The value of a constant cannot be modified after it is defined. Just add a `const` keyword in the declaration.

```c++
const int a = 2;
a = 3;
```

If the value of the constant is modified, an error will be reported during the compilation process: `error: assignment of read-only variable‘a’`.
